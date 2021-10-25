require 'gossip'
require 'csv'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  get '/gossips/:id/' do
    id = params["id"].to_i
    url = "/"
    erb :show, locals: {author: Gossip.all[id].author, content: Gossip.all[id].content, id: id, url: url}
  end

  get '/gossips/:id/edit/' do
    id = params["id"].to_i
    erb :edit, locals: {author: Gossip.all[id].author, content: Gossip.all[id].content, id: id}
  end

  post '/gossips/:id/edit/' do
    author = params["gossip_author"] 
    content =  params["gossip_content"]
    id = params["id"].to_i
    Gossip.new(author, content).edit(id)
    redirect "/"
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect "/"
  end 
end 