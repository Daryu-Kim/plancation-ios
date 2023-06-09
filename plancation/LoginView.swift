  //
  //  LoginView.swift
  //  plancation
  //
  //  Created by Won Jae Kim on 2023/05/31.
  //

import SwiftUI

struct LoginView: View {
  @State var emailInput: String = ""
  @State var pwdInput: String = ""
  @State var isSecured: Bool = true

  
  var body: some View {
    NavigationView {
      VStack(spacing: 24) {
        Spacer()
        VStack(spacing: 16) {
          Image("AppLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 120)
          VStack {
            TextField("", text: $emailInput)
              .frame(height: 32)
              .font(.system(size: 16))
              .fontWeight(.medium)
              .accentColor(Color("primaryTextColor"))
              .foregroundColor(Color("primaryTextColor"))
              .placeholder(when: emailInput.isEmpty) {
                Text("Please Enter Your Email")
                  .foregroundColor(Color("hintTextColor"))
              }
            Divider()
              .background(Color("hintTextColor"))
          }
          VStack {
            HStack {
              if isSecured {
                SecureField("", text: $pwdInput)
                  .padding(0)
                  .frame(height: 36)
                  .font(.system(size: 16))
                  .fontWeight(.medium)
                  .accentColor(Color("primaryTextColor"))
                  .foregroundColor(Color("primaryTextColor"))
                  .placeholder(when: pwdInput.isEmpty) {
                    Text("Please Enter Your Password")
                      .foregroundColor(Color("hintTextColor"))
                  }
              } else {
                TextField("", text: $pwdInput)
                  .padding(0)
                  .frame(height: 36)
                  .font(.system(size: 16))
                  .fontWeight(.medium)
                  .accentColor(Color("primaryTextColor"))
                  .foregroundColor(Color("primaryTextColor"))
                  .placeholder(when: pwdInput.isEmpty) {
                    Text("Please Enter Your Password")
                      .foregroundColor(Color("hintTextColor"))
                  }
              }
              Button(action: {
                isSecured.toggle()
              }) {
                if isSecured {
                  Image(systemName: "eye.slash")
                    .accentColor(Color("hintTextColor"))
                } else {
                  Image(systemName: "eye")
                    .accentColor(Color("primaryTextColor"))
                }
              }
            }
            Divider()
              .background(Color("hintTextColor"))
          }
          NavigationLink(destination: FindPWView()) {
            Text("비밀번호를 잊어버리셨나요?")
              .font(.system(size: 12))
              .fontWeight(.semibold)
              .foregroundColor(Color("hintTextColor"))
          }
          NavigationLink(destination: HomeView()) {
            Text("로그인")
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 44)
              .font(.system(size: 18))
              .foregroundColor(Color("inversePrimaryTextColor"))
              .fontWeight(.bold)
              .background(Color("primaryColor"))
              .cornerRadius(.infinity)
          }
        }
        Spacer()
        VStack(spacing: 16) {
          HStack(spacing: 12) {
            VStack {
              Divider()
                .background(Color("hintTextColor"))
            }
            Text("다른 방법으로 로그인")
              .font(.system(size: 12))
              .fontWeight(.medium)
              .multilineTextAlignment(.center)
              .foregroundColor(Color("hintTextColor"))
            VStack {
              Divider()
                .background(Color("hintTextColor"))
            }
          }
          Button(
            action: {
              print("Join")
            })
          {
          HStack(spacing: 12) {
            Image("GoogleProvider")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 24)
            Text("Google로 로그인")
              .font(.system(size: 16))
              .fontWeight(.semibold)
              .foregroundColor(Color("primaryTextColor"))
            
          }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 42)
            .overlay(
              RoundedRectangle(cornerRadius: .infinity).stroke(Color("primaryColor"), lineWidth: 3)
            )
          }
          .cornerRadius(.infinity)
          HStack(spacing: 8) {
            Text("계정이 없으세요?")
              .font(.system(size: 12))
              .fontWeight(.medium)
              .foregroundColor(Color("hintTextColor"))
            NavigationLink(destination: JoinView()) {
              Text("회원가입 하러가기")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundColor(Color("primaryTextColor"))
            }
          }
        }
        
      }.padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
        .ignoresSafeArea(.keyboard)
        .onAppear(perform: UIApplication.shared.hideKeyboard)
        .background(Color("backgroundColor"))
      
    }.navigationBarBackButtonHidden()
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
