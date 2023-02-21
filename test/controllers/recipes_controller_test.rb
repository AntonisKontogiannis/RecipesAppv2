require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = recipes(:one)
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_url
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post recipes_url, params: { recipe: { difficulty: @recipe.difficulty, excecution_time: @recipe.excecution_time, for_review: @recipe.for_review, from_admin: @recipe.from_admin, instructions: @recipe.instructions, name: @recipe.name, orient: @recipe.orient, photo: @recipe.photo, portions: @recipe.portions, shape: @recipe.shape } }
    end

    assert_redirected_to recipe_url(Recipe.last)
  end

  test "should show recipe" do
    get recipe_url(@recipe)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_url(@recipe)
    assert_response :success
  end

  test "should update recipe" do
    patch recipe_url(@recipe), params: { recipe: { difficulty: @recipe.difficulty, excecution_time: @recipe.excecution_time, for_review: @recipe.for_review, from_admin: @recipe.from_admin, instructions: @recipe.instructions, name: @recipe.name, orient: @recipe.orient, photo: @recipe.photo, portions: @recipe.portions, shape: @recipe.shape } }
    assert_redirected_to recipe_url(@recipe)
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete recipe_url(@recipe)
    end

    assert_redirected_to recipes_url
  end
end
