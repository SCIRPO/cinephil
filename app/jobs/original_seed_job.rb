class OriginalSeedJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later

  end
end
