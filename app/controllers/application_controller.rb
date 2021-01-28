
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do 
    @articles = Article.all 
    erb :index
  end 

  get '/articles/:id/edit' do 
    find_article
    erb :edit 
  end 

  post '/articles' do 
    @article = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{Article.last.id}"
  end 

  patch '/articles/:id' do
    find_article
    @article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"   
  end 

  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show 
  end 
  
  delete '/articles/:id' do
    find_article
    @article.destroy
    redirect "/articles"
  end

  def find_article
    @article = Article.find(params["id"])
  end
end
