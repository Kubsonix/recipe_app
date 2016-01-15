class UsersController < ApplicationController
  expose(:recipe)
  expose(:recipes)

  def about
    @user = current_user
    @recipes = current_user.recipes
  end

  def my_recipes
    @recipe = current_user.recipes
  end
end
