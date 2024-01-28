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
    var body: some View {
        ZStack{
            ARViewContainer()
            
            //.navigationBarHidden(true)
            
            // هنا نشيل ذا و نحط الليدر بورد
            // بتكون من اراي نجيب الصفوف يعني في for loop
            Rectangle()
                .fill(.green)
                .frame(width: 200,height: 150)
                .padding()
                .overlay( Text("yo"))
        }
        .edgesIgnoringSafeArea(.all)
    }
}



#Preview {
    Leaderboared()
}
