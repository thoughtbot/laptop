#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'date'

url = URI('https://raw.githubusercontent.com/nodejs/Release/master/schedule.json')
result = Net::HTTP.get(url)
lts = JSON.parse(result).select {|key, value| value.key?("lts") and Date.parse(value["start"]) < Date.today }
lts.each {|key, value| puts "node@#{key.gsub(/v/, '')}" }
