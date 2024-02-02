import SwiftUI
import AuthenticationServices

struct MainView: View {
    @StateObject var profileVM = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ARViewRepresentable(blurred: true)
                .edgesIgnoringSafeArea(.all)
                .overlay(
            VStack {
                NavigationLink(destination: ProfileView()) {
                    HStack {
                        Text("Hi \(profileVM.Name)")
                            .font(.headline)                            .foregroundColor(.white)
                            .fontWeight(.semibold)

                        Image("avatar\(Int.random(in: 1..<7))")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding(.vertical)
                            .padding(.horizontal, 2)
                        
                    }
                } .padding(EdgeInsets(top: -200 , leading: 230 , bottom: 0, trailing: 0))
                Image("PitAPat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipped()
                
                NavigationLink(destination: HostAGame()) {
                    Rectangle()
                        .foregroundColor(Color("Color1"))
                        .cornerRadius(12)
                        .frame(width: 280, height: 44)
                        .overlay(
                            Text("Host a game")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                }
                
                NavigationLink(destination: JoinAGame()) {
                    Rectangle()
                        .foregroundColor(Color("Color1"))
                        .cornerRadius(12)
                        .frame(width: 280, height: 44)
                        .overlay(
                            Text("Join a game")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                }
                
                NavigationLink(destination: PlayersView()) {
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
            }
            )
        }
        .onAppear {
            // Fetch the user profile when the view appears
            Task {
                await profileVM.fetchUserProfile()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

//}


#Preview {
    MainView()
}

