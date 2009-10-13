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
  erb :new, :layout => :application
end

post '/' do
  @drop = Dropio::Drop.create(:description => params[:description])
  
  @drop.admin_password = generate_password(@drop.name)
  @drop.save
  
  redirect "/#{@drop.name}?admin=true", 303
end

get '/:dropname' do
  @drop = Dropio::Drop.find(params[:dropname])
  @assets = @drop.assets
  if is_admin?
    @upload_embed = @drop.upload_code
  end
  erb :show, :layout => :application
end

# HELPER FUNCTIONS

helpers do
  
  def is_admin?
    @is_admin ||= (params[:admin] == 'true')
  end
  
  def generate_password(dropname)
    Digest::SHA1.hexdigest(dropname + SALT)[0...5]
  end
  
  def display_asset(asset)
    case asset.type
      when "image"
        "<img src='#{asset.converted || '/converting.png'}'/>"
      else
        asset.embed_code
    end
  end
  
end