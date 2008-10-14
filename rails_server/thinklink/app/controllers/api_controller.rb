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

#  This controller is used for API functions that don't really make sense as
#  operations on objects. Some of these should perhaps be somewhere else

class ApiController < ApplicationController

	def url_snippets
		urls = gather_urls
		snips = []
		urls.each do |url|
			snips.concat $store.url_snippets(url)
		end
		api_emit snips
	end
	
	def info
		api_emit $store.get_links(params[:id])
	end
	
	def search
		api_emit $store.search(params[:query])
	end
	
private

	def gather_urls
		count = 1
		urls = {}
		while params.has_key? "url#{count}".intern
			urls[params["url#{count}".intern]] = true
			count += 1
		end
		if params.has_key? :url
			urls[params[:url]] = true
		end
		return urls.keys
	end
	

end
