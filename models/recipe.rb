require 'pg'
require 'pry'
require "sinatra/activerecord"

require_relative "ingredient"

class CreateRecipes < ActiveRecord::Migration
  def change
    create_table "recipes", force: true do |t|
      t.string :name
      t.string :description
      t.string :instructions
    end
  end
end

class Recipe < ActiveRecord::Base
  has_many :ingredients



end
