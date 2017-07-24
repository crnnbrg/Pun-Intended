require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @puns = Pun.all
  erb(:index)
end

post '/puns' do
  @pun = Pun.new(pun: params.fetch('pun_body'), upvote: nil, downvote: nil, author_id: params.fetch('user_name'))
  if @pun.save
    redirect '/'
  else
    redirect '/error'
  end
end

get '/puns/:id' do
  @pun = Pun.find(params.fetch('id').to_i)
  erb(:pun)
end

patch '/puns/:id/edit' do
  @pun = Pun.find(params.fetch('id').to_i)
  @pun.update(pun: params.fetch('pun_body'))
  redirect '/'
end

delete '/puns/:id' do
  @pun = Pun.find(params.fetch('id').to_i)
  @pun.destroy
  redirect '/'
end

get '/error' do
  erb(:error)
end

get '/about' do
  erb(:about)
end
