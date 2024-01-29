//
//  ConnectWithSomeone.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 27/01/2024.
//

import SwiftUI

struct InstructionView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            //ZStack{
            ARViewRepresentable()
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    TabView(selection: $selectedTab) {
                        // Replace these with instructions for the game and how to play .. when finished it will connect with some one in ConnectWithSomeone view
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 200,height: 150)
                            .padding()
                            .overlay(
                                Text("تعليمات اللعبة في بيج فيو")
                            )
                            .tag(0)
                        
                        
                        Rectangle()
                            .fill(.orange)
                            .frame(width: 200,height: 150)
                            .padding()
                            .overlay(
                                Text("تعليمات اللعبة في بيج فيو")
                            )
                            .tag(1)
                        
                        
                        
                        Rectangle()
                            .fill(.red)
                            .frame(width: 200,height: 150)
                            .padding()
                            .overlay(
                                NavigationLink(destination: ConnectWithSomeone().navigationBarBackButtonHidden(true)) {
                                    Text("تعليمات اللعبة في بيج فيو")
                                }
                                    
                            )
                            .tag(2)
                    }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .background(Color.clear)
                        .frame(maxWidth: .infinity, maxHeight: 150)
                )
            //}
            //.navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    InstructionView()
}
