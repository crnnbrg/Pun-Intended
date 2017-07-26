require 'bundler/setup'
require 'sinatra/base'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload '../lib/**/*.rb'
enable :sessions
# warden

get '/' do
  if session[:id] != nil
    @user = User.find(session[:id])
    if session[:id] == @user.id
      @user = User.find(session[:id])
      @puns = Pun.all
      erb(:index)
    end
  else
  erb(:register)
  end
end


post '/user/signup' do
  @user = User.new(username: params.fetch('username'), email: params.fetch('email'), password: params.fetch('password'))
  if @user.save
    session[:id] = @user.id
    redirect '/'
  else
    erb(:register)
  end
end

post '/user/login' do

  if @user = User.find_by(username: params.fetch('username'))
    session[:id] = @user.id
    redirect '/'
  else
    erb(:register)
  end
end

get '/user/logout' do
  session.clear
  redirect '/'
end

post '/puns' do
  @pun = Pun.new(pun: params.fetch('pun_body'), author_id: params.fetch('user_name'))
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

patch '/puns/:id/upvote' do
  @pun = Pun.find(params.fetch('id').to_i)
  @pun.upvote += 1
  @pun.save
  redirect '/'
end

patch '/puns/:id/downvote' do
  @pun = Pun.find(params.fetch('id').to_i)
  @pun.downvote += 1
  @pun.save
  redirect '/'
end

patch '/puns/:id/blonde' do
  pun = Pun.find(params.fetch('id').to_i)
  pun.blonde += 1
  pun.save
  redirect '/'
end

get '/about' do
  erb(:about)
end

get '/error' do
  erb(:error)
end
