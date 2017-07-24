require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @puns = Pun.all
  erb(:index)
end

post '/puns' do
  @pun = Pun.new(pun: params.fetch('pun'), upvote: nil, downvote: nil, author_id: nil)
  if @pun.save
    redirect '/'
  else
    redirect '/error'
  end
end

get '/error' do
  erb(:error)
end
