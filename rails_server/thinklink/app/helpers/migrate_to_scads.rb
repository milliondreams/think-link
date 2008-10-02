
require 'datastore.rb'

module Migrate
	def migrate_to_scads
		migrate_users
		migrate_snippets
		migrate_claims
		migrate_topics
		migrate_claim_connections
		migrate_snippet_connections
		migrate_topic_connections
		migrate_claim_topic_connections
	end

	def migrate_users
		sql_select_all "SELECT * FROM users" do |user|
			id = $store.add_user email,name,password
			set_newid user.id, id, :user
		end
	end
	
	def migrate_snippets
		snippets = sql_select_all("SELECT * FROM snippets")
		snippets.each do |snippet|
			id = $store.add_snippet snippet.txt, snippet.url, snippet.realurl,snippet.pagetitle
			set_newid snippet.id, id, :snippet
		end
	end

	def migrate_claims
		sql_select_all "SELECT * FROM points" do |claim|
			id = $store.add_node point.txt,:claim,get_newid(claim.user_id, :user)
			set_newid claim.id, id, :claim
		end
	end
	
	def migrate_topics
		sql_select_all "SELECT * FROM topics" do |topic|
			id = $store.add_node topic.txt,:claim,get_newid(topic.user_id, :user)
			set_newid topic.id, id, :topic
		end
	end
	
	def migrate_claim_connections
		sql_select_all "SELECT * FROM point_links" do |link|
			$store.add_link get_newid(link.point_a_id,:claim),link.howlinked,get_newid(link.point_b_id,:claim)
		end
	end
	
	def migrate_snippet_connections
		sql_select_all "SELECT * FROM snippets" do |snippet|
			$store.add_link get_newid(snippet.id,:snippet),"states",get_newid(snippet.point_id,:claim)
		end
	end
	
	def migrate_topic_connections
		sql_select_all "SELECT * FROM topic_links" do |link|
			$store.add_link get_newid(link.parent_id,:topic),"subsumes",get_newid(link.child_id,:topic)
		end
	end
		
	def migrate_claim_topic_connections
		sql_select_all "SELECT * FROM point_topics" do |link|
			$store.add_link get_newid(link.point_id,:claim),"about",get_newid(link.topic_id,:topic)
		end
	end	
		
	def set_newid (oldid,newid,type)
		$base.batch_insert :compatmap,oldid,type => {:id => newid}
	end
	
	def get_newid (oldid,type)
		$base.get_column :compatmap,oldid,type,:id
	end
	
end

#TODO, normurl can be recomputed as a batch process occasionally, when our algorithm changes
#this should be derived data
#the only data we should add immediately is the data that came in -> the real url and the text
#want to keep the rule that all data access is through datastore, so we know what our entire model is

#for "realurl" should the "realness" be done on the server, or on the client?
#want to adopt the policy that only "real" data is stored directly. Derived data is computed using derived
#indexes - including normalized urls

#do we care what user created a point? Yes. Because they can delete it immediately if nobody else bookmarked it

#links should have creators and weights, just like any other object
#any object should have a rating, whether it is a link, an object, or a user

