//
//  View.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 28/01/2024.
//

import SwiftUI


struct ARViewRepresentable : UIViewRepresentable {
    // by default the camera isn't blurred
        @State var blurred = false
    
    func makeUIView(context: Context) -> CustomARView {
        if blurred {
            return CustomARView(shouldAddBlurredRectangle: false)
        }
            
        return CustomARView()
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
}










//struct ARViewContainer: UIViewRepresentable {
//    
//    // by default the camera is blurred
//    @State var blurred = true
//    
//    func makeUIView(context: Context) -> ARView {
//        let arView = ARView(frame: .zero)
//        
//        if blurred {
//            // Create and add blurred rectangle to the camera
//            let blurredRectangle = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
//            blurredRectangle.translatesAutoresizingMaskIntoConstraints = false
//            arView.addSubview(blurredRectangle)
//            
//            blurredRectangle.leadingAnchor.constraint(equalTo: arView.leadingAnchor).isActive = true
//            blurredRectangle.trailingAnchor.constraint(equalTo: arView.trailingAnchor).isActive = true
//            blurredRectangle.topAnchor.constraint(equalTo: arView.topAnchor).isActive = true
//            blurredRectangle.bottomAnchor.constraint(equalTo: arView.bottomAnchor).isActive = true
//        }
//
//        
////        let mesh = MeshResource.generateBox(size: 0.2, cornerRadius: 0.005)
////        let material = SimpleMaterial(color: .red, roughness: 0.5, isMetallic: true)
////        let model = ModelEntity(mesh: mesh, materials: [material])
////
////        let mesh2 = MeshResource.generateBox(size: 0.2, cornerRadius: 0.005)
////        let material2 = SimpleMaterial(color: .blue, roughness: 0.5, isMetallic: true)
////        let model2 = ModelEntity(mesh: mesh2, materials: [material2])
////
////        // Create and add 3D boxes
////        let boxEntity1 = model
////        let boxEntity2 = model2
////
////
////        // Set the position of the second box above the first one
////        boxEntity2.position.y += 0.5
////
////        let anchor1 = AnchorEntity(plane: .horizontal)
////        let anchor2 = AnchorEntity(plane: .horizontal)
////
////        anchor1.addChild(boxEntity1)
////        anchor2.addChild(boxEntity2)
////
////        arView.scene.addAnchor(anchor1)
////        arView.scene.addAnchor(anchor2)
////
////        // Add tap gesture to the first box
////        model.generateCollisionShapes (recursive: true)
////
////        // Add tap gesture to the second box
////        model2.generateCollisionShapes (recursive: true)
////
////
////        arView.installGestures(.all, for: model)
////        arView.installGestures(.all, for: model2)
//        
//        return arView
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
//}
//
//
//#Preview {
//    ARViewContainer(blurred: false)
//}
