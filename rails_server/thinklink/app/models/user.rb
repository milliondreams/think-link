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

class User < ActiveRecord::Base
#	has_many :points
	has_many :snippets, :order => "id DESC"
#	has_many :points, :through => :snippets, :uniq => true, :order => "created_at DESC"
	has_many :bookmarks, :order =>"id DESC"
	has_many :deletions
	has_many :point_deletions
	has_many :topics, :order => "id DESC"
	
	validates_uniqueness_of :email
	validates_confirmation_of :password
	validates_presence_of :email
	
	def displayname
	  if (!self.name.empty?)
	    return self.name
	  else
	    return self.email
	  end
	end
	
	def points
		return Point.find_by_sql("SELECT * FROM snippets,points WHERE snippets.point_id = points.id AND snippets.user_id = #{self.id} GROUP BY points.id ORDER BY snippets.id DESC");		
	end

	def mypoints
	return Point.find_by_sql("
		SELECT points.id, points.txt, points.user_id FROM snippets,points,bookmarks
			WHERE snippets.point_id = points.id 
			AND (bookmarks.snippet_id = snippets.id OR snippets.user_id = #{self.id})
			AND bookmarks.user_id = #{self.id}
			GROUP BY points.id 
			ORDER BY snippets.id DESC		
		");
	end

	def notmypoints
	return Point.find_by_sql("
		SELECT points.id, points.txt, points.user_id FROM points 
		WHERE points.id NOT IN (
			SELECT points.id FROM snippets,points,bookmarks
				WHERE snippets.point_id = points.id 
				AND (bookmarks.snippet_id = snippets.id OR snippets.user_id = #{self.id})
				AND bookmarks.user_id = #{self.id}
			)
		AND points.txt != ''
		ORDER BY points.id DESC
		");
	end

	
	def points_for_topic(topic)
	return Point.find_by_sql("
		SELECT points.id, points.txt, points.user_id FROM snippets,points,bookmarks,point_topics,topic_equivs
			WHERE snippets.point_id = points.id 
			AND (bookmarks.snippet_id = snippets.id OR snippets.user_id = #{self.id})
			AND point_topics.point_id = points.id
			AND (point_topics.topic_id = #{topic.id} 
				OR (point_topics.topic_id = topic_equivs.topic_a_id AND topic_equivs.topic_b_id = #{topic.id})
				OR (point_topics.topic_id = topic_equivs.topic_b_id AND topic_equivs.topic_a_id = #{topic.id})
				)
			AND bookmarks.user_id = #{self.id}
			GROUP BY points.id 
			ORDER BY snippets.id DESC		
		");
	end
		
	def points_notmine_for_topic(topic)
	return Point.find_by_sql("
		SELECT points.id, points.txt, points.user_id FROM points,point_topics,topic_equivs 
		WHERE points.id = point_topics.point_id
		AND (point_topics.topic_id = #{topic.id} 
				OR (point_topics.topic_id = topic_equivs.topic_a_id AND topic_equivs.topic_b_id = #{topic.id})
				OR (point_topics.topic_id = topic_equivs.topic_b_id AND topic_equivs.topic_a_id = #{topic.id})
				)
		AND points.id NOT IN (
			SELECT points.id FROM snippets,points,bookmarks,point_topics,topic_equivs
				WHERE snippets.point_id = points.id 
				AND (bookmarks.snippet_id = snippets.id OR snippets.user_id = #{self.id})
				AND point_topics.point_id = points.id
				AND (point_topics.topic_id = #{topic.id} 
					OR (point_topics.topic_id = topic_equivs.topic_a_id AND topic_equivs.topic_b_id = #{topic.id})
					OR (point_topics.topic_id = topic_equivs.topic_b_id AND topic_equivs.topic_a_id = #{topic.id})
				)
		AND bookmarks.user_id = #{self.id} 
		GROUP BY points.id
		)
		GROUP BY points.id");
	end	
		
	def recenttopics

		return Topic.find_by_sql("
		SELECT topics.txt, topics.id, topics.user_id, topics.created_at, MAX(topicviews.id) AS viewid
			FROM topics, topicviews
			WHERE topicviews.user_id = #{self.id}
			AND topicviews.topic_id = topics.id
			GROUP BY topics.id
			ORDER BY viewid DESC");
	
#		return Topic.find_by_sql("
#		SELECT topics.txt, topics.id, topics.user_id, topics.created_at, MAX(snippets.id) AS snipid
#			FROM topics, point_topics, snippets
#			WHERE snippets.point_id = point_topics.point_id
#			AND point_topics.topic_id = topics.id
#			AND snippets.user_id =1
#			GROUP BY topics.id
#			ORDER BY snipid DESC");
#			
#		return Topic.find_by_sql("
#			SELECT * FROM topics WHERE
#			id IN (
#				SELECT point_topics.topic_id FROM point_topics,snippets 
#				WHERE snippets.user_id = #{self.id}
#				AND point_topics.point_id = snippets.point_id 
#			)			
#			ORDER BY id DESC
#		");
	end	
		
#	def recenttopics
#	  topics = Array.new
#	  pt = PointTopic.find(:all, :conditions=>"user_id=#{self.id}", :order=> "point_id DESC") # point-topics i connected
#	  snips = self.snippets
#	  snips.each do |s|
#	    point = s.point
#	    pt.concat(PointTopic.find(:all, :conditions=>"point_id=#{point.id}", :order=> "point_id DESC")) # point-topics i contributed snippet to
#	  end
#		pt.each do |p|
#		  topics.push(p.topic)
#		end
#		return topics.uniq
#	end
	
#	def snippets
#	  snips = Array.new
#	  self.bookmarks.each do |b|
#	    snips.push(Snippet.find(b.snippet_id))
#    end
#	  snips = snips.concat(Snippet.find(:all, :conditions=>"user_id=#{self.id}", :order=>"created_at DESC"))
#	  snips.delete_if { |s|
#	    s.isdeleted(self) || s.isdeletedall
#	  }
#    return snips.uniq
#	end

end
