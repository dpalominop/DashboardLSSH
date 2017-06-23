require 'test_helper'

class CommandListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @command_list = command_lists(:one)
  end

  test "should get index" do
    get command_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_command_list_url
    assert_response :success
  end

  test "should create command_list" do
    assert_difference('CommandList.count') do
      post command_lists_url, params: { command_list: { description: @command_list.description, name: @command_list.name, network_element_id: @command_list.network_element_id, role_id: @command_list.role_id } }
    end

    assert_redirected_to command_list_url(CommandList.last)
  end

  test "should show command_list" do
    get command_list_url(@command_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_command_list_url(@command_list)
    assert_response :success
  end

  test "should update command_list" do
    patch command_list_url(@command_list), params: { command_list: { description: @command_list.description, name: @command_list.name, network_element_id: @command_list.network_element_id, role_id: @command_list.role_id } }
    assert_redirected_to command_list_url(@command_list)
  end

  test "should destroy command_list" do
    assert_difference('CommandList.count', -1) do
      delete command_list_url(@command_list)
    end

    assert_redirected_to command_lists_url
  end
end
