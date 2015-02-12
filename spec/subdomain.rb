
$DEFAULT_HOST = "lvh.me"
$DEFAULT_PORT = 9887

RSpec.configure do |config|
  Capybara.default_host = "http://#{$DEFAULT_HOST}"
  Capybara.server_port = $DEFAULT_PORT
  Capybara.app_host = "http://#{$DEFAULT_HOST}:#{Capybara.server_port}"
end


def switch_to_subdomain(subdomain)
  Capybara.app_host = "http://#{subdomain}.#{$DEFAULT_HOST}:#{$DEFAULT_PORT}"
end
