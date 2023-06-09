  //
  //  CalendarView.swift
  //  plancation
  //
  //  Created by Won Jae Kim on 2023/06/02.
  //

import SwiftUI
import FSCalendar
import FirebaseCore
import FirebaseFirestore


let db = Firestore.firestore()

enum Repeat: String, CaseIterable, Identifiable {
  case 매주
  case 매월
  case 매년
  case 없음
  
  var id: String { self.rawValue }
}

struct BasicInformation: View {
  var id: String
  var startDate: Date
  var endDate: Date
  var content: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Circle()
          .stroke(Color("accentColor"), lineWidth: 3)
          .frame(width: 8, height: 8)
        Text("\(startDate)")
          .font(.system(size: 12))
          .fontWeight(.semibold)
          .foregroundColor(Color("hintTextColor"))
      }
      Text("\(content)")
        .font(.system(size: 16))
        .fontWeight(.semibold)
        .foregroundColor(Color("primaryTextColor"))
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
    .background(Color("errorContainerColor"))
    .cornerRadius(12)
    .onTapGesture {
      let i = Date(timeIntervalSince1970: 1599811410)
      print("\(i)")
      print("Press")
    }
    .onLongPressGesture {
      print("LongPress")
    }
    .listRowBackground(Color("backgroundColor"))
  }
}

