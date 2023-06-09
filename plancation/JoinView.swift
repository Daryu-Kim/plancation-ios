  //
  //  JoinView.swift
  //  plancation
  //
  //  Created by Won Jae Kim on 2023/05/31.
  //

import SwiftUI

struct JoinView: View {
  @State var emailInput: String = ""
  @State var nameInput: String = ""
  @State var pwdInput: String = ""
  @State var pwdrInput: String = ""
  
  @State var isPwdSecured: Bool = true
  @State var isPwdRSecured: Bool = true
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
            // AppBar
          VStack(alignment: .leading, spacing: 12) {
            Text("Plancation")
              .font(.system(size: 24))
              .fontWeight(.bold)
              .foregroundColor(.white)
            Text("회원가입")
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
            // Body
          VStack(spacing: 24) {
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
            VStack {
              TextField("", text: $nameInput)
                .frame(height: 32)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color("primaryTextColor"))
                .accentColor(Color("primaryTextColor"))
                .placeholder(when: nameInput.isEmpty) {
                  Text("Please Enter Your Name")
                    .foregroundColor(Color("hintTextColor"))
                }
              Divider()
                .background(Color("hintTextColor"))
            }
            VStack {
              HStack {
                if isPwdSecured {
                  SecureField("", text: $pwdInput)
                    .padding(0)
                    .frame(height: 36)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(Color("primaryTextColor"))
                    .accentColor(Color("primaryTextColor"))
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
                    .foregroundColor(Color("primaryTextColor"))
                    .accentColor(Color("primaryTextColor"))
                    .placeholder(when: pwdInput.isEmpty) {
                      Text("Please Enter Your Password")
                        .foregroundColor(Color("hintTextColor"))
                    }
                }
                Button(action: {
                  isPwdSecured.toggle()
                }) {
                  if isPwdSecured {
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
            VStack {
              HStack {
                if isPwdRSecured {
                  SecureField("", text: $pwdrInput)
                    .padding(0)
                    .frame(height: 36)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(Color("primaryTextColor"))
                    .accentColor(Color("primaryTextColor"))
                    .placeholder(when: pwdrInput.isEmpty) {
                      Text("Please Re-Enter Your Password")
                        .foregroundColor(Color("hintTextColor"))
                    }
                } else {
                  TextField("", text: $pwdrInput)
                    .padding(0)
                    .frame(height: 36)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(Color("primaryTextColor"))
                    .accentColor(Color("primaryTextColor"))
                    .placeholder(when: pwdrInput.isEmpty) {
                      Text("Please Re-Enter Your Password")
                        .foregroundColor(Color("hintTextColor"))
                    }
                }
                Button(action: {
                  isPwdRSecured.toggle()
                }) {
                  if isPwdRSecured {
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
          }
          Spacer()
          VStack(spacing: 24) {
            Text("가입하기 버튼을 누르면, 플랜케이션의 서비스 이용약관과 개인정보 처리방침을 읽고 동의했음으로 간주합니다.")
              .font(.system(size: 12))
              .multilineTextAlignment(.center)
              .fontWeight(.semibold)
              .foregroundColor(Color("hintTextColor"))
            Button(
              action: {
                print("Login")
              })
            {
            Text("가입하기")
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 44)
              .font(.system(size: 18))
              .foregroundColor(Color("inversePrimaryTextColor"))
              .fontWeight(.bold)
              .background(Color("primaryColor"))
            }
            .cornerRadius(.infinity)
          }
        }
        .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
        .ignoresSafeArea(.keyboard)
        .onAppear(perform: UIApplication.shared.hideKeyboard)
      }
      .background(Color("backgroundColor"))
    }
  }
}

struct JoinView_Previews: PreviewProvider {
  static var previews: some View {
    JoinView()
  }
}
