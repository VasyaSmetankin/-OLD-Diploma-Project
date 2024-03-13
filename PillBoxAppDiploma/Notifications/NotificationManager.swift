//
//  Notifications.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 06.06.2023.
//

import RealmSwift
import UserNotifications

class ReminderManager {
    
    var buffer: ReminderEntityRealm?
    
    static let shared = ReminderManager()
    
    private init() {
        
    }
    
    
    func scheduleLocalNotification(for reminderEntity: ReminderEntityRealm) {
        let notificationCenter = UNUserNotificationCenter.current()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour, .minute], from: reminderEntity.date)
        
        let content = UNMutableNotificationContent()
        content.title = "You should drink your pills ASAP"
        content.body = reminderEntity.pillEntity?.pillName ?? ""
        content.sound = .default
        let realm = try! Realm()
        try! realm.write {
            reminderEntity.pillEntity?.pillCount -= 1
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: reminderEntity.name, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Ошибка при создании уведомления: \(error)")
            }
        }
    }
    
    
    func scheduleTestNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "lalal"
        content.badge = 0
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "lal", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Ошибка при создании уведомления: \(error)")
            }
        }
    }
    
    
    func handleNotificationResponse(response: UNNotificationResponse) {
        let identifier = response.notification.request.identifier
        print("works")
        let realm = try! Realm()
        if let reminderEntity = realm.object(ofType: ReminderEntityRealm.self, forPrimaryKey: identifier) {
            if let pillEntity = reminderEntity.pillEntity {
                try! realm.write {
                    pillEntity.pillCount -= 1
                }
            }
        }
    }
    
}
