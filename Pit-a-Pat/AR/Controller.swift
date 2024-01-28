//
//  Methods.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 28/01/2024.
//

import SwiftUI
import RealityKit
import ARKit

class Controller: UIViewController {
    @IBOutlet var arView : ARView!
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        setUpARView()
        
        arView.session.delegate = self
        
        // plan B tap gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        arView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func setUpARView() {
        arView.automaticallyConfigureSession = false
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        arView.session.run(config)
    }
    
    // plan B tap gesture ,,, but here ll be the hole generatoer ig
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let anchor = ARAnchor(name: "Ball", transform: arView!.cameraTransform.matrix)
        arView.session.add (anchor: anchor)
    }
    
    func placeObject (named entityName: String, for anchor: ARAnchor) {
        let ballEntity = try! ModelEntity.load(named: entityName)
        let anchorEntity = AnchorEntity (anchor: anchor)
        anchorEntity.addChild(ballEntity)
        arView.scene.addAnchor(anchorEntity)
        
        // remove the anchor when done animating
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55){
            self.arView.scene.removeAnchor(anchorEntity)
        }
    }
}

extension Controller: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == "Ball"{
                placeObject(named: anchorName, for: anchor)
            }
        }
    }
}

