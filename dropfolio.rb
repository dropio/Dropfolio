require 'rubygems'
require 'sinatra'
require 'erb'
require 'dropio'

configure do
  Dropio.api_key = "8092bd8653834c2d052d31fbc617448c87343052"
end

get '/' do
  ""
end