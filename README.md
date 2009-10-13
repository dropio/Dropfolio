Dropfolio
=========

A simple portfolio app for small selections of images/movies/documents (whatever!) built using the drop.io Ruby API. It is a Sinatra App, which allows for easy readability of the whole codebase in a single controller-type file, with a couple of views for the HTML and Javascript.  (Take a look at dropfolio.rb for all the meaty drop.io related stuff)

Initial Configuration
---------------------
Configuration is easy, just head over to [http://api.drop.io](http://api.drop.io) and grab a free developer key.  Enter this key in dropfolio.rb where it says:

    Dropio::Config.api_key = "ENTER_YOUR_DROPIO_API_KEY_HERE" # go to http://api.drop.io to get a free developer key
    
Heroku
------
This project already has a config.ru file for easy deployment to Heroku.  For more info on how easy it is to hack on Heroku running Sinatra, check out [this post](http://blog.heroku.com/archives/2009/3/5/32_deploy_merb_sinatra_or_any_rack_app_to_heroku/) from the folks at Heroku.  Sah-weet!