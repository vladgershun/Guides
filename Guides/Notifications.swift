//
//  Notifications.swift
//  Guides
//
//  Created by Vlad Gershun on 9/2/23.
//

import SwiftUI
import UserNotifications

struct Notifications: View {
    var body: some View {
        Button("New Notification") {
            createNotification()
        }
    }
    
    func createNotification() {
        let center = UNUserNotificationCenter.current()
        
        let newRequest = {
            /// Creates a basic notification.
            let content = UNMutableNotificationContent()
            content.title = "Title"
            content.subtitle = "Subtitle"
            content.sound = UNNotificationSound.default
            
            ///Add timing to notification.
            var dateComponents = DateComponents()
            ///Sets the hour to 9 AM.
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let testTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            ///Create a notification request.
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: testTrigger)
            ///Schedule the delivery of the request to our notifications.
            center.add(request)
        }
        
        ///Checks to see if users have notifications authorized.
        center.getNotificationSettings { settings in
            ///Execute `newRequest` closure if notifications are allowed.
            if settings.authorizationStatus == .authorized {
                newRequest()
            } else {
                ///Request user for notifications.
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, erroor in
                    if success {
                        newRequest()
                    } else {
                        print("Could not authorize.")
                    }
                }
            }
        }
    }
}



struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
