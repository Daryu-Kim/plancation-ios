//
//  FindPWView.swift
//  plancation
//
//  Created by Won Jae Kim on 2023/06/02.
//

import SwiftUI

struct FindPWView: View {
  @State var emailInput: String = ""
    var body: some View {
      NavigationView {
        VStack {
          HStack {
              // AppBar
            VStack(alignment: .leading, spacing: 12) {
              Text("비밀번호를")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.white)
              Text("잊으셨나요?")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
            Spacer()
            Image("AppLogoSymbol")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 78)
          }
          .frame(height: 128)
          .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
          .background(Color("primaryContainerColor"))
          
          VStack {
            VStack (alignment: .leading, spacing: 24) {
              Text("비밀번호를 재설정하려는 계정의 이메일을 입력해 주세요")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color("primaryColor"))
              VStack {
                TextField("", text: $emailInput)
                  .frame(height: 32)
                  .font(.system(size: 16))
                  .fontWeight(.medium)
                  .foregroundColor(Color("primaryTextColor"))
                  .accentColor(Color("primaryTextColor"))
                  .placeholder(when: emailInput.isEmpty) {
                    Text("Please Enter Your Email")
                      .foregroundColor(Color("hintTextColor"))
                  }
                Divider()
                  .background(Color("hintTextColor"))
              }
            }
            Spacer()
            Button(
              action: {
                print("Send Email")
              })
            {
            Text("이메일 전송")
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 44)
              .font(.system(size: 18))
              .foregroundColor(Color("inversePrimaryTextColor"))
              .fontWeight(.bold)
              .background(Color("primaryColor"))
            }
            .cornerRadius(.infinity)
          }
          .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
          .ignoresSafeArea(.keyboard)
          .onAppear(perform: UIApplication.shared.hideKeyboard)
        }
        .background(Color("backgroundColor"))
      }
    }
}

struct FindPWView_Previews: PreviewProvider {
    static var previews: some View {
        FindPWView()
    }
}
