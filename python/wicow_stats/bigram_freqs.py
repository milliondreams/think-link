#!/usr/bin/env python
# encoding: utf-8

"""
Count how frequent each noun is.
Processes the output from good_nouns.
"""

import fileinput
import operator as op
import nltk

freqs = {}

stopwords = ["s",'"',"way","t","fact","more","day","people","best","something","person"]

def count_nouns(nouns):
	for noun in nouns:
		noun = noun.replace("\t","").replace("\s","").replace("\n","")
		if not (noun in stopwords) and noun.replace(" ","").isalpha():
			freqs[noun] = freqs.get(noun,0) + 1

def sorted_freqs():
	return sorted(freqs.iteritems(),key=op.itemgetter(1),reverse=True)

def drop_html(nouns):
	if "<" in nouns:
		return nouns[0:nouns.index("<")]
	else:
		return nouns
	

def main():
	for line in fileinput.input():
		if not ("<" in line): 
#			words = line.split("\t")[0].split(" ")
			bigrams = [noun for noun in line.split("\t")[1:] if " " in noun]  
			#words = line.split("\t")[1:]
			#bigram_tuples = nltk.util.bigrams(words)
			#bigrams = [" ".join(tuple) for tuple in bigram_tuples]
			count_nouns(bigrams)
	freqs = sorted_freqs()
	for k,v in freqs:
# 		if(v > 4):
		print k+"\t"+str(v)

if __name__ == '__main__':
	main()
