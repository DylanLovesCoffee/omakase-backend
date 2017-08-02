class RecipesController < ActionController::API

  def index
    @recipes = Recipe.all

    render json: [
                    {
                  "id": 641803,
                  "title": "Easy & Delish! ~ Apple Crumble",
                  "image": "https://spoonacular.com/recipeImages/Easy---Delish--Apple-Crumble-641803.jpg",
                  "usedIngredientCount": 3,
                  "missedIngredientCount": 4,
                  "likes": 1
                },
                {
                  "id": 645152,
                  "title": "Grandma's Apple Crisp",
                  "image": "https://spoonacular.com/recipeImages/Grandmas-Apple-Crisp-645152.jpg",
                  "usedIngredientCount": 3,
                  "missedIngredientCount": 6,
                  "likes": 1
                },
                {
                  "id": 657563,
                  "title": "Quick Apple Ginger Pie",
                  "image": "https://spoonacular.com/recipeImages/Quick-Apple-Ginger-Pie-657563.jpg",
                  "usedIngredientCount": 3,
                  "missedIngredientCount": 6,
                  "likes": 1
                },
                {
                  "id": 639487,
                  "title": "Cinnamon Sugar Fried Apples",
                  "image": "https://spoonacular.com/recipeImages/Cinnamon-Sugar-Fried-Apples-639487.jpg",
                  "usedIngredientCount": 3,
                  "missedIngredientCount": 8,
                  "likes": 46
                },
                {
                  "id": 643426,
                  "title": "Fresh Apple Cake With Caramel Sauce",
                  "image": "https://spoonacular.com/recipeImages/Fresh-Apple-Cake-With-Caramel-Sauce-643426.jpg",
                  "usedIngredientCount": 3,
                  "missedIngredientCount": 12,
                  "likes": 9
                }
    ]
  end

  def search_results
    url = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients="
    ending = "&limitLicense=false&number=5&ranking=1"
    ingredients = params[:food]
    recipes = Unirest.get "#{url}#{ingredients}#ending",
    headers:{
      "X-Mashape-Key" => params[:api_key],
      "Accept" => "application/json"
    }

    recipes.body.each do |recipe|
      details_url = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/"
      details_ending = "/information?includenutrition=false"
      details_recipe_id = recipe[:id]
      response = Unirest.get "#{details_url}#{details_recipe_id}#{details_ending}",

      headers:{
        "X-Mashape-Key" => params[:api_key],
        "Accept" => "application/json"
      }
      recipe[:instructions] = response.body['instructions']
    end


    render json: recipes.body

  end

  def recipe_details
    details_url = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/"
    details_ending = "/information?includenutrition=false"
    details_recipe_id = params[:id]
    response = Unirest.get "#{details_url}#{details_recipe_id}#{details_ending}",

    headers:{
      "X-Mashape-Key" => params[:api_key],
      "Accept" => "application/json"
    }

    render json: response.body
  end
end
