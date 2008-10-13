#  Copyright 2008 Intel Corporation
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# All data access must go in this file
# Every server request should perform all it's data access by calling ONE of these functions

#TODO track deletions
#TODO use denormalization to make get_links and url_snippets faster
#TODO search should use steming

require 'crapbase/crapbase_mysql'
# require 'json'

$bad_words = ["the","and","his","her","from","his","has","from","then","can","will","new","one","two","our"]

module Datastore
	include CrapBase

	def get_url_snippets(url)
		return get_all("url",url,"snippets")
	end
	
	def add_snippet (text,url,realurl,title,user)
		id = new_guid
		batch_insert :obj, id,
				:info => {:type => :snippet, :text => text, :url => url, :realurl => realurl, :title => title, :user => user} 
		return id
	end
	
	def get_user(email,password)		
		users = get_slice_json :email, email, :user, 0, 1
		if users.empty?
			return nil
		end
		user = users[users.keys.first]
		user['id'] = users.keys.first
		if user['password'] == password
			return user
		else
			return nil
		end
	end
	
	def claim_for_snippet(key)
		links = get_all_json :objgen,key,:links_from
		links.each do |key,value|
			value['verb'] = 'states'
			claim = value['object']
			info = get_all :obj,claim,:info
			props = get_all :objgen,claim,:props
			return {:id => value['object'], :text => info['text']}.merge(props)
		end
		return nil
	end
	
	# get all the snippets for a url, including the first claim for each snippet		
	def url_snippets(url)
		snips = get_all_json :url,url,:snippets
		out = []
		snips.each do |key,data|		
			out.push :text => data['text'], :id => key, :claim => claim_for_snippet(key)
		end
		return out
	end
		
	def log_view(userid,id)			
		now = Time.now.to_f
		insert :user,userid,:recent,(-now),id
	end
	
	def get_recent(userid)
		results = []
		recentids = get_slice :user,userid,:recent,0,50
		seen = {}
		recentids.each do |time,id|
			if !seen.has_key? id 
				seen[id] = true
				results.push get_info(id)
			end
		end
		return results
	end
		
	def add_node(text,type,user)  #claim or topic
		id = new_guid
		batch_insert :obj,id,:info => {:text => text, :type => type, :user => user}
		return id
	end
	
	def add_link(subject,verb,object)
		id = new_guid
		batch_insert :obj, id, :info => {:type => :link, :subject => subject, :verb => verb, :object => object}
		return id
	end
	
	def get_info(id)
		info = get_all :obj,id,:info
		props = get_all :objgen,id,:props
		return info.merge(props).merge('id' => id)
	end
	
	# get all the links to and from a snippet, and all the info for each of them
	def get_links(id)
		out = get_info id
		out['from'] = get_links_from id
		out['to'] = get_links_to id		
		return out
	end
	
	def get_links_to(id)
		to = get_all_json :objgen,id,:links_to
		links_to = {}
		to.each do |key,link|
			keypush links_to, link['verb'], get_info(link['subject'])
		end
		return links_to
	end
	
	def get_links_from(id)
		from = get_all_json :objgen,id,:links_from
		links_from = {}
		from.each do |key,link|
			keypush links_from, link['verb'], get_info(link['object'])
		end
		return links_from
	end
	
	def search(phrase)
		words = phrase.split ' '
		idscore = {}
		words.each do |word|
			if word.length > 2 && !$bad_words.include?(word)
				hits = get_all :word, word, :objects
				freq = hits.length
				hits.keys.each do |id|
					idscore[id] = (1.0/freq) + idscore.fetch(id,0)
				end
			end 
		end	
		results = []
		sorted = idscore.sort {|a,b| b[1] <=> a[1]}	
		sorted.each do |idrow|
			id = idrow[0]
			results.push get_info(id)
		end
		return results
	end
	
	
	def add_rating(id,user,rating)
		insert :obj,id,:ratings,user,rating
	end
	
	def add_user(email,name,password)
		id = new_guid
		batch_insert :obj, id, 
				:info => {:type => "user", :email => email, :name => name, :password => password}
		return id
	end
	
	def set_newid (oldid,newid,type)
		batch_insert :compatmap,oldid,type => {:id => newid}
	end
	
	def get_newid (oldid,type)
		get_column :compatmap,oldid,type,:id
	end


