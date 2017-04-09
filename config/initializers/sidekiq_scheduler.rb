# frozen_string_literal: true
require 'sidekiq/scheduler'

if Rails.env == 'production'
  Sidekiq.configure_server do |config|

    config.on(:startup) do
      Sidekiq.schedule = YAML.load_file(Rails.root.join('config', 'sidekiq.production.yml'))
      Sidekiq::Scheduler.reload_schedule!
    end
  end
end