struct CalendarView: View {
  @State var selectedDate = Date()
  @State var isShowForm = false
  @State var eventTitle = ""
  @State var startDate = Date()
  @State var endDate = Date()
  @State var isEventAllDay = true
  @State var isStartDateSelected = false
  @State var isEndDateSelected = false
  @State var isAlertSelected = false
  @State var selectedColor = Color("primaryContainerColor")
  @State var selectedRepeat = Repeat.없음
  @State var selectedAlert = Date()
  
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "KST")
    formatter.locale = Locale(identifier: "ko")
    formatter.dateFormat = "M월 d일 EEEE"
    return formatter
  }
  var modalDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "KST")
    formatter.locale = Locale(identifier: "ko")
    formatter.dateFormat = "YYYY년 M월 d일 EEEE"
    return formatter
  }
  var calculateDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "KST")
    formatter.locale = Locale(identifier: "ko")
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }
  @State var eventList: [Any] = []
  
  func asdf() { Firestore.firestore().collection("Calendars").document("uXSeCoxfRWQH3FeJqDLciZkKXxP2").collection("Events").getDocuments() { (querySnapshot, err) in
    if let err = err {
      print("Error getting documents: \(err)")
    } else {
      for document in querySnapshot!.documents {
        let temp = document.data()
        print(temp[""])
      }
    }
  }
  }
  
  func addSchedule() {
    Firestore.firestore().collection("Calendars").document("uXSeCoxfRWQH3FeJqDLciZkKXxP2").collection(("Events")).addDocument(data: [
      "eventTitle": eventTitle,
      "eventSTime": startDate,
      "eventETime": endDate
    ])
    eventTitle = ""
  }
  
  init() {
    asdf()
  }
  
  
  var body: some View {
    ZStack(alignment: .bottom) {
      VStack(alignment: .leading, spacing: 16) {
        CalendarViewRepresentable(selectedDate: $selectedDate)
          .background(Color("backgroundColor"))
          .frame(height: 320)
        Divider()
          .background(Color("hintTextColor"))
        VStack {
          Text("\(selectedDate, formatter: dateFormatter)")
            .font(.system(size: 16))
            .fontWeight(.semibold)
        }
        if eventList.count == 0 {
          Spacer()
        } else {
          ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
//              ForEach(eventList) { index in
                  //                if eventList[index].get("eventIsTodo") == false && eventList[index].get("eventSTime") <= selectedDate &&
                  //                    eventList[index].get("eventETime") > selectedDate {
                  //                  BasicInformation(
                  //                    id: eventList[index].get("eventID"),
                  //                    startDate: eventList[index].get("eventSTime"),
                  //                    endDate: eventList[index].get("eventETime"),
                  //                    content: eventList[index].get("eventTitle")
                  //                  )
                  //                    .listRowSeparator(.hidden)
                  //                    .listRowInsets(EdgeInsets())
                  //                    .contextMenu {
                  //                      Button(action: {
                  //
                  //                      }) {
                  //                        Label("수정", systemImage: "pencil")
                  //                      }
                  //                      Button(
                  //                        role: .destructive,
                  //                        action: {
                  //
                  //                        },
                  //                        label: {
                  //                          Label("삭제", systemImage: "trash")
                  //                        }
                  //                      )
                  //                    }
//              }
              
            }
            Spacer()
          }
        }
      }
    }
    .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
    .background(Color("backgroundColor"))
    .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
    
    HStack {
      Spacer()
      Button(action: {
        startDate = selectedDate
        endDate = selectedDate
        isShowForm.toggle()
      }) {
        Image(systemName: "calendar.badge.plus")
          .resizable()
          .scaledToFill()
          .frame(width: 16, height: 16)
          .padding(16)
      }
      .background(Color("primaryColor"))
      .foregroundColor(.white)
      .cornerRadius(.infinity)
      .padding(EdgeInsets())
      .sheet(isPresented: $isShowForm) {
        VStack {
          HStack {
            Button(action: {
              isShowForm = false
            }) {
              Text("취소")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(.white)
            }
            Spacer()
            Text("새로운 이벤트")
              .font(.system(size: 16))
              .fontWeight(.semibold)
              .foregroundColor(.white)
            Spacer()
            Button(action: {
              isShowForm = false
              addSchedule()
            }) {
              Text("등록")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(.white)
            }
          }
          .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
          .background(Color("primaryContainerColor"))
          VStack(alignment: .leading, spacing: 16) {
            TextField("", text: $eventTitle)
              .padding()
              .frame(height: 42)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(Color("hintTextColor"), lineWidth: 1)
              )
              .font(.system(size: 12))
              .fontWeight(.semibold)
              .accentColor(Color("primaryTextColor"))
              .foregroundColor(Color("primaryTextColor"))
              .placeholder(when: eventTitle.isEmpty) {
                Text("일정 제목")
                  .font(.system(size: 12))
                  .fontWeight(.semibold)
                  .foregroundColor(Color("hintTextColor"))
                  .padding()
              }
            
            VStack(spacing: 0) {
              HStack(spacing: 0) {
                Button(action: {
                  isEventAllDay = true
                }) {
                  Text("하루종일")
                    .font(.system(size: 12))
                    .fontWeight(isEventAllDay ? .bold : .medium)
                    .foregroundColor(isEventAllDay ? .white : Color("primaryTextColor"))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 32)
                }
                .background(isEventAllDay ? Color("accentColor") : Color("backgroundColor"))
                .cornerRadius(8, corners: [.topLeft])
                .animation(.easeInOut(duration: 0.2), value: isEventAllDay)
                Divider()
                  .frame(minWidth: 1)
                  .background(Color("hintTextColor"))
                Button(action: {
                  isEventAllDay = false
                }) {
                  Text("구간설정")
                    .font(.system(size: 12))
                    .fontWeight(isEventAllDay ? .medium : .bold)
                    .foregroundColor(isEventAllDay ? Color("primaryTextColor") : .white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 32)
                }
                .background(isEventAllDay ? Color("backgroundColor") : Color("accentColor"))
                .cornerRadius(8, corners: [.topRight])
                .animation(.easeInOut(duration: 0.2), value: isEventAllDay)
              }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 32)
              Divider()
                .frame(minHeight: 1)
                .background(Color("hintTextColor"))
              HStack(spacing: 0) {
                Button(action: {
                  isStartDateSelected.toggle()
                }) {
                  VStack(spacing: 4) {
                    Text("시작")
                      .font(.system(size: 14))
                      .fontWeight(.semibold)
                    Text("\(startDate, formatter: modalDateFormatter)")
                      .font(.system(size: 12))
                      .fontWeight(.medium)
                  }
                  .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 64)
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                }.sheet(isPresented: $isStartDateSelected) {
                  VStack {
                    HStack {
                      Button(action: {
                        isStartDateSelected.toggle()
                      }) {
                        Text("취소")
                          .font(.system(size: 14))
                          .fontWeight(.medium)
                          .foregroundColor(.white)
                      }
                      Spacer()
                      Text("시작 날짜 정하기")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                      Spacer()
                      Button(action: {
                        isStartDateSelected.toggle()
                      }) {
                        Text("확인")
                          .font(.system(size: 14))
                          .fontWeight(.medium)
                          .foregroundColor(.white)
                      }
                    }
                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                    .background(Color("primaryContainerColor"))
                    DatePicker("", selection: $startDate, displayedComponents: .date)
                      .labelsHidden()
                      .datePickerStyle(.wheel)
                    Spacer()
                  }
                  .presentationDetents([.height(280)])
                }
                Divider()
                  .frame(minWidth: 1)
                  .background(Color("hintTextColor"))
                Button(action: {
                  isEndDateSelected.toggle()
                }) {
                  VStack(spacing: 4) {
                    Text("종료")
                      .font(.system(size: 14))
                      .fontWeight(.semibold)
                    Text("\(endDate, formatter: modalDateFormatter)")
                      .font(.system(size: 12))
                      .fontWeight(.medium)
                  }
                  .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 64)
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                }.sheet(isPresented: $isEndDateSelected) {
                  VStack {
                    HStack {
                      Button(action: {
                        isEndDateSelected.toggle()
                      }) {
                        Text("취소")
                          .font(.system(size: 14))
                          .fontWeight(.medium)
                          .foregroundColor(.white)
                      }
                      Spacer()
                      Text("종료 날짜 정하기")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                      Spacer()
                      Button(action: {
                        isEndDateSelected.toggle()
                      }) {
                        Text("확인")
                          .font(.system(size: 14))
                          .fontWeight(.medium)
                          .foregroundColor(.white)
                      }
                    }
                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                    .background(Color("primaryContainerColor"))
                    DatePicker("", selection: $endDate, displayedComponents: .date)
                      .labelsHidden()
                      .datePickerStyle(.wheel)
                    Spacer()
                  }
                  .presentationDetents([.height(280)])
                }
              }
              .foregroundColor(isEventAllDay ? Color("hintTextColor") : Color("primaryTextColor"))
              .disabled(isEventAllDay ? true : false)
            }
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color("hintTextColor"), lineWidth: 1)
            )
            ColorPicker(selection: $selectedColor) {
              Text("배경")
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .foregroundColor(Color("primaryTextColor"))
            }
            .padding()
            .frame(height: 42)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color("hintTextColor"), lineWidth: 1)
            )
            HStack {
              Text("반복")
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .foregroundColor(Color("primaryTextColor"))
              Spacer()
              Menu {
                Picker("", selection: $selectedRepeat) {
                    //                ForEach(0 ..< 3) { index in
                    //                  Text("\(index)")
                    //                }
                  Text("매주").tag(Repeat.매주)
                  Text("매월").tag(Repeat.매월)
                  Text("매년").tag(Repeat.매년)
                  Text("없음").tag(Repeat.없음)
                }
                .accentColor(Color("primaryColor"))
              } label: {
                Text("\(selectedRepeat.rawValue)")
                  .font(.system(size: 12))
                  .fontWeight(.semibold)
                  .foregroundColor(Color("primaryColor"))
              }
              
            }
            .padding()
            .frame(height: 42)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color("hintTextColor"), lineWidth: 1)
            )
            HStack {
              Text("알림")
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .foregroundColor(Color("primaryTextColor"))
              Spacer()
              Button(action: {
                isAlertSelected.toggle()
              }) {
                Text("\(selectedAlert.formatted(.dateTime.hour().minute()))")
                  .font(.system(size: 12))
                  .fontWeight(.semibold)
                  .foregroundColor(Color("primaryColor"))
              }.sheet(isPresented: $isAlertSelected) {
                VStack {
                  HStack {
                    Button(action: {
                      isAlertSelected.toggle()
                    }) {
                      Text("취소")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    }
                    Spacer()
                    Text("알림 시간 정하기")
                      .font(.system(size: 16))
                      .fontWeight(.semibold)
                      .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                      isAlertSelected.toggle()
                    }) {
                      Text("확인")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    }
                  }
                  .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                  .background(Color("primaryContainerColor"))
                  DatePicker("", selection: $selectedAlert, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                  Spacer()
                }
                .presentationDetents([.height(280)])
              }
              
            }
            .padding()
            .frame(height: 42)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color("hintTextColor"), lineWidth: 1)
            )
          }
          .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
          Spacer()
        }
        .presentationDetents([.height(460)])
      }
    }
    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 24))
  }
}
  //}