private	
	def keypush(hsh,key,val)
		if !hsh.has_key? key
			hsh[key] = []
		end
		hsh[key].push val
	end

	def get_tables
		return { 
			:obj => [:info, :ratings],
			:user => [:recent],				# in addition to stuff in :obj
			:objgen => [:links_from, :links_to, :props],
			:url => [:snippets],
			:email => [:user],
			:word => [:objects,:props],
			:compatmap => [:claim,:topic,:user,:snippet]
		}	
	end

	def delete_datastore
		delete_tables(get_tables()) 
	end

	def update_obj_links(key)
		links_to = get_all :objgen,key,:links_to
		links_to.each do |object,json|
			link = ActiveSupport::JSON.decode json
			update_link(key,{:object => object,:subject=>link[:subject],:verb => link[:verb]}) 
		end
		links_from = get_all :objgen,key,:links_from
		links_from.each do |subject,json|
			link = ActiveSupport::JSON.decode json
			update_link(key,{:object => object,:subject=>link[:subject],:verb => link[:verb]}) 
		end
	end

	def update_link(key,info)
		subjinfo = get_all :obj,info[:subject],:info
		subjprops = get_all :objgen,info[:subject],:props
		objinfo = get_all :obj,info[:object],:info
		objprops = get_all :objgen,info[:object],:props

		insert :objgen,info[:subject],:links_from,key,
			objprops.merge(:verb => info[:verb], :object=>info[:object], :text => objinfo['text'])
		insert :objgen,info[:object],:links_to,key,
			subjprops.merge(:verb => info[:verb], :subject=>info[:subject], :text => subjinfo['text'])
	end

	def initialize_datastore
		initialize_crapbase
	
		create_tables(get_tables())
				
		#url -> snippet info
		add_trigger :table => :obj, :family => :info, :column => :url do |table,key,values|
			info = values[:info]
			insert :url, info[:url], :snippets, key, info
		end
		
		#email -> user
		add_trigger :table => :obj, :family => :info, :column => :email do |table,key,values|
			info = values[:info]
			insert :email, info[:email], :user, key, info 
		end
		
		#link -> related objects for each linked object
		#ISSUE: this updates the link immediately, and so we may see stale data		
		add_trigger :table => :obj, :family => :info, :column => :verb do |table,key,values|
			info = values[:info]			
			insert :objgen,info[:subject],:links_from,key,info
			insert :objgen,info[:object],:links_to,key,info
		end


		#link -> mark item as being supported or opposed when link created
		add_trigger :table => :obj, :family => :info, :column => :verb do |table,key,values|
			info = values[:info]
			if info[:verb] == 'opposes'
				insert :objgen,info[:object],:props,:opposed,true
				dirty_object :obj,key,:links
			elsif 
				info[:verb] == 'supports'
				insert :objgen,info[:object],:props,:supported,true
				dirty_object :obj,key,:links
			end
		end
		
		#object -> index of words used in the name
		add_trigger :table => :obj, :family => :info, :column => :text do |table,key,values|
			if values[:info][:type] != :snippet			
				text = values[:info][:text]
				text.split(' ').each do |word|
					if word.length > 2 && !$bad_words.include?(word)
						insert :word,word,:objects,key,''
					end
				end
			end
		end
		
		#count number of uses of each word
		add_batch_trigger :table => :word, :family => :objects, :delay => 10 do |keys|
			keys.each do |key|
				count = get_column_count :word, key, :objects
				insert :word, key, :props, :frequency, count
			end
		end
		
		#delayed rating aggregation
		add_batch_trigger :table => :obj, :family => :ratings, :delay => 10 do |keys|
			keys.each do |key|
				ratings = get_all :obj,key,:ratings
				sum = 0
				count = 0
				ratings.each do |user,rating|
					sum += rating
					count += 1
				end
				insert :objgen,key,:props,:avg_rating,sum/count
			end
		end		
	end


	
	#need: no be able to update different parts of the YAML for a single snippet
	# with different queries
	#or just to be able to cluster different column groups so we know they can be
	#accessed efficiently at the same time
		
end
