require 'pg'
require_relative "recipe"

class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  #query database
  #return an array of Ingredient objects
  #Ingredient object must contain:
        # 1) ingredient name
        # 2) recipe_id

  def initialize(id, ingredient_name, recipe_id)
    @id = id
    @ingredient_name = ingredient_name
    @recipe_id = recipe_id
  end

  #returns name of ingredient, to be accessed in Recipe class
  def ingredient_name
    @ingredient_name
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







