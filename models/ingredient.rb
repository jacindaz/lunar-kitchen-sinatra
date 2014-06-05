class Ingredient

  #query database
  #return an array of Ingredient objects
  #Ingredient object must contain:
        # 1) ingredient name
        # 2) recipe_id

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
