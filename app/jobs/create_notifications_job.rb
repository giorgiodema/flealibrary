class CreateNotificationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ad = args.first
    puts("\n\nSTARTED NEW JOB FOR AD: #{ad.book_title}")
    
    matching = Ad.where("LOWER(book_title) = :title AND id != :id",{title:ad.book_title.downcase,id:ad.id})
    matching.each do |m|
      if ad.list_type != m.list_type
        n1 = Notification.create(ad:m,user:ad.user,displayed:0)
        n2 = Notification.create(ad:ad,user:m.user,displayed:0)

        ad.user.notifications_counter+=1
        ad.user.save

        m.user.notifications_counter+=1
        m.user.save
        msg = {
          type:"new_notification"
        }

        ActionCable.server.broadcast(
          "mailbox_#{ad.user.id}",
          msg
        )

        ActionCable.server.broadcast(
          "mailbox_#{m.user.id}",
          msg
        )
      end
    end
    
  end
end
