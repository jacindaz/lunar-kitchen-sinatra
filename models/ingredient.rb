require 'pg'
require_relative 'recipe'

class Ingredient

  #query database
  #return an array of Ingredient objects
  #Ingredient object must contain:
        # 1) ingredient name
        # 2) recipe_id

  def initialize(id, name, recipe_id)
    def db_connection
      begin
        connection = PG.connect(dbname: 'recipes')
        yield(connection)
      ensure
        connection.close
      end
    end

    ingredient_query = "SELECT id, name, recipe_id FROM recipes"

    @ingredients = db_connection do |conn|
      conn.exec(ingredient_query)
    end

    @id = id
    @name = name
    @recipe_id = recipe_id
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
