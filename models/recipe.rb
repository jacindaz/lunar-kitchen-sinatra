require 'pg'
require_relative "ingredient"

class Recipe

  #query database
  #return an array of Recipe objects
  def initialize(id, name, description, instructions)
    def db_connection
      begin
        connection = PG.connect(dbname: 'recipes')
        yield(connection)
      ensure
        connection.close
      end
    end

    @id = id
    @name = name
    @description = description
    @instructions = instructions
  end

  #return an array of Recipe objects
  def self.all
    recipe_query = "SELECT id, name, description, instructions
                    FROM recipes"

    @recipes = db_connection do |conn|
      conn.exec(recipe_query)
    end
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
