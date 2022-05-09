//
//  ContentView.swift
//  LocalNotificationsExample
//
//  Created by Russell Gordon on 2022-05-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            // Runs once when the app opens
            .task {
                
                // Ask for permission to send notifications.
                // This will only present a dialog to the user
                // if the app has never asked before.
                askNotificationPermission()
                
                // Publish a notification that will occur 1 minute from now
                publishNotification(title: "This is the title",
                                    subtitle: "This is the subtitle",
                                    body: "This is the body",
                                    timeUntil: 60)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
