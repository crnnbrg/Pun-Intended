require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @puns = Pun.all
  @categories = Category.all
  erb(:index)
end

post '/puns' do
  @pun = Pun.new(pun: params.fetch('pun_body'), upvote: nil, downvote: nil, author_id: params.fetch('user_name'), category: params.fetch('category'), category_id: params.fetch('category_id'))
  if @pun.save
    redirect '/'
  else
    redirect '/error'
  end
end
post '/categories' do
  @category = Category.new(:category, params.fetch('category_body'))
  if @category.save
    redirect '/'
  else
    redirect '/error'
  end
end

get '/puns/:id' do
  @pun = Pun.find(params.fetch('id').to_i)
  erb(:pun)
end

get '/categories/:id' do
  @category = Category.find(params.fetch('id').to_i)
  erb(:category)
end

patch '/puns/:id/edit' do
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

delete '/categories/:id' do
  @category = Category.find(params.fetch('id').to_i)
  @pun = Pun.find(params.fetch('id').to_i)
  @category.destroy
  redirect '/'
end

get '/error' do
  erb(:error)
end

get '/about' do
  erb(:about)
end

get '/category' do
  erb(:category)
end
