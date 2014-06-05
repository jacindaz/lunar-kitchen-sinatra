require 'pg'
require_relative 'recipe'

class Ingredient

  #query database
  #return an array of Ingredient objects
  #Ingredient object must contain:
        # 1) ingredient name
        # 2) recipe_id

  def initialize(id, name, recipe_id)
    @id = id
    @name = name
    @recipe_id = recipe_id
  end

  def self.db_connection
    begin
      connection = PG.connect(dbname: 'recipes')
      yield(connection)
    ensure
      connection.close
    end
  end

  def self.find
    ingredient_query = "SELECT id, name, recipe_id FROM recipes"
    @ingredients = db_connection do |conn|
      conn.exec(ingredient_query)
    end

    @ingredients = []

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

  #returns name of ingredient, to be accessed in Recipe class
  def name
    @name
  end

  #returns ingredient id
  def id
    @id
  end

  #returns recipe_id of that ingredient
  def recipe_id
    @recipe_id
  end

end







