module Notifications
  extend ActiveSupport::Concern

  def create_notification(platform, tokens, title, message)
    if tokens.present?
      if platform == "android"
        app = RailsPushNotifications::GCMApp.new
        app.gcm_key = "AIzaSyBN6cG1oUV4cxV0_oveJQBPtsCEb0ylgbI"

        if app.save
          notification = app.notifications.build(
            destinations: tokens,
            data: { title: title , text: message }
          )

          if notification.save
            app.push_notifications
          end
        end
      elsif platform == "ios"
        app = RailsPushNotifications::APNSApp.new
        app.apns_dev_cert = File.read("config/Certificates.pem")
        app.sandbox_mode = false

        if app.save
          notification = app.notifications.build(
            destinations: tokens,
            data: { aps: { alert: { title: title, body: message }, sound: 'true', badge: 1 } }
          )
        end

        if notification.save
          app.push_notifications
        end
      end
    end
  end
end
