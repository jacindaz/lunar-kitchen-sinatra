class Recipe

  #query database
  #return an array of Recipe objects
  def initialize(id, name, description, instructions)
    @id = id
    @name = name
    @description = description
    @instructions = instructions

  #return an array of Recipe objects
  def self.all
    recipe_query = "SELECT id, name, description, instructions
                    FROM recipes
                    "
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
