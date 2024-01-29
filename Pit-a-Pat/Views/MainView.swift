import SwiftUI
import AuthenticationServices


struct MainView: View {
    var body: some View {
        NavigationView {
            //ZStack{
            ARViewRepresentable()
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Image("PitAPat")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipped()
                        
                        NavigationLink(destination: InstructionView()) {
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
                        .cornerRadius(12)
                        .padding()
                    }
                )
            //.blur(radius: 10)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
//}


#Preview {
    MainView()
}

