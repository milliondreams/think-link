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

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
			t.column :email, :string, :limit =>32, :null => false
			t.column :password, :string, :limit =>32, :null => false
			t.column :secret, :string, :limit => 32, :null => false
			t.column :status, :string, :limit => 4, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
