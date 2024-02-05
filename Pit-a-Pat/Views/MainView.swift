import SwiftUI

struct MainView: View {
    @StateObject var profileVM = ProfileViewModel()
    @State private var isNameInputVisible = true // تم تغيير القيمة إلى true لعرض المربع في البداية
    @State private var userNameInput = ""

    var body: some View {
        NavigationStack {
            ZStack {
                ARViewRepresentable(blurred: true)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("PitAPat")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250)
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
                    
                    NavigationLink(destination: PlayersView(loggedInUsername: profileVM.Name)) {
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
                
                if isNameInputVisible {
                    Rectangle()
                        .fill(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            VStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 300, height: 185)
                                    .cornerRadius(12)
                                    .overlay(
                                        VStack {
                                            Spacer()
                                            Text("What name would you like to use?")
                                                .padding(.top)
                                                .foregroundColor(.black)
                                            TextField("Enter your name", text: $userNameInput)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .padding()
                                            Button("Save") {
                                                profileVM.Name = userNameInput
                                                isNameInputVisible = false
                                                Task {
                                                    await profileVM.saveProfile()
                                                }
                                            }
                                            .foregroundColor(Color("Color1"))
                                            .font(.headline)
                                            .padding()
                                            .disabled(userNameInput.isEmpty)
                                            .font(.headline)
                                            .padding()
                                        }
                                    )
                            }
                        )
                        .zIndex(1)
                }
            }
            .onAppear {
                Task {
                    await profileVM.fetchUserProfile()
                    if !profileVM.Name.isEmpty {
                        isNameInputVisible = false
                    }
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
                                .font(.headline)
                                .foregroundColor(.white)
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
}
