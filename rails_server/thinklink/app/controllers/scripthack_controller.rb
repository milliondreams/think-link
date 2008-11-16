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

#  This controlled is used for operations that need to use the scripthack trick to 
#  perform an action with a GET request. Currently only needed for snippet creation.

require 'ruby-debug'

class ScripthackController < ApplicationController
	def newsnippet
		@user = get_user
		if @user['id'] == 0
			emit :error => 'not logged in'
		else
			snipid = $store.add_snippet params[:text],params[:url],params[:realurl],params[:title],@user['id']
			$store.add_link snipid, 'created by', @user['id']		
			emit :id => snipid
		end 
	end
end


