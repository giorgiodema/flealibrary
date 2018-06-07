class CreateNotificationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ad = args.first
    puts("\n\nSTARTED NEW JOB FOR AD: #{ad.book_title}\n\n")
  end
end
