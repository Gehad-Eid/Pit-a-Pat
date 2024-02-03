//
//  Leaderboared.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 27/01/2024.
//

import SwiftUI
import RealityKit
import ARKit

struct Leaderboared: View {
    let names = ["John", "Jane", "Alice", "Bob", "Charlie", "David", "Eva", "Frank", "Grace", "Harry", "Ivy", "Jack", "Kate", "Leo", "Mia"]
    let scores = [150, 120, 200, 180, 90, 300, 250, 190, 220, 170, 130, 240, 160, 280, 210]
    var body: some View {
        ZStack{
            //SharedARView(blurred: true) ARViewRepresentable
            Rectangle()
                .edgesIgnoringSafeArea(.all)
//                .blur(radius: 10)
           VStack {
                Text("Leader Board")
                    .foregroundColor(Color("Color1"))
                    .font(.title)
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(height: 450)
                    .overlay(
                        ScrollView(showsIndicators: false) {
                            VStack {
                                let sortedData = zip(names, scores).sorted { $0.1 > $1.1 }

                                ForEach(Array(sortedData.enumerated()), id: \.1.0) { (index, data) in
                                    HStack {
                                        Text("\(index + 1). \(data.0)")
                                        Spacer()
                                        Text("\(data.1)")
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                }
                            }
                        }
                        .padding()
                    )
                    .frame(maxWidth: 300)
            }
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}



#Preview {
    Leaderboared()
}
