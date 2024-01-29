import SwiftUI
import AuthenticationServices


struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack{
                ARViewRepresentable()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)
                VStack {
                    Image("PitAPat")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipped()
                    
                    NavigationLink(destination: ConnectWithSomeone()) {
                        
                        // نحط بدالها ايميج او ثري دي عادي ماهو بالاي ار
                        Rectangle()
                            .foregroundColor(Color("Color1"))
                            .cornerRadius(12)
                            .frame(width: 280, height: 44)
                            .overlay(
                                Text("Play")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            )
                    }
                    
                    NavigationLink(destination: Leaderboared()) {
                        // نحط بدالها ايميج او ثري دي عادي ماهو بالاي ار
                        Rectangle()
                            .foregroundColor(Color("Color1"))
                            .cornerRadius(12)
                            .frame(width: 280, height: 44)
                            .overlay(
                                Text("LeaderBoard")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            )
                    }
                    SignInWithAppleButton(
                        onRequest: { request in
                            // Handle request if needed
                        },
                        onCompletion: { result in
                            // Handle result if needed
                        }
                    )
                    .frame(width: 280, height: 44)
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    MainView()
}

