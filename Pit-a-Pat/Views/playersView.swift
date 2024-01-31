//
//  playersView.swift
//  Pit-a-Pat
//
//  Created by Faizah Almalki on 19/07/1445 AH.
//


import SwiftUI
import CloudKit
struct playersView: View {

@StateObject var viewModel = ViewModel()

    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.players) { player  in
                    HStack(spacing: 2){
                        
                        
                        Image("avatar\(Int.random(in: 1..<7))")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                            .padding(.vertical)
                            .padding(.horizontal, 2)

                        VStack(alignment: .leading, spacing:6){
                            Text("\(player.Name)")
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("\(player.score)")
                           

                        }
                        .padding(8)
                    }
                }
            }
            .listStyle(.plain)
            .onAppear{
                viewModel.fetchLearners()
            }
            .navigationTitle("Players")
        }
    }



}

#Preview {
    playersView()
}








