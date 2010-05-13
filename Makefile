JAVA = java
EXTRACTCLAIMS = $(JAVA) com.intel.thinkscala.claimfinder.ExtractClaims
DEDUP = python web_claim_finder/drop_duplicate_claims.py
# GOOD = python web_claim_finder/drop_bad_claims.py
GOODNOUNS = python web_claim_finder/good_nouns.py
NOUNFREQS = python web_claim_finder/noun_freqs.py
POSTAG = python web_claim_finder/pos_tag.py
FILTER = python web_claim_finder/filter_claims.py
GETFULL = python python/wicow_stats/get_full_data.py

urls2009 = $(wildcard output/claimfinder/urlphrases_year/2009/*.urls)
urls2008 = $(wildcard output/claimfinder/urlphrases_year/2008/*.urls)
urls2007 = $(wildcard output/claimfinder/urlphrases_year/2007/*.urls)
urls2006 = $(wildcard output/claimfinder/urlphrases_year/2006/*.urls)
urlsyears = $(wildcard output/claimfinder/urlphrases_year/*/*.urls)
urlsdays = $(wildcard output/claimfinder/urlphrases_date/*/*.urls)
claimsdays = $(wildcard output/claimfinder/urlphrases_date/*/*.claims)
urlsjan312007days = $(wildcard output/claimfinder/urlphrases_date/January_31_2007/*.urls)

years = $(filter-out %.dedup %.good %.nouns,$(wildcard output/claimfinder/urlphrases_year/*))
days = $(filter-out %.fullgood %.filtered %.dedup %.good %.nouns %.freqs %.filtered,$(wildcard output/claimfinder/urlphrases_date/*))
claimdays = $(filter-out %.dedup %.good %.nouns %.freqs %.filtered,$(wildcard output/claimfinder/urlphrases_date/*))
jandays = $(filter-out %.dedup %.good %.nouns %.freqs %.filtered,$(wildcard output/claimfinder/urlphrases_date/January_*))
subdays = $(filter-out %.dedup %.good %.nouns %.freqs %.filtered,$(wildcard output/claimfinder/urlphrases_date/January_30_*))
phraseunique = $(wildcard output/claimfinder/phrases_joined/*.unique)

claims2009 = $(urls2009:.urls=.claims)
claims2008 = $(urls2008:.urls=.claims)
claims2007 = $(urls2007:.urls=.claims)
claims2006 = $(urls2006:.urls=.claims)
claimsyears = $(urlsyears:.urls=.claims)
claimsdays = $(urlsdays:.urls=.claims)
filtereddays = $(claimdays:.claims=.filtered)
claimsjan07 = $(urlsjan312007days:.urls=.claims)
posdays = $(urlsdays:.urls=.pos)
yeardedups = $(addsuffix .dedup,$(years))
yeargood = $(addsuffix .good,$(years))
daydedups = $(addsuffix .dedup,$(days))
daygood = $(addsuffix .good,$(claimdays))

#%.claims : %.urls
#	$(EXTRACTCLAIMS) $< $@

%.dedup : %
	$(DEDUP) $</*.claims > $@

%.nouns : %.dedup
	$(GOODNOUNS) $< > $@

%.dedup : %.claims
	$(DEDUP) $< > $@

%.fullgood : %.claims
	$(GETFULL) $< > $@

%.fullgood : %
	$(GETFULL) $</*.claims > $@

%.pos : %.dedup	
	$(POSTAG) $< > $@

%.good : %.dedup
	$(GOODNOUNS) $< > $@

%.filtered : %.claims
	$(FILTER) $< >$@

%.filtered : %
	$(FILTER) $</*.claims > $@
	
%.freqs : %.good
	$(NOUNFREQS) $< > $@
	
	
vars : 
	echo vars
	echo $(claims2009)
	
testclaims : output/claimfinder/urlphrases_first.claims
filtered : $(addsuffix .filtered,$(days))
2009claims : $(claims2009)
2008claims : $(claims2008)
2007claims : $(claims2007)
2006claims : $(claims2006)
yearclaims : $(claimsyears)
dayclaims : $(claimsdays)
dayfiltered : $(addsuffix .filtered,$(days))
dayfull : $(addsuffix .fullgood,$(days))
dayclaimsjan07 : $(claimsjan07)
# dayfiltered : $(filtereddays)
yeardedups : $(yeardedups)
daydedups : $(daydedups)
yeargood : $(yeargood)
daygood : $(daygood)
allgood : $(yeargood) $(daygood)
yearfreqs : $(addsuffix .freqs,$(years))
dayfreqs : $(addsuffix .freqs,$(days))
subdayfreqs : $(addsuffix .freqs,$(subdays))
janfreqs : $(addsuffix .freqs,$(jandays))
daypos : $(posdays)
patdedups : $(urlsdays:.urls=.dedup)

minigood = $(wildcard web_claim_finder/minidata/*.good)
minifreqs : $(addsuffix .freqs,$(miniyears))


