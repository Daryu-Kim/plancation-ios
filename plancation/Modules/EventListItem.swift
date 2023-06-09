//
//  CalendarListItem.swift
//  plancation
//
//  Created by Won Jae Kim on 2023/06/05.
//

import Foundation

class EventListItem: ObservableObject, Identifiable {
  @Published var eventID: String
  @Published var eventSTime: Date
  @Published var eventETime: Date
  @Published var eventUsers: [String]
  @Published var eventAlerts: [String]
  @Published var eventAuthorID: String
  @Published var eventIsTodo: Bool
  @Published var eventTitle: String
  @Published var eventCheckUsers: [String]
  
  init(
    eventID: String,
    eventSTime: Date,
    eventETime: Date,
    eventUsers: [String],
    eventAlerts: [String],
    eventAuthorID: String,
    eventIsTodo: Bool,
    eventTitle: String,
    eventCheckUsers: [String]
  ) {
    self.eventID = eventID
    self.eventSTime = eventSTime
    self.eventETime = eventETime
    self.eventUsers = eventUsers
    self.eventAlerts = eventAlerts
    self.eventAuthorID = eventAuthorID
    self.eventIsTodo = eventIsTodo
    self.eventTitle = eventTitle
    self.eventCheckUsers = eventCheckUsers
  }
}
