require 'test_helper'

class VocabWordsControllerTest < ActionController::TestCase
  setup do
    @vocab_word = vocab_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vocab_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vocab_word" do
    assert_difference('VocabWord.count') do
      post :create, vocab_word: { lesson: @vocab_word.lesson, word: @vocab_word.word }
    end

    assert_redirected_to vocab_word_path(assigns(:vocab_word))
  end

  test "should show vocab_word" do
    get :show, id: @vocab_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vocab_word
    assert_response :success
  end

  test "should update vocab_word" do
    patch :update, id: @vocab_word, vocab_word: { lesson: @vocab_word.lesson, word: @vocab_word.word }
    assert_redirected_to vocab_word_path(assigns(:vocab_word))
  end

  test "should destroy vocab_word" do
    assert_difference('VocabWord.count', -1) do
      delete :destroy, id: @vocab_word
    end

    assert_redirected_to vocab_words_path
  end
end
