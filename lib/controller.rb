require_relative 'gossip'
require 'pry'
require 'sinatra'
require 'csv'

class ApplicationController < Sinatra::Base
 
# --------------
# page d'accueil

  get '/' do
    erb :index, locals: {all_gossips_array: Gossip.all}
  end

# --------------
# page création d'un nouveau potin

  get '/gossips/new/' do
    erb :new_gossip
  end

# --------------
# enregistrement d'un nouveau potin

  post '/gossips/new/' do
  	Gossip.new(params["gossip_author"], params["gossip_content"]).save
  	redirect '/'
  end

# --------------
# page show d'un potin

  get '/show/:id' do
  	id_gossip_csv = params['id'].to_i
  	erb :show, locals: {my_gossip_id: Gossip.find(id_gossip_csv), my_id: params['id']}

  end

# --------------
# page modification d'un potin

  get '/gossips/:id/edit/' do
    erb :edit, locals: {my_id: params['id']}
  end

# --------------
# modifier un potin, params: gossip_new_content, id

  post '/gossips/update/' do
    Gossip.update(params['gossip_new_content'], params['id'])
    redirect '/'

  end

# --------------

end

