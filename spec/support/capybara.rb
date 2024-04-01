RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end

  # JavaScriptの完了を待ちたいとき
  # Capybara.default_max_wait_time = 15
  # もしくは、以下のように設定する。
  # using_wait_time(15) do
  #   # テストを実行する
  # end
end
