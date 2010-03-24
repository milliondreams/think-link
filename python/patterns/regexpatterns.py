"""
Use a simple regex grammar to generate all the linguistic patterns
that we look for.
"""

import re
from nlptools import normalize_text
import nlptools.boss as boss
import nlptools.urlcache as uc
from nlptools.xmltools import XML
import time

class Choice:
	items = []
	def __init__(self,items):
		self.items = items
		
class Opt:
	item = None
	def __init__(self,item):
		self.item = item

def regex_choice(words): return "(" + "|".join(words) + ")"

def regex(obj):
	if obj.__class__ == list:
		return "\s*".join([regex(x) for x in obj])
	elif obj.__class__ == str:	
		return obj
	elif obj.__class__ == Opt:
		return "("+regex(obj.item)+")?"
	elif obj.__class__ == Choice:
		return "("+"|".join([regex(x) for x in obj.items])+")"
	else:
		raise "can't make regex"

def allstrings(obj):
	"""list of all strings a regex can expand to. Ignore Opt for the moment."""
	if obj.__class__ == list:
		return combos([allstrings(x) for x in obj if x.__class__ != Opt])
	elif obj.__class__ == str:
		return [obj]
	elif obj.__class__ == Opt:
		return [""]
	elif obj.__class__ == Choice:
		return sum([allstrings(x) for x in obj.items],[])
	else:
		raise "not a valid regex"
	
		
		
def combos(multilist):
	""" given a list of lists, return all flattened lists"""
	if len(multilist) == 0:
		return [""]
	else:
		return [normalize_text(head + " " + tail) for head in multilist[0] for tail in combos(multilist[1:])]
	

def regex_option(words): return "(" + "|".join(words) + ")"


claim = Choice(["claim", "idea", "belief", "notion","rumor","assertion","suggestion"])

falseclaim = Choice([
	"delusion","misconception","lie","hoax","scam",
	"misunderstanding","myth","urban legend","urban myth",
	"fabrication","deceit","fallacy",
	"deception","fraud","swindle","fiction","fantasy"])
	
refute = Choice([
	"refute", "refuting", "refuted", "refutation of",
	"rebut", "rebutting", "rebutted",
	"debunk", "debunking", "debunked",
	"discredit", "discrediting", "discredited",
	"disprove", "disproving", "disproved",
	"invalidate", "invalidating", "invalidated",
	"counter", "countering", "countered",
	"give the lie to","disagree with","absurdity of",
	"contrary to","against"
	])

claiming = Choice(["claiming","asserting","thinking"])
badly = Choice(["falsely","wrongly","stupidly","erroneously","incorrectly"])

think = Choice(["think","believe","claim","assert","argue"])
thought = Choice(["thought","believed","claimed","asserted"])

crazies = Choice(["crazies","idiots","fanatics","lunatics","morons",
		"crackpots","cranks","loons","nuts","wingnuts","wackos",
		"bigots"])
who = Choice(["who","that"])

believing = Choice(["believing","thinking"])

good = Choice(["acceptible","credible","serious","scientific"])
claim_modifier = Choice(["popular", "widespread", "oft repeated"])
false_modifier = Choice(["false","bogus","disputed","misleading","fake","mistaken"])
false = Choice(["not true","false","a lie","a myth"])
ofcourse = Choice(["of course","obviously"])

recog_false = ["the",falseclaim,Opt("is")]
recog_mod = [false_modifier,claim,Opt("is")]
recog_refute = [refute,"the",Opt(claim_modifier),claim]
recog_nogood = ["no",good,"evidence"]
recog_not = ["it is",false,Opt(ofcourse)]
recog_ing = [badly,claiming]
recog_think = [badly,think]
recog_ed = [badly,thought]
recog_crazies = [crazies,who,think]
recog_crazing = [crazies,claiming]
recog_into = ["into",believing]

recog_all = [Choice([
		recog_false,recog_mod,recog_refute,recog_nogood,
		recog_not,recog_ing,recog_think,recog_ed,recog_crazies,
		recog_crazing,recog_into]),"that"]

regex_all = re.compile(regex(recog_all))
			
strings_all = allstrings(recog_all)			
				

def boss_counts_for_pattern(pattern):
	"""get the total number of hits for a pattern, and also download the first 50"""
	url = boss.get_boss_url('"'+pattern+'"',0,50)
	dom = XML(uc.get_cached_url("boss",url))
	hitcount = dom.find("resultset_web").attr("totalhits")
	return int(hitcount)

def boss_results_for_pattern(pattern):
	return boss.get_boss_all('"'+query+'"')

def counts_for_all():
	"""download BOSS results for all of our search strings"""
	for pattern in strings_all:
		uc.downloaded = False
		count = boss_counts_for_pattern(pattern)
		print pattern,":",count
		if uc.downloaded:
			time.sleep(2)

def boss_for_all():
	"""download BOSS results for all of our search strings"""
	for pattern in strings_all:
		uc.downloaded = False
		print "--- "+pattern+" ---"	
			
	
# refuteterms = allforms(refutewords) + refuteother


# what we look for is
# pattern Wiki-verified-unambiguous-noun bla

# e.g. the swingle that Barack Obama ...
# this gives us both disambiguation, and well-formedness in one go
#
# excludes rubish like "the hoax that won't go away"
# and "the false claim that he didn't do it"

# recognizer vs search term
# for recognizer, might be better to use wordnet and stemmer to get better
# accuracy. For searching Yahoo BOSS, we do need to trim back to credible things.
# search for each combination and see which is frequent.
