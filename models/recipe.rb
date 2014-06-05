require 'pg'
require_relative "ingredient"

class Recipe

  attr_reader :recipes

  #query database
  #return an array of Recipe objects
  def initialize(id, name, description, instructions)
    @id = id
    @name = name
    @description = description
    @instructions = instructions
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

  #returns id of recipe
  def id
    @id
  end

  #returns name of recipe
  def name
    @name
  end

  #return recipe description
  def description
    @description
  end

  #return recipe instructions
  def instructions
    @instructions
  end

  #returns an array of Ingredient objects
  def ingredients

  end


end
