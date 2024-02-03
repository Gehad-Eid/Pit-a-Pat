//
//  SharedARView.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 31/01/2024.
//


import SwiftUI

struct SharedARView: View {
    // Set this variable to determine whether the AR view should be blurred
    var blurred: Bool
    
    init(blurred: Bool = false) {
        self.blurred = blurred
    }
    
    var body: some View {
        ARViewRepresentable(blurred: blurred)
            .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    SharedARView()
}
