//
//  _pmApp.swift
//  5pm WatchKit Extension
//
//  Created by Jia Chen Yee on 21/1/22.
//

import SwiftUI

@main
struct _pmApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
