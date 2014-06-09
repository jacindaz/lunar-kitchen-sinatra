require 'pg'
require 'pry'
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

  attr_reader :id, :name, :description, :instructions, :ingredients

  #query database
  #return an array of Recipe objects
  def initialize(id, name, description, instructions, ingredients = nil)
    @id = id
    @name = name
    @description = description
    @instructions = instructions
    @ingredients = ingredients
  end

  def self.db_connection
    begin
      connection = PG.connect(dbname: 'recipes')
      yield(connection)
    ensure
      connection.close
    end
  end

  #return an array of Recipe objects
  def self.all
    recipe_query = "SELECT id, name, description, instructions
                    FROM recipes"
    @recipes_hash = db_connection do |conn|
      conn.exec(recipe_query)
    end

    @recipes = []

    @recipes_hash.each do |recipe|
      recipe_id = recipe["id"]
      name = recipe["name"]
      description = recipe["description"]
      instructions = recipe["instructions"]
      recipe_object = Recipe.new(recipe_id, name, description, instructions)
      @recipes << recipe_object
    end
    @recipes
  end

  def self.find(params_recipe_id)
    @params_recipe_id = params_recipe_id
    one_recipe_query = "SELECT id, name, description, instructions
                        FROM recipes WHERE id = $1"
    one_recipe_hash = db_connection do |conn|
      conn.exec_params(one_recipe_query, [@params_recipe_id])
    end

    id = one_recipe_hash[0]["id"]
    name = one_recipe_hash[0]["name"]
    description = one_recipe_hash[0]["description"]
    instructions = one_recipe_hash[0]["instructions"]


    ingredients_query = "SELECT id, name AS ingredient_name, recipe_id
                          FROM ingredients WHERE recipe_id = $1"
    ingredients_hash = db_connection do |conn|
      conn.exec_params(ingredients_query, [id])
    end

    @ingredients = []
    ingredients_hash.each do |ingredient|
      id = ingredient["id"]
      ingredient_name = ingredient["ingredient_name"]
      recipe_id = ingredient["recipe_id"]
      ingredient_object = Ingredient.new(id, ingredient_name, recipe_id)
      @ingredients << ingredient_object
    end

    @recipe = Recipe.new(id, name, description, instructions, @ingredients)
    @recipe
  end



end
