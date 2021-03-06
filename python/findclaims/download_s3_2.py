"""
Given a list of URLs, download the first 400k of each URL, and then save
every string that contains a known pattern.
We do not bother to strip out HTML, and divide URLs by pattern.

URLs may come from a database, or simply from a file with a big list of URLs.
"""

from nlptools import remove_exact_duplicates, csv_writer, trim_to_words
from nlptools import normalize_space
import urllib2
import threading
import socket
import urllib
from urllib2 import URLError
import os
import re
import random
import secret as s
import fileinput
import S3
import hashlib
import time
import threading

conn = S3.AWSAuthConnection(s.amazon_access,s.amazon_secret)

num_threads = 200

urls = []
downloaded = {}

def download_urls():
	threads = []
	for num in range(0,num_threads):
		t = DownloadThread() 
		t.start()
		threads.append(t)
	for t in threads:
		t.join()

totaldownloaded = 0	
totalfiles = 0
timeouts = 0

started = None


def download_loop():
	global totaldownloaded
	global totalfiles
	global urls
	global timeouts 
	global started
	backoff = 0
	while len(urls) > 0:		
		if backoff > 0:
			time.sleep(backoff)
		url = urls.pop()
		if url.endswith("pdf"): continue
		try:
			if not started:
				started = time.time()
			content = urllib2.urlopen(url,None,4).read(400000)
			hsh = hashlib.md5(url).hexdigest()
			conn.put("claimfinder-pages",hsh,content)
			totaldownloaded += len(content)
			totalfiles += 1
			rate = totalfiles/(time.time()-started)
			if totalfiles % 10 == 0:
				print "rate:",rate,"size:",len(content),"avg:",(totaldownloaded/totalfiles),"tot:",totaldownloaded,"cnt:",totalfiles,"tmo:",timeouts,"url:",url[:50]
				if backoff > 0:
					backoff -= 1
		except URLError as e:
			if hasattr(e,"reason"):
				print "error:",e.reason,"-",url
			timeouts += 1	
		except Exception as e:
			print "unknown error:",url
			backoff += 1
			print "backoff =",backoff
			print e

class DownloadThread(threading.Thread):
	"""Find patterns in urls"""
	def run(self):
		print "thread running"
		download_loop()	
		print "thread finished"


urlpat = re.compile("http://([^/]*)/")

def gethost(url):
	m = urlpat.match(url)
	if m:
		return m.group(1)
	else:
		return None

# data should have been shuffled in advance
def main():
	global urls
	urls = [line.strip() for line in fileinput.input()]
	download_urls()

if __name__ == "__main__":
	main()
