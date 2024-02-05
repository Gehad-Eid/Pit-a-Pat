//  Created by Gehad Eid and Abrar Ghandurah  (best colap ever) on 28/01/2024.

import SwiftUI
import ARKit
import RealityKit
import Combine

import MultipeerSession


class CustomARView : ARView {
    
    //    var score : Int
    
    var multipeerSession: MultipeerSession?
    var sessionIDObservation: NSKeyValueObservation?
    //    static let sharedAR = CustomARView()
    
    var profileVM: ProfileViewModel // Assuming ProfileViewModel is already defined elsewhere
    
    // Updated required initializer to include ProfileViewModel parameter
    required init(frame frameRect: CGRect, profileVM: ProfileViewModel) {
        self.shouldAddBlurredRectangle = false
        self.profileVM = profileVM
        super.init(frame: frameRect)
        //            setUpARView() // Assuming you want to set up the AR view upon initialization
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init?(coder decoder: NSCoder) isn't implemented")
    }
    
    var shouldAddBlurredRectangle: Bool
    //    var profileVM: ProfileViewModel
    
    convenience init(frame frameRect: CGRect = UIScreen.main.bounds, shouldAddBlurredRectangle: Bool = false, profileVM: ProfileViewModel) {
        self.init(frame: frameRect, profileVM: profileVM)
        self.shouldAddBlurredRectangle = shouldAddBlurredRectangle
        
        session.delegate = self
        
        // Set the configuration
        setUpARView()
        setupMultipeerSession()
        
        //add a blurred rectangle if the parameter is true
        if shouldAddBlurredRectangle {
            addBlurredRectangle()
        }
        
        subscribeToARStream()
        
        startSceneUpdate()
        
    }
    
    @MainActor override required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func setupMultipeerSession(){
        // monitor the ARSession's identifier
        sessionIDObservation = observe(\.session.identifier, options: [.new]) { object, change in
            print("SessionID changed to: \(change.newValue!)")
            
            // Tell all other peers about the ARSession's changed ID, so that they can keep track of which ARAnchors are yours.
            guard let multipeerSession = self.multipeerSession else { return }
            self.sendARSessionIDTo(peers: multipeerSession.connectedPeers)
        }
        
        // Start looking for other players via MultiPeerConnectivity.
        multipeerSession = MultipeerSession(
            serviceName: "pit-a-pat",
            receivedDataHandler: self.receivedData,
            peerJoinedHandler: self.peerJoined,
            peerLeftHandler: self.peerLeft,
            peerDiscoveredHandler: self.peerDiscovered
        )
    }
    
    // Property to store the trigger volume
    var triggerVolume = TriggerVolume(shape: .generateBox(size: [0.2,0.2,0.2]), filter: .sensor)
    
    // Function to create and update anchors
    func updateAnchors() {
        // Remove the anchor from the previous frame
        triggerVolume.removeFromParent()
        
        // Create a new anchor at the camera's position
        let cameraTransform = self.cameraTransform

        let newTriggerVolume =  TriggerVolume(shape: .generateBox(size: [0.2,0.2,0.2]), filter: CollisionFilter(group: CollisionGroup(rawValue: 2), mask: CollisionGroup(rawValue: 1)))
        newTriggerVolume.transform = cameraTransform
        newTriggerVolume.name = "triggerVolume"
        
        // Add the new anchor to the scene
        scene.anchors.append(newTriggerVolume)
        
        // Save the reference to the current anchor
        triggerVolume = newTriggerVolume
    }
    
    var count = 0
    
//    @StateObject var profileVM = ProfileViewModel()

    
    var collisionSubscriptions = [Cancellable]()
    func addCollisionListening(onEntity entity: Entity & HasCollision) {
        collisionSubscriptions.append(self.scene.subscribe(to: CollisionEvents.Began.self, on: entity) {  /*[weak self]*/ event in
            
            self.count += 1
            self.profileVM.score += 1
            
            Task {
                do {
                    await self.profileVM.saveProfile()
                } catch {
                    print("Failed to save profile: \(error)")
                }
            }
//            await self.profileVM.saveProfile()
            //Place code here for when the collision begins.
            print(event.entityA.name, "collided with", event.entityB.name)
//            print(self.count)
            print(self.profileVM.score)
            self.scene.anchors.removeAll()
        })
        collisionSubscriptions.append(self.scene.subscribe(to: CollisionEvents.Ended.self, on: entity) { event in
            print(event.entityA.name, "stoped colliding with", event.entityB.name)
            //Place code here for when the collision ends.
        })
    }
    
    
    // Subscribe to scene updates
    private var sceneUpdateCancellable: Cancellable?
    
