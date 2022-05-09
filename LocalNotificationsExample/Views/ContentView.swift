//
//  ContentView.swift
//  LocalNotificationsExample
//
//  Created by Russell Gordon on 2022-05-09.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 10) {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        // Publish a notification that will occur 1 minute from now
                        publishNotification(title: "This is the title",
                                            subtitle: "This is the subtitle",
                                            body: "This is the body",
                                            timeUntil: 60,
                                            identifier: myNotificationsIdentifier)
                        
                    }, label: {
                        
                        Text("Publish Notification")
                        
                    })
                    .buttonStyle(.bordered)
                    
                    Spacer()
                }
                                
                Spacer()
                
            }
            .background(Color.yellow)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Notifications")

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
