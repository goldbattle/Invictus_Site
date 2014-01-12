class StaticPagesController < ApplicationController

  def index_main
    # Info image path    
    images = Dir.glob("app/assets/images/main/info/*.png")
    @random_images = []
    # Get 3 images
    for i in 1..3
      ran_num = rand(images.length-1)
      temp = images.delete_at(ran_num)
      # Only need main image file
      temp = "main/info/#{ File.basename(temp) }"
      # Add to the list
      @random_images.push(temp)
    end

  end

  def index_downloads
    # Static Downloads Page
  end

  def index_about
    # Static About Us Page
  end

  def git_revisions
    # You should not be here, send to web
    redirect_to revisions_web_path
  end

  def git_revisions_web
    http_url = "https://api.github.com/repos/goldbattle/Invictus_Site/commits"
    @data = http_catch(http_url,'web')
  end

  def git_revisions_vanilla
    http_url = "https://api.github.com/repos/InvictusGraphics/Invictus_Textures/commits"
    @data = http_catch(http_url,'vanilla')
  end
  
  def git_revisions_modded
    http_url = "https://api.github.com/repos/Soartex-Modded/Modded-1.6.x/commits"
    @data = http_catch(http_url,'modded')
  end

private
  # This method caches the http request for the github api.
  def http_catch(http_url, cache_key)
    #Rails.cache.clear
    Rails.cache.fetch(cache_key, :expires_in => 10.minutes) do
      require 'net/http'
      require 'net/https'
      require 'uri'
      uri = URI.parse(http_url)
      http = Net::HTTP.new(uri.host, uri.port)
      # Security, change when you get to a server
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # Send in a GET request for information
      request = Net::HTTP::Get.new(uri.request_uri)
      # Lets authenticate to get private repos
      request.basic_auth(APP_CONFIG['github_username'], APP_CONFIG['github_password'])
      # Get the response, and convert
      response = http.request(request)
      # Return the Decoded Json
      JSON.parse(response.body)
    end
  end
end
