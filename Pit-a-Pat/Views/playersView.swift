import SwiftUI
import CloudKit

struct PlayersView: View {
    @StateObject var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode
    let loggedInUsername: String // تمرير اسم المستخدم المسجل

    init(loggedInUsername: String) {
        self.loggedInUsername = loggedInUsername
    }

    var body: some View {
        NavigationView {
            ZStack {
                ARViewRepresentable(blurred: true)
                    .edgesIgnoringSafeArea(.all)

                Image("Subtract")
                    .offset(y: -370)

                Text("Leaderboard")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color.white)
                    .offset(y: -340)

                VStack {
                    Rectangle()
                        .foregroundColor(Color.white.opacity(0.7))
                        .frame(width: 353, height: 583)
                        .cornerRadius(10)
                        .overlay(
                            ScrollView {
                                VStack {
                                    ForEach(0..<viewModel.players.count, id: \.self) { index in
                                        let player = viewModel.players[index]
                                        let rank = index + 1
                                        let isCurrentUser = player.Name == loggedInUsername
                                        Rectangle()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .foregroundColor(Color.white)
                                            .frame(width: 338, height: 83)
                                            .border(isCurrentUser ? Color.red : Color.white, width: 4)
                                            .overlay(
                                        
                                                HStack {
                                                    Text("\(rank)")
                                                        .font(.system(size: 30, weight: .semibold))
                                                         .foregroundColor(rank <= 3 ? Color("Color1") : Color.black)
                                                    
                                                    Image("avatar\(Int.random(in: 1..<7))")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 64, height: 64)
                                                        .clipShape(Circle())
                                                        .padding(.vertical)
                                                        .padding(.horizontal, 2)

                                                    Text("\(player.Name)")
                                                        .font(.title3)
                                                        .fontWeight(.semibold)

                                                    Spacer()

                                                    Text("⭐️ \(player.score)")
                                                        .font(.title3)
                                                        .fontWeight(.semibold)
                                                    
                                                }
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                       .padding(8)
                                                
                                            )                        .cornerRadius(10)

                                    }
                                }
                                .padding(.top, 20)
                            }
                        )
                        .cornerRadius(10)
                        .padding(.bottom, -70)
                }
            }
            .onAppear {
                viewModel.fetchLearners()
                viewModel.sortPlayersByScore()
            }
      
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                           Button(action: {
                               withAnimation {
                                   presentationMode.wrappedValue.dismiss()
                               }
                           }) {
                               Image(systemName: "chevron.backward")
                                   .foregroundColor(.white)
                           }
        )
    }
}
