#!/usr/bin/env ruby

require "httparty"  
my_client_id="c0c429a5fef24a8198457f4043021a86"
user_to_search=ARGV[0]

instagram_id_hash = HTTParty.get("https://api.instagram.com/v1/users/search?q=#{user_to_search}&client_id=#{my_client_id}")
instagram_user_id = instagram_id_hash["data"][0]["id"]

w = HTTParty.get("https://api.instagram.com/v1/users/#{instagram_user_id}/media/recent/?client_id=#{my_client_id}&count=-1")

out_file = File.new("#{user_to_search}_photo_urls.txt", "w")
w["data"].length.times do 
	|i| out_file.puts w["data"][i]["images"]["standard_resolution"]["url"] 
end 
out_file.close