struct CalendarViewRepresentable: UIViewRepresentable {
  typealias UIViewType = FSCalendar
  
  fileprivate var calendar = FSCalendar()
  @Binding var selectedDate: Date
  
  func makeUIView(context: Context) -> FSCalendar {
    calendar.delegate = context.coordinator
    calendar.dataSource = context.coordinator
    
      // Added the below code to change calendar appearance
    calendar.appearance.todayColor = UIColor(displayP3Red: 0,
                                             green: 0,
                                             blue: 0, alpha: 0)
    calendar.appearance.selectionColor = UIColor(named: "primaryColor")
    calendar.appearance.eventDefaultColor = UIColor(named: "accentColor")
    calendar.appearance.titleTodayColor = UIColor(named: "primaryColor")
    calendar.appearance.titleFont = .systemFont(ofSize: 16, weight: .medium)
    calendar.appearance.titleDefaultColor = UIColor(named: "primaryTextColor")
    calendar.appearance.titleWeekendColor = .red
    calendar.appearance.headerTitleFont = .systemFont(ofSize: 18, weight: .semibold)
    calendar.appearance.headerTitleColor = UIColor(named: "primaryColor")
    calendar.appearance.headerDateFormat = "YYYY년 MMMM"
    calendar.appearance.weekdayTextColor = UIColor(named: "primaryColor")
    calendar.scrollDirection = .horizontal
    calendar.scope = .month
    calendar.clipsToBounds = false
    
    return calendar
  }
  
