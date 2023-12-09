require "test_helper"

class InstrumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @instrument = instruments(:one)
  end

  # test "should get index" do
  #   get instruments_url, as: :json
  #   assert_response :success
  # end

  # test "should create instrument" do
  #   assert_difference("Instrument.count") do
  #     post instruments_url, params: { instrument: { name: @instrument.name } }, as: :json
  #   end

  #   assert_response :created
  # end

  # test "should show instrument" do
  #   get instrument_url(@instrument), as: :json
  #   assert_response :success
  # end

  # test "should update instrument" do
  #   patch instrument_url(@instrument), params: { instrument: { name: @instrument.name } }, as: :json
  #   assert_response :success
  # end

  # test "should destroy instrument" do
  #   assert_difference("Instrument.count", -1) do
  #     delete instrument_url(@instrument), as: :json
  #   end

  #   assert_response :no_content
  # end
end
