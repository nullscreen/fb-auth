ENV['FB_CLIENT_ID']='000000TEST_ID00000'
ENV['FB_CLIENT_SECRET']='00000TEST_SECRET00000'
require "bundler/setup"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require "fb/auth"

Fb.configure do |config|
  config.client_id = ENV['FB_CLIENT_ID']
  config.client_secret = ENV['FB_CLIENT_SECRET']
end
