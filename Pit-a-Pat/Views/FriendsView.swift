//
//  FriendsView.swift
//  Pit-a-Pat
//
//  Created by Faizah Almalki on 22/07/1445 AH.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
       
            ARViewRepresentable(blurred: true)
                .edgesIgnoringSafeArea(.all)

            Image("Subtract")
                .offset(y: -370)

            Text("Friends")
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
                            
                            
                        
                        }
                    )
                    .cornerRadius(10)
                    .padding(.bottom, -70)
            }
        }
    }


#Preview {
    FriendsView()
}
