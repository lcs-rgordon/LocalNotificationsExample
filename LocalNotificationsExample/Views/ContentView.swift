//
//  ContentView.swift
//  LocalNotificationsExample
//
//  Created by Russell Gordon on 2022-05-09.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State var selectedDay = 1
    @State var selectedHour = 1
    @State var recurringNotification = false
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                // Publish notification after a set period of time in seconds
                VStack(alignment: .leading, spacing: 10) {
                    Text("After a set amount of time")
                        .bold()
                        .padding(.horizontal)
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            // Publish a notification that will occur 1 minute from now
                            publishNotification(title: "Title of notification",
                                                subtitle: "After set period of time",
                                                body: "This was configured to show after 60 seconds.",
                                                timeUntil: 60,
                                                identifier: myNotificationsIdentifier)
                            
                        }, label: {
                            
                            Text("Publish Notification")
                            
                        })
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        
                        Text("This notification will appear in 60 seconds.")
                            .font(.caption)
                        
                        Spacer()
                    }
                }
                
                Rectangle()
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .frame(height: 1)
                
                // Publish notification on a specific day and time
                VStack(alignment: .leading, spacing: 10) {
                    
                    Group {
                        Text("On a specific day at a specific time")
                            .bold()
                        
                        Text("What day?")
                            .font(.subheadline)
                        
                        HStack {
                            Picker(selection: $selectedDay,
                                   label: Text("Day of week"),
                                   content: {
                                
                                Text("Sunday").tag(1)
                                Text("Monday").tag(2)
                                Text("Tuesday").tag(3)
                                Text("Wednesday").tag(4)
                                Text("Thursday").tag(5)
                                Text("Friday").tag(6)
                                Text("Saturday").tag(7)
                                
                            })
                            .pickerStyle(.menu)
                            
                            Spacer()
                            
                            Text("Selected day is: \(selectedDay)")
                                .font(.subheadline)
                        }
                        
                        
                        HStack {
                            
                            Picker(selection: $selectedHour,
                                   label: Text("Hour of day"),
                                   content: {
                                
                                Group {
                                    
                                    Text("Midnight").tag(0)
                                    Text("1 AM").tag(1)
                                    Text("2 AM").tag(2)
                                    Text("3 AM").tag(3)
                                    Text("4 AM").tag(4)
                                    Text("5 AM").tag(5)
                                    Text("6 AM").tag(6)
                                    Text("7 AM").tag(7)
                                    Text("8 AM").tag(8)
                                    Text("9 AM").tag(9)
                                }
                                
                                Group {
                                    Text("10 AM").tag(10)
                                    Text("11 AM").tag(11)
                                    Text("Noon").tag(12)
                                    Text("1 PM").tag(13)
                                    Text("2 PM").tag(14)
                                    Text("3 PM").tag(15)
                                    Text("4 PM").tag(16)
                                    Text("5 PM").tag(17)
                                    Text("6 PM").tag(18)
                                    Text("7 PM").tag(19)
                                }
                                
                                Group {
                                    Text("8 PM").tag(20)
                                    Text("9 PM").tag(21)
                                    Text("10 PM").tag(22)
                                    Text("11 PM").tag(23)
                                }
                                
                            })
                            .pickerStyle(.menu)
                            
                            Spacer()
                            
                            Text("Selected time is: \(selectedHour)")
                                .font(.subheadline)
                        }
                        

                        // Example usage, when toggle is on
                        Toggle(isOn: $recurringNotification) {
                            Text("Recurring?")
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Spacer()
                            Text("Notification will recur: \(recurringNotification ? "yes" : "no")")
                                .font(.subheadline)
                        }

                    }
                    .padding(.horizontal)
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            // Publish a notification that will occur 1 minute from now
                            publishNotification(title: "This is the title",
                                                subtitle: "At a specific date and time",
                                                body: "This was configued to run on day \(selectedDay) of the week at hour \(selectedHour)",
                                                onDay: selectedDay,
                                                atHour: selectedHour,
                                                recurring: recurringNotification,
                                                identifier: myNotificationsIdentifier)
                                                        
                        }, label: {
                            
                            Text("Publish Notification")
                            
                        })
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        
                        Text("This notification will appear at the indicated time, and \(recurringNotification == true ? "will" : "will not") recur or repeat.")
                            .font(.caption)
                        
                        Spacer()
                    }
                }
                
            }
            .background(Color.yellow)
            .navigationTitle("Notifications")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
