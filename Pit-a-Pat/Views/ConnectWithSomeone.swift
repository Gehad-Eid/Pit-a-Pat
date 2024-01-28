//
//  ConnectWithSomeone.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 27/01/2024.
//

import SwiftUI

struct ConnectWithSomeone: View {
    var body: some View {
        ZStack{
            ARViewContainer()
            
            // نحط بدالها ايميج او ثري دي عادي ماهو بالاي ار
            Rectangle()
                .fill(.red)
                .frame(width: 200,height: 150)
                .padding()
                .overlay( Text("yo"))
        }
        .edgesIgnoringSafeArea(.all)
        //.navigationBarHidden(true)
    }
}

#Preview {
    ConnectWithSomeone()
}
