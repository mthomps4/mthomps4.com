require "application_system_test_case"

class LearningsTest < ApplicationSystemTestCase
  setup do
    @learning = learnings(:one)
  end

  test "visiting the index" do
    visit learnings_url
    assert_selector "h1", text: "Learnings"
  end

  test "should create learning" do
    visit learnings_url
    click_on "New learning"

    fill_in "Markdown", with: @learning.markdown
    check "Published" if @learning.published
    fill_in "Published on", with: @learning.published_on
    fill_in "Title", with: @learning.title
    click_on "Create Learning"

    assert_text "Learning was successfully created"
    click_on "Back"
  end

  test "should update Learning" do
    visit learning_url(@learning)
    click_on "Edit this learning", match: :first

    fill_in "Markdown", with: @learning.markdown
    check "Published" if @learning.published
    fill_in "Published on", with: @learning.published_on
    fill_in "Title", with: @learning.title
    click_on "Update Learning"

    assert_text "Learning was successfully updated"
    click_on "Back"
  end

  test "should destroy Learning" do
    visit learning_url(@learning)
    click_on "Destroy this learning", match: :first

    assert_text "Learning was successfully destroyed"
  end
end
