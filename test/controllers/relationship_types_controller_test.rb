require "test_helper"

class RelationshipTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @relationship_type = relationship_types(:one)
  end

  test "should get index" do
    get relationship_types_url, as: :json
    assert_response :success
  end

  test "should create relationship_type" do
    assert_difference("RelationshipType.count") do
      post relationship_types_url, params: { relationship_type: {} }, as: :json
    end

    assert_response :created
  end

  test "should show relationship_type" do
    get relationship_type_url(@relationship_type), as: :json
    assert_response :success
  end

  test "should update relationship_type" do
    patch relationship_type_url(@relationship_type), params: { relationship_type: {} }, as: :json
    assert_response :success
  end

  test "should destroy relationship_type" do
    assert_difference("RelationshipType.count", -1) do
      delete relationship_type_url(@relationship_type), as: :json
    end

    assert_response :no_content
  end
end