  func updateUIView(_ uiView: FSCalendar, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject,
                     FSCalendarDelegate, FSCalendarDataSource {
    var parent: CalendarViewRepresentable
    
    init(_ parent: CalendarViewRepresentable) {
      self.parent = parent
    }
    
    func calendar(_ calendar: FSCalendar,
                  didSelect date: Date,
                  at monthPosition: FSCalendarMonthPosition) {
      parent.selectedDate = date
    }
    
    func calendar(_ calendar: FSCalendar,
                  imageFor date: Date) -> UIImage? {
      if isWeekend(date: date) {
        return UIImage(systemName: "sparkles")
      }
      return nil
    }
    
    func calendar(_ calendar: FSCalendar,
                  numberOfEventsFor date: Date) -> Int {
      let eventDates = [Date(), Date(),
                        Date.now.addingTimeInterval(400000),
                        Date.now.addingTimeInterval(100000),
                        Date.now.addingTimeInterval(-600000),
                        Date.now.addingTimeInterval(-1000000)]
      var eventCount = 0
      eventDates.forEach { eventDate in
        if eventDate.formatted(date: .complete,
                               time: .omitted) == date.formatted(
                                date: .complete, time: .omitted){
          eventCount += 1;
        }
      }
      return eventCount
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
      return true
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
      Date.now.addingTimeInterval(86400 * 30)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
      Date.now.addingTimeInterval(-86400 * 30)
    }
  }
}

func isWeekend(date: Date) -> Bool {
  let dateFormatter: DateFormatter = DateFormatter()
  dateFormatter.dateFormat = "EEEE"
  let day: String = dateFormatter.string(from: date)
  if day == "Saturday" || day == "Sunday" {
    return true
  }
  return false
}

func getRandomColor() -> UIColor{
  
  let randomRed:CGFloat = CGFloat(drand48())
  
  let randomGreen:CGFloat = CGFloat(drand48())
  
  let randomBlue:CGFloat = CGFloat(drand48())
  
  return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
  
}
