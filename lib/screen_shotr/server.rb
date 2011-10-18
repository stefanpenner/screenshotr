require 'sinatra'
require 'fog'
require 'digest/sha1'
java_import 'java.awt.datatransfer.StringSelection'

module ScreenShotr
  class Server < Sinatra::Base
    def storage
      #@storage ||= Fog::Storage.new({
      #  :provider => 'AWS',
      #  :aws_access_key_id => ACCESS_KEY_ID,
      #  :aws_secret_access_key => SECRET_ACCESS_KEY})

      @storage ||= Fog::Storage.new({
          :local_root => '~/fog',
          :provider   => 'Local'
      })
    end

    def directory
      storage.directories.find("data").first or storage.directories.create(:key => 'data' )
    end

    post '/picture/create' do
      file     = params[:file]
      data     = file[:tempfile]

      #super secure filename
      filename = file[:filename]

      key = Digest::SHA1.hexdigest("super random seed"+Time.now.to_s)
      key << '.jpg'

      file = directory.files.create(
        :body => data.read,
        :key  => key
      )
      file.public_url or "http://0.0.0.0:9292/picture/#{key}"
    end

    get '/picture/:key' do
      file = directory.files.get(params[:key])
      if url = file.public_url
        redirect_to url
      else
        send_file file.send(:path)
      end
    end
  end
end
