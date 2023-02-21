require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase
  setup do
    @recipe = recipes(:one)
  end

  test "visiting the index" do
    visit recipes_url
    assert_selector "h1", text: "Recipes"
  end

  test "creating a Recipe" do
    visit recipes_url
    click_on "New Recipe"

    fill_in "Difficulty", with: @recipe.difficulty
    fill_in "Excecution time", with: @recipe.excecution_time
    check "For review" if @recipe.for_review
    check "From admin" if @recipe.from_admin
    fill_in "Instructions", with: @recipe.instructions
    fill_in "Name", with: @recipe.name
    fill_in "Orient", with: @recipe.orient
    fill_in "Photo", with: @recipe.photo
    fill_in "Portions", with: @recipe.portions
    fill_in "Shape", with: @recipe.shape
    click_on "Create Recipe"

    assert_text "Recipe was successfully created"
    click_on "Back"
  end

  test "updating a Recipe" do
    visit recipes_url
    click_on "Edit", match: :first

    fill_in "Difficulty", with: @recipe.difficulty
    fill_in "Excecution time", with: @recipe.excecution_time
    check "For review" if @recipe.for_review
    check "From admin" if @recipe.from_admin
    fill_in "Instructions", with: @recipe.instructions
    fill_in "Name", with: @recipe.name
    fill_in "Orient", with: @recipe.orient
    fill_in "Photo", with: @recipe.photo
    fill_in "Portions", with: @recipe.portions
    fill_in "Shape", with: @recipe.shape
    click_on "Update Recipe"

    assert_text "Recipe was successfully updated"
    click_on "Back"
  end

  test "destroying a Recipe" do
    visit recipes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recipe was successfully destroyed"
  end
end
