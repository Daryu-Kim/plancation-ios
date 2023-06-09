//
//  SideBarView.swift
//  plancation
//
//  Created by Won Jae Kim on 2023/06/02.
//

import SwiftUI

struct SideBarView: View {
  @Binding var isOpenSideMenu: Bool
  var sideBarWidth = UIScreen.main.bounds.width * 0.85
  var bgColor: Color =
  Color(.init(
    red: 52 / 255,
    green: 70 / 255,
    blue: 182 / 255,
    alpha: 1))
  
  var body: some View {
    ZStack {
      GeometryReader { _ in
        EmptyView()
      }
      .background(.black.opacity(0.6))
      .opacity(isOpenSideMenu ? 1 : 0)
      .animation(.easeInOut(duration: 0.2), value: isOpenSideMenu)
      .onTapGesture {
        isOpenSideMenu.toggle()
      }
      content
    }
    .edgesIgnoringSafeArea(.all)
  }
  
  var content: some View {
    HStack(alignment: .top) {
      ZStack(alignment: .top) {
        VStack {
          HStack {
            HStack(spacing: 8) {
              AsyncImage(
                url: URL(string: "https://picsum.photos/300"),
                content: { image in
                  image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 36, maxHeight: 36)
                    .cornerRadius(.infinity)
                },
                placeholder: {
                  ProgressView()
                })
              Text("강해민")
            }
            Spacer()
            Button(action: {}, label: {
              Image(systemName: "gearshape")
                .imageScale(.large)
            })
          }
          Spacer()
        }
        .padding(EdgeInsets(top: 96, leading: 24, bottom: 16, trailing: 24))
        .background(Color("backgroundColor"))
      }
      .frame(width: sideBarWidth)
      .offset(x: isOpenSideMenu ? 0 : -sideBarWidth)
      .animation(.default, value: isOpenSideMenu)
      .cornerRadius(36, corners: [.topRight, .bottomRight])
      Spacer()
    }
  }
}

//struct SideBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBarView()
//    }
//}
