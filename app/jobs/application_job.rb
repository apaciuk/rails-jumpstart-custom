class ApplicationJob < ActiveJob::Base
 # include Bullet::ActiveJob if Rails.env.development? # (if not using sidekiq only)
  around_perform do |_job, block|
    Bullet.profile do
      block.call
    end
  end
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end


