import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack(spacing: 24) {
        Image("AppLogoGradient")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(minWidth: 256, maxWidth: UIScreen.main.bounds.width - 48)
        Text("Welcome !")
          .foregroundColor(Color("primaryColor"))
        VStack(spacing: 8) {
          NavigationLink(destination: JoinView()) {
            Text("가입")
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 48)
              .font(.system(size: 18))
              .fontWeight(.bold)
              .foregroundColor(Color("primaryColor"))
              .overlay(
                RoundedRectangle(cornerRadius: .infinity).stroke(Color("primaryColor"), lineWidth: 3)
              )
              .cornerRadius(.infinity)
          }
          NavigationLink(destination: LoginView()) {
            Text("로그인")
          }
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 48)
          .font(.system(size: 18))
          .foregroundColor(Color("inversePrimaryTextColor"))
          .fontWeight(.bold)
          .background(Color("primaryColor"))
          .cornerRadius(.infinity)
        }
        Spacer()
        Text("위의 선택지 중 한개를 누름으로서, 플랜케이션의 서비스 이용약관과 개인정보처리방침에 동의한 것으로 간주합니다.")
          .font(.system(size: 12))
          .fontWeight(.semibold).multilineTextAlignment(.center)
          .foregroundColor(Color("hintTextColor"))
      }
      .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
      .background(Color("backgroundColor"))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
