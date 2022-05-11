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
    @State var selectedMinute = 0
    @State var recurringNotification = false
    @State var selectedDateAndTime = Date() // now
    let now = Date()
    
    // MARK: Computed properties
    
    // Round up to the next hour
    // ADAPTED FROM: https://stackoverflow.com/a/42626860
    var dateAndTimeOfNextHour: Date {
        
        // Find current date and date components
        let now = Date()
        //2017-03-06 13:23:40 +0000
        let calendar = Calendar.current
        let oneHourInFuture = calendar.date(byAdding: .hour, value: 1, to: now) ?? Date()
        let hour = calendar.component(.hour, from: oneHourInFuture)
        
        // Round up to next hour
        let newDate = calendar.date(bySettingHour: hour,
                                    minute: 0,
                                    second: 0,
                                    of: oneHourInFuture)!
        return newDate
    }
    
    // Selected date in a useful format
    var formattedSelectedDateAndTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        
        return formatter.string(from: selectedDateAndTime)
    }
    
    
    // The body property of the view
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                Rectangle()
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .frame(height: 1)
                
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
                
                // Publish notification at a particular time of the week
                VStack(alignment: .leading, spacing: 10) {
                    
                    Group {
                        Text("At a particular time of the week")
                            .bold()
                        
                        Text("*What day?*")
                            .font(.subheadline)
                            .padding(.top, 5)
                        
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
                        
                        Text("*At what hour?*")
                            .font(.subheadline)
                            .padding(.top, 5)
                        
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
                            
                            Text("Selected hour is: \(selectedHour)")
                                .font(.subheadline)
                        }
                        
                        Text("*At what time within the hour?*")
                            .font(.subheadline)
                            .padding(.top, 5)
                        
                        HStack {
                            
                            Picker(selection: $selectedMinute,
                                   label: Text("Minute of hour"),
                                   content: {
                                
                                Group {
                                    Text("on the hour").tag(0)
                                    Text("15").tag(15)
                                    Text("30").tag(30)
                                    Text("45").tag(45)
                                }
                                
                            })
                            .pickerStyle(.menu)
                            
                            Spacer()
                            
                            Text("Selected minute is is: \(selectedMinute)")
                                .font(.subheadline)
                        }
                        
                        
                        // Is the notification meant to be recurring?
                        Toggle(isOn: $recurringNotification) {
                            Text("*Recurring?*")
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
                            
                            // Publish a notification for the given day, hour, minute
                            publishNotification(title: "This is the title",
                                                subtitle: "At a specific date and time",
                                                body: "This was configued to run on day \(selectedDay) of the week at hour \(selectedHour)",
                                                onDay: selectedDay,
                                                atHour: selectedHour,
                                                atMinute: selectedMinute,
                                                recurring: recurringNotification,
                                                identifier: myNotificationsIdentifier)
                            
                        }, label: {
                            
                            Text("Publish Notification")
                            
                        })
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        
                        Text("This notification will appear on the selected day and time, and \(recurringNotification == true ? "will" : "will not") recur or repeat.")
                            .font(.caption)
                        
                        Spacer()
                    }
                }
                
                Rectangle()
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .frame(height: 1)
                
                // Publish notification at a specific date and time
                VStack(alignment: .leading, spacing: 10) {
                    
                    Group {
                        Text("At a given date and time")
                            .bold()
                        
                        // Compact
                        DatePicker("",
                                   selection: $selectedDateAndTime,
                                   in: now...)
                        .datePickerStyle(.compact)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            // Publish a notification for the selected date/time
                            publishNotification(title: "This is the title",
                                                subtitle: "At a specific date and time",
                                                body: "\(formattedSelectedDateAndTime) was the date & time this notification was scheduled for.",
                                                occuringAt: selectedDateAndTime,
                                                identifier: myNotificationsIdentifier)
                            
                        }, label: {
                            
                            Text("Publish Notification")
                            
                        })
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        
                        Text("This notification will appear at the indicated date and time.")
                            .font(.caption)
                        
                        Spacer()
                    }
                    
                    
                }
                
            }
            .task {
                // Set the current date and time for the DatePicker to the start of the next hour
                selectedDateAndTime = dateAndTimeOfNextHour
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
