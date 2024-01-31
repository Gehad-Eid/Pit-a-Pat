//
//  playersView.swift
//  Pit-a-Pat
//
//  Created by Faizah Almalki on 19/07/1445 AH.
//


import SwiftUI
import CloudKit
    struct PlayersView: View {

        @StateObject var viewModel = ViewModel()

        var body: some View {
            ZStack {
                ARViewRepresentable(blurred: true)
                    .edgesIgnoringSafeArea(.all)
            
//                Circle()
//                    .trim(from: 0, to: 0.5)
//                    .foregroundColor(Color("Color1"))
//                    .frame(width: 850 , height: 400)
//                    .offset(y: -490)
//                
                
                
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(width: 353, height: 583)
                    .cornerRadius(10)
                    .overlay(
                        ScrollView {
                            VStack {
                                ForEach(viewModel.players) { player in
                                    Rectangle()
                                        .foregroundColor(Color.white)
                                        .frame(width: 338, height: 83)
                                        .cornerRadius(12)
                                        .overlay(
                                            HStack {
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

                                                Text("⭐️    \(player.score)")
                                            }
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(8)
                                        )
                                }
                            } .padding(.top, 20)
                        }
                    )
                    .cornerRadius(10)
            }
            .onAppear {
                viewModel.fetchLearners()
            }
        }
    }

    struct PlayersView_Previews: PreviewProvider {
        static var previews: some View {
            PlayersView()
        }
    }

