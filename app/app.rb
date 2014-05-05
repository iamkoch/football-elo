module Main
  class App < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :public_folder, "#{dir}/frontend/public"
    set :static, true

    get '/' do
      haml :intro
    end

    get '/:season/:division' do |season, division|
      @teams = Reader.new('www.football-data.co.uk', "/mmz4281/#{season}/#{division}.csv", season, division).process
      haml :index
    end
  end
end