    // Function to start subscribing to scene updates
    func startSceneUpdate() {
        sceneUpdateCancellable = scene.subscribe(to: SceneEvents.Update.self) { [weak self] _ in
            self?.updateAnchors()
        }
    }
    
    // Function to stop subscribing to scene updates
    func stopSceneUpdate() {
        sceneUpdateCancellable?.cancel()
        sceneUpdateCancellable = nil
    }
    
    
    // Array of entity names
    let entityNames = ["BallYellow", "BallRed", "BallPurple", "BallOrange", "BallGreen", "BallBlue", "BallBink"]
    
    // BallEntity property
    var BallEntity = try? Entity.load(named: "BallYellow")
    
    
    //  Function to throw balls
    func throwBalls() {
        // Shuffle the array to randomize entity selection
        var shuffledEntityNames = entityNames.shuffled()
        print(shuffledEntityNames)
        
        let anchors = scene.anchors.compactMap { $0 as? AnchorEntity }
        
        let name = shuffledEntityNames.first
        print(name!)
        
        // Attempt to load the BallEntity
        BallEntity = try? Entity.load(named: name ?? "BallYellow")
        BallEntity?.name = name!
        
        BallEntity?.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateBox(size: [0.2,0.2,0.2])],
            mode: .trigger,
            filter: CollisionFilter(group: CollisionGroup(rawValue: 1), mask: CollisionGroup(rawValue: 2))
        )
        
        addCollisionListening(onEntity: BallEntity! as Entity & HasCollision)
        
        print("did load \(BallEntity!)")
        
        
        var didAddBall = false
        
        for anchor in anchors {
            // Select a random ball
            let randomBallEntityName = shuffledEntityNames.randomElement()
            let randomBallEntity = try? Entity.load(named: randomBallEntityName ?? "")
            
            // Add 2 balls of the same color to the scene
            if !didAddBall {
                
                anchor.addChild(BallEntity!)
                didAddBall = true
                print("sameBallcount = \(didAddBall)")
                
                // Remove the ball from the array
                shuffledEntityNames.removeFirst()
                print("did add 2 ")
            } else {
                anchor.addChild(randomBallEntity!)
                print("did add 1")
            }
        }
    }
    
    
    // Configuration
    func setUpARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        config.isCollaborationEnabled = true
        
        session.run(config)
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToARStream() {
        ARManager.shared
            .ARStream
            .sink { [weak self] action in
                switch action {
                case .addHoles: //.addHoles(let difficulty):
                    self?.addHoles()
                    
                case .throwBalls:
                    self?.throwBalls()
                    
                case .removeAll:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    func addHoles() {
        let hole = try? Entity.load(named: "Hole")
        hole?.name = "Hole"
        
        let anchor = AnchorEntity(plane: .horizontal)
//        let ancho = ARAnchor(name: "Hole", transform: T##simd_float4x4)
        
        anchor.addChild(hole!)
        
        scene.addAnchor(anchor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        // Perform a hit test on the ARView to find a horizontal plane at the touch location.
        let hitTestResults = hitTest(location, types: .existingPlaneUsingExtent)
        guard let hitTestResult = hitTestResults.first else { return }

        // Use the hit test result to create an ARAnchor and add it to the session.
        let anchor = ARAnchor(name: "HoleAnchor", transform: hitTestResult.worldTransform)
        session.add(anchor: anchor)
        
        // Optionally, place an object at the anchor's location.
//        placeObject(named: "Hole", for: anchor)
    }
    
    func placeObject(named entityName: String, for anchor: ARAnchor) {
        // Load the entity by name, assuming it is defined elsewhere.
        guard let entity = try? Entity.load(named: entityName) else { return }
        entity.name = entityName // Set the entity's name, useful for identification.
        
        // Create an AnchorEntity to manage the placement in RealityKit.
        let anchorEntity = AnchorEntity(anchor: anchor)
        anchorEntity.addChild(entity)
        
        // Add the anchorEntity to the ARView's scene.
        scene.addAnchor(anchorEntity)
    }
    
//    func placeObject (named entityName: String, for anchor: ARAnchor) {
//        let hole = try? Entity.load(named: "Hole")
//        hole?.name = "Hole"
//        
//        let anchorEntity = AnchorEntity(plane: .horizontal)
//        anchorEntity.addChild(hole!)
//        
//        scene.addAnchor(anchorEntity)
//    }
    
    // Function to add a blurred rectangle
    func addBlurredRectangle() {
        let blurredRectangle = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurredRectangle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurredRectangle)
        
        blurredRectangle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurredRectangle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurredRectangle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurredRectangle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
extension CustomARView : ARSessionDelegate{
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == "HoleAnchor" {
                placeObject(named: "Hole", for: anchor)
                print("triggerVolume has been found")
            }else{
                print(anchor.name ?? "nil")
            }
            
            if let participantAnchor = anchor as? ARParticipantAnchor {
                print( "Successfully connected with another user!")
                
                let anchorEntity = AnchorEntity(anchor: participantAnchor)
                let pat = try? Entity.load(named: "Pat")
                pat?.name = "Pat"
                
                anchorEntity.addChild(pat!)
                scene.addAnchor(anchorEntity)
            }
        }
    }
}


// MARK: - MultipeerSession

extension CustomARView {
    private func sendARSessionIDTo(peers: [PeerID]) {
        guard let multipeerSession = multipeerSession else { return }
        
        let idString = session.identifier.uuidString
        let command = "SessionID:" + idString
        if let commandData = command.data(using: .utf8) {
            multipeerSession.sendToPeers(commandData, reliably: true, peers: peers)
        }
    }
    
    func receivedData(_ data: Data, from peer: PeerID) {
        guard let multipeerSession = multipeerSession else { return }
        
        if let collaborationData = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARSession.CollaborationData.self, from: data) {
            session.update(with: collaborationData)
            return
        }
        
        let sessionIDCommandString = "SessionID:"
        if let commandString = String(data: data, encoding: .utf8), commandString.starts (with: sessionIDCommandString) {
            let newSessionID = String (commandString[commandString.index(commandString.startIndex,
                                                                         offsetBy:
                                                                            sessionIDCommandString.count)...])
            
            // If this peer was using a different session ID before, remove all its associated anchors.
            // This will remove the old participant anchor and its geometry from the scene.
            if let oldSessionID = multipeerSession.peerSessionIDs[peer] {
                removeAllAnchorsOriginatingFromARSessionWithID(oldSessionID)
            }
            multipeerSession.peerSessionIDs[peer] = newSessionID
        }
    }
    
    func peerDiscovered(_ peer: PeerID) -> Bool {
        guard let multipeerSession = multipeerSession else { return false }
        
        // Do not accept more than 2 users in the experience
        if multipeerSession.connectedPeers.count > 2 {
            print("A 3rd player wants to join to the game, while it's currently limited to 2 players.")
            return false
        } else {
            return true
        }
    }
    
    func peerJoined(_ peer: PeerID) {
        print ("""
              A player wants to join the game.
              Hold the devices next to each other.
""")
        // Provide your session ID to the new user so they can keep track of your anchors.
        sendARSessionIDTo(peers: [peer])
    }
    
    func peerLeft(_ peer: PeerID) {
        guard let multipeerSession = multipeerSession else { return }
        
        print("A player has left the game.")
        
        // Remove all ARAnchors associated with the peer that just left the experience.
        if let sessionID = multipeerSession.peerSessionIDs[peer] {
            removeAllAnchorsOriginatingFromARSessionWithID(sessionID)
            multipeerSession.peerSessionIDs.removeValue(forKey: peer)
        }
    }
    
    private func removeAllAnchorsOriginatingFromARSessionWithID(_ identifier: String) {
        guard let frame = session.currentFrame else { return }
        
        for anchor in frame.anchors {
            guard let anchorSessionID = anchor.sessionIdentifier else { continue }
            if anchorSessionID.uuidString == identifier {
               session.remove(anchor: anchor)
            }
        }
    }
    
    func session(_ session: ARSession, didOutputCollaborationData data: ARSession.CollaborationData) {
        guard let multipeerSession = multipeerSession else { return }
        
        if !multipeerSession.connectedPeers.isEmpty {
            guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
                    
            else { fatalError("Unexpectedly failed to encode collaboration data.") }
            
            // Use reliable mode if the data is critical, and unreliable mode if the data is optional.
            let dataIsCritical = data.priority == .critical
            multipeerSession.sendToAllPeers(encodedData, reliably: dataIsCritical)
        } else {
            print("Deferred sending collaboration to later because there are no peers.")
        }
    }
    
    
}

extension TriggerVolume : HasAnchoring{}
extension Entity : HasCollision{}
