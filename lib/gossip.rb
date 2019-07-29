require_relative 'gossip'
require 'pry'
require 'sinatra'
require 'csv'


class Gossip

	attr_accessor :author, :content

# --------------------

	def initialize(author, content)
  	@author = author
  	@content = content
	end # fin méthode initialize

# --------------------	

	def save
    CSV.open("./db/gossip.csv", "a") do |csv|
      csv << [@author, @content]
    end
	end # fin méthode save

# --------------------  

  def self.update(gossip_new_content, id)

    id = id.to_i

    all_gossips_array = []

    # on enregistre toutes les lignes du csv dans un array
    all_gossips_array = Gossip.all

    # on recharge l'array de gossip en modifiant seulement le contenu du gossip n° id
    csv = CSV.open("./db/gossip.csv", "w")
    all_gossips_array.each_with_index do |gossip, index|
      if index == id
        gossip.content = gossip_new_content
      end
      CSV.open("./db/gossip.csv", "a") do |csv|
        csv << [gossip.author, gossip.content]
      end
    end

  end # fin méthode update

# --------------------		

  def self.find(id)

    id = id.to_i

    all_gossips_array = Gossip.all

    my_gossip_id = all_gossips_array[id]

    return my_gossip_id 

  end # fin méthode find

# --------------------  

  def self.all

    all_gossips_array = []

    CSV.open("./db/gossip.csv", "r").each do |csv_line|
      gossip_provisoire = Gossip.new(csv_line[0], csv_line[1]) # permet de créer un objet gossip
      all_gossips_array << gossip_provisoire # permet de rajouter le gossip provisoire au array
    end

    return all_gossips_array # on renvoie le résultat


  end # fin méthode all

# --------------------


end # fin class Gossip

