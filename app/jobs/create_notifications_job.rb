class CreateNotificationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ad = args.first
    puts("\n\nSTARTED NEW JOB FOR AD: #{ad.book_title}")
    
    matching = Ad.where("LOWER(book_title) = :title AND id != :id",{title:ad.book_title.downcase,id:ad.id})
    matching.each do |m|
      n1 = Notification.create(ad:m,user:ad.user)
      n2 = Notification.create(ad:ad,user:m.user)
    end
    
  end
end
