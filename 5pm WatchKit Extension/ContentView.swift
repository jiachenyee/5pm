//
//  ContentView.swift
//  5pm WatchKit Extension
//
//  Created by Jia Chen Yee on 21/1/22.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var is5PM = false
    
    
    var body: some View {
        VStack {
            if is5PM {
                Text("It's 5pm")
            } else {
                Text("It's not 5pm")
            }
        }
        .padding()
        .onReceive(timer) { input in
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            if hour == 17 && minutes == 0 {
                is5PM = true
            } else {
                is5PM = false
            }
        }
        .onAppear {
            let centre = UNUserNotificationCenter.current()
            
            centre.removeAllPendingNotificationRequests()
            
            centre.requestAuthorization(options: [.alert, .badge, .carPlay, .criticalAlert, .provisional, .sound]) { auth, _ in
                if auth {
                    let content = UNMutableNotificationContent()
                    content.title = "It's 5PM"
                    content.body = "HELLO CARL IT'S 5PM"
                    
                    
                    var dateComponents = DateComponents()
                    
                    dateComponents.timeZone = .current
                    dateComponents.hour = 17
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//                    print(dateComponents.date)
                    
//                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
                    
                    // Create the request
                    let uuidString = UUID().uuidString
                    let request = UNNotificationRequest(identifier: uuidString,
                                                        content: content, trigger: trigger)
                    
                    // Schedule the request with the system.
                    let notificationCenter = UNUserNotificationCenter.current()
                    
                    notificationCenter.add(request) { (error) in
                        if error != nil {
                            // Handle any errors.
                            print(error?.localizedDescription)
                        } else {
                            print("what")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
