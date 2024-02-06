//
//  CameraView.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 05/02/2024.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        CameraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
    }
}
