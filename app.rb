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
      @categories = Category.all
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
  user = User.find(params.fetch('user_id').to_i)
  @pun = Pun.new(pun: params.fetch('pun_body'), category_id: params.fetch('category_id'), user_id: user.id)
  if @pun.save
    redirect '/'
  else
    redirect '/error'
  end
end
post '/categories' do
  @category = Category.new(category: params.fetch('category_body'))
  if @category.save
    redirect '/category'
  else
    redirect '/error'
  end
end

get '/puns/:id' do
  @pun = Pun.find(params.fetch('id').to_i)
  @category = Category.find(@pun.category_id)
  erb(:pun)
end

get '/categories/:id' do
  @category = Category.find(params.fetch('id').to_i)
  @categories = Category.all
  @puns = Pun.all
  erb(:pun_list)
end

patch '/puns/:id/edit' do
  @category = Category.find(params.fetch('id').to_i)
  @pun = Pun.find(params.fetch('id').to_i)
  @pun.update(pun: params.fetch('pun_body'))
  redirect '/'
end

patch '/categories/:id/edit' do
  @category = Category.find(params.fetch('id').to_i)
  @category.update(category: params.fetch('pun_body'))
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
delete '/categories/:id' do
  @category = Category.find(params.fetch('id').to_i)
  @pun = Pun.find(params.fetch('id').to_i)
  @category.destroy
  @pun.destroy
  redirect '/category'
end

get '/error' do
  erb(:error)
end

get '/about' do
  erb(:about)
end

get '/category' do
  @categories = Category.all
  erb(:category)
end
