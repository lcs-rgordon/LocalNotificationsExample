//
//  LocalNotificationsExampleApp.swift
//  LocalNotificationsExample
//
//  Created by Russell Gordon on 2022-05-09.
//

import SwiftUI

@main
struct LocalNotificationsExampleApp: App {
    
    // Ensure the AppDelegate class instance is connected to our SwiftUI structure instance for our app
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
