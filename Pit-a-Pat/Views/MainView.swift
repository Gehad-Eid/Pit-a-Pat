import SwiftUI
import AuthenticationServices

struct MainView: View {
    @StateObject var profileVM = ProfileViewModel()

    var body: some View {
        NavigationStack {
            //ZStack{
            //SharedARView(blurred: true)
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .overlay(
            VStack {

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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: ProfileView()) {
                    HStack {
                        Text("Hi \(profileVM.Name)")
                            .font(.headline)                            .foregroundColor(.white)
                            .fontWeight(.semibold)

                        Image("avatar\(Int.random(in: 1..<7))")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 40)
                            .clipShape(Circle())
                            .padding(.vertical)
                            .padding(.horizontal, 2)
                        
                    }
                }
                
                
            }
        }
    }
}

//}


#Preview {
    MainView()
}

