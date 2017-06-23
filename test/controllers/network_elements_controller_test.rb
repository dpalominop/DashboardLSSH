require 'test_helper'

class NetworkElementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @network_element = network_elements(:one)
  end

  test "should get index" do
    get network_elements_url
    assert_response :success
  end

  test "should get new" do
    get new_network_element_url
    assert_response :success
  end

  test "should create network_element" do
    assert_difference('NetworkElement.count') do
      post network_elements_url, params: { network_element: { description: @network_element.description, ip: @network_element.ip, name: @network_element.name, port: @network_element.port } }
    end

    assert_redirected_to network_element_url(NetworkElement.last)
  end

  test "should show network_element" do
    get network_element_url(@network_element)
    assert_response :success
  end

  test "should get edit" do
    get edit_network_element_url(@network_element)
    assert_response :success
  end

  test "should update network_element" do
    patch network_element_url(@network_element), params: { network_element: { description: @network_element.description, ip: @network_element.ip, name: @network_element.name, port: @network_element.port } }
    assert_redirected_to network_element_url(@network_element)
  end

  test "should destroy network_element" do
    assert_difference('NetworkElement.count', -1) do
      delete network_element_url(@network_element)
    end

    assert_redirected_to network_elements_url
  end
end
