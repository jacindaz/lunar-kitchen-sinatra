require 'pg'


def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')

    yield(connection)

  ensure
    connection.close
  end
end


recipe_query = "SELECT id, name, description, instructions
                FROM recipes"

@recipes = db_connection do |conn|
  conn.exec(recipe_query)
end

@recipes[50].each do |key, value|
  puts "Recipes key: #{key}, value: #{value}"
end

puts "Recipes class: #{@recipes.class}"
puts @recipes.length

