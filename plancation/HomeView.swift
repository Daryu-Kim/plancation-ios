  //
  //  HomeView.swift
  //  plancation
  //
  //  Created by Won Jae Kim on 2023/06/02.
  //

import SwiftUI

struct HomeView: View {
  @State var selectedSideMenuTab: Int = 0
  @State var viewName: String = "Plancation"
  @State var selectedMenuIndex: Int = 0
  @State var isOpenSideMenu: Bool = false
  
  var iconBottomNav = [
    "calendar",
    "checklist",
    "keyboard",
    "clipboard",
    "person.circle"
  ]
  var labelBottomNav = [
    "캘린더",
    "할 일",
    "AI",
    "다이어리",
    "MY"
  ]
  var lengthBottomNavItems: Int = 5
  
  init() {
    UITabBar.appearance().backgroundColor = UIColor(named: "backgroundColor")
    UITabBar.appearance().unselectedItemTintColor = UIColor(named: "hintTextColor")
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 0) {
          HStack {
            HStack(spacing: 12) {
              Button(action: {
                isOpenSideMenu.toggle()
              }) {
                Image(systemName: "line.horizontal.3")
                  .foregroundColor(Color("primaryColor"))
                  .imageScale(.large)
              }
              Text("\(viewName)")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            }
            Spacer()
            HStack {
              Button(action: {
                print("trailing")
              }) {
                Image(systemName: "magnifyingglass")
                  .foregroundColor(Color("primaryColor"))
                  .imageScale(.large)
              }
              Button(action: {
                print("trailing")
              }) {
                Image(systemName: "bell")
                  .foregroundColor(Color("primaryColor"))
                  .imageScale(.large)
              }
            }
          }
          .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
          .background(Color("primaryContainerColor"))
          switch selectedMenuIndex {
            case 0:
              CalendarView()
                .accentColor(Color("primaryColor"))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
              
            case 1:
              TodoView()
                .accentColor(Color("primaryColor"))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
              
            case 2:
              TodoView()
                .accentColor(Color("primaryColor"))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
              
            case 3:
              TodoView()
                .accentColor(Color("primaryColor"))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
              
            case 4:
              TodoView()
                .accentColor(Color("primaryColor"))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
              
            default:
              Text("Error!")
          }
          HStack {
            ForEach (0..<lengthBottomNavItems) { index in
              Button(action: {
                selectedMenuIndex = index
                viewName = labelBottomNav[index]
              }) {
                VStack(spacing: 4) {
                  Image(systemName: iconBottomNav[index])
                    .imageScale(.large)
                    .frame(width: 28, height: 28)
                    .foregroundColor(
                      selectedMenuIndex == index
                      ? Color("primaryColor")
                      : Color("hintTextColor")
                    )
                  Text(labelBottomNav[index])
                    .font(.system(size: 12))
                    .foregroundColor(
                      selectedMenuIndex == index
                      ? Color("primaryColor")
                      : Color("hintTextColor")
                    )
                  
                }
              }
              if (index < lengthBottomNavItems - 1) {
                Spacer()
              }
            }
          }
          .padding(EdgeInsets(top: 8, leading: 28, bottom: 8, trailing: 28))
          .background(Color("backgroundColor"))
        }
      }
      .navigationBarBackButtonHidden(true)
      SideBarView(isOpenSideMenu: $isOpenSideMenu)
    }
  }
}

//struct HomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    HomeView()
//  }
//}
