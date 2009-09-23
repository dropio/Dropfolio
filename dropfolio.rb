$LOAD_PATH.unshift File.dirname(__FILE__) + "/dropio/lib"

require 'rubygems'
require 'sinatra'
require 'erb'
require 'dropio'
require 'digest/sha1'

# INITIALIZE THE APP

configure do
  Dropio::Config.api_key = "8092bd8653834c2d052d31fbc617448c87343052"
  SALT = "___changemetosomethingrandom___"
end

# URL ACTIONS

get '/' do
  erb :new
end

post '/' do
  @drop = Dropio::Drop.create()
  
  @drop.admin_password = generate_password(@drop.name)
  @drop.save
  
  redirect "/#{@drop.name}", 303
end

get '/:dropname/admin' do
  @drop = Dropio::Drop.find(params[:dropname], generate_password(params[:dropname]))
end

get '/:dropname/' do
  @drop = Dropio::Drop.find(params[:dropname])
  @upload_embed = @drop.upload_code
  @assets = @drop.assets
  erb :show, :layout => :application
end

get '/:dropname/items/:asset_number' do
  @drop = Dropio::Drop.find(params[:dropname])
  @drop.assets[params[:asset_number].to_i].embed_code
end

# HELPER FUNCTIONS

helpers do
  def generate_password(dropname)
    Digest::SHA1.hexdigest(dropname + SALT)[0...5]
  end
  
  def show_asset(asset)
    asset.thumbnail
  end
end
