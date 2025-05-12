require "test_helper"

class IndividualsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @individual = individuals(:one)
  end

  test "should get index" do
    get individuals_url, as: :json
    assert_response :success
  end

  test "should create individual" do
    assert_difference("Individual.count") do
      post individuals_url, params: { individual: { name: @individual.name } }, as: :json
    end

    assert_response :created
  end

  test "should show individual" do
    get individual_url(@individual), as: :json
    assert_response :success
  end

  test "should update individual" do
    patch individual_url(@individual), params: { individual: { name: @individual.name } }, as: :json
    assert_response :success
  end

  test "should destroy individual" do
    assert_difference("Individual.count", -1) do
      delete individual_url(@individual), as: :json
    end

    assert_response :no_content
  end
end
