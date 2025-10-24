//
//  CloudFreeViewController.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 4/7/24.
//

import UIKit
import SceneKit
import ARKit
import SwiftUI

enum ShapeType:Int {

  case purplecloud = 0
  case pinkcloud
  case greencloud
  case bluecloud


  static func random() -> ShapeType {
    let maxValue = bluecloud.rawValue
    let rand = arc4random_uniform(UInt32(maxValue+1))
    return ShapeType(rawValue: Int(rand))!
  }
}

//ball geometry
let ball = SCNSphere(radius: 0.5)


class CloudFreeViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    
    var sceneView: ARSCNView {
       return self.view as! ARSCNView
    }
    override func loadView() {
      self.view = ARSCNView(frame: .zero)
    }

    //gesture recognizer for tapping node/view
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(location, options: nil)
        startGame()
        if hitResults.count > 0 {
            let result = hitResults[0]
            let node = result.node
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            let materials = node.geometry?.materials as! [SCNMaterial]
            let material = materials[0]
            SCNTransaction.commit()
            let action = SCNAction.moveBy(x: 0, y: -0.8, z: 0, duration: 0.5)
            node.runAction(action)
            node.removeFromParentNode()
        }
        
    }
    
    
    var trackerNode: SCNNode?
    var foundSurface = false
    var tracking = true
    let ballNode = SCNNode(geometry: ball)


    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        // Create a new scene
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        let scene = SCNScene(named: "art.scnassets/scene2.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self

        playBackgroundMusic()
        sceneView.scene.background.contents = UIImage(named: "background")

        
    }
    
    //generates random cloud shapes in scene
    func spawnShape() {
        var geometry:SCNGeometry
        let purplecloud = SCNScene(named: "art.scnassets/purplecloud.scn")
        let greencloud = SCNScene(named: "art.scnassets/greencloud.scn")
        let pinkcloud = SCNScene(named: "art.scnassets/pinkcloud.scn")
        let bluecloud = SCNScene(named: "art.scnassets/bluecloud.scn")
        
        let purplecloudNode = purplecloud?.rootNode.childNodes[0]
        let greencloudNode = greencloud?.rootNode.childNodes[0]
        let pinkcloudNode = pinkcloud?.rootNode.childNodes[0]
        let bluecloudNode = bluecloud?.rootNode.childNodes[0]
        
        
        switch ShapeType.random() {
        case .purplecloud:
            geometry = (purplecloudNode?.geometry)!
        case .greencloud:
            geometry = (greencloudNode?.geometry)!
        case .pinkcloud:
            geometry = (pinkcloudNode?.geometry)!
        case .bluecloud:
            geometry = (bluecloudNode?.geometry)!
        }
        
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        let randomX = Float.random(in: 80..<150)
        let randomY = Float.random(in: 80..<150)
        let randomZ = Float.random(in: 80..<150)
        let force = SCNVector3(x: randomX, y: randomY , z: randomZ)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        
        self.sceneView.scene.rootNode.addChildNode(geometryNode)
    }
    
    //plays music in background
    func playBackgroundMusic(){
        let audioNode = SCNNode()
        if let audioSource = SCNAudioSource(fileNamed: "art.scnassets/Adventure-320bit.mp3") {

            audioSource.volume = 1
            audioSource.isPositional = true
            audioSource.shouldStream = false
            audioSource.loops = true
            audioSource.load()
            let player = SCNAudioPlayer(source: audioSource)
            audioNode.addAudioPlayer(player)

            let soundAction = SCNAction.playAudio(audioSource, waitForCompletion: false)

            audioNode.runAction(soundAction)
            
            // Add the first node to the scene
            sceneView.scene.rootNode.addChildNode(audioNode)
        }

    }
    
    //starting game
    func startGame() {
        //creates new scene frame
        guard let frame = sceneView.session.currentFrame else { return }
        let camMatrix = SCNMatrix4(frame.camera.transform)
        let direction = SCNVector3Make(-camMatrix.m31 * 5.0, -camMatrix.m32 * 10.0, -camMatrix.m33 * 5.0)
        let position = SCNVector3Make(camMatrix.m33, camMatrix.m34, camMatrix.m34)
        
        //ball node attributes
        ball.firstMaterial?.diffuse.contents = UIColor.white
        ball.firstMaterial?.emission.contents = UIColor.white //2
        ballNode.position = position //3
        ballNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        ballNode.physicsBody?.categoryBitMask = 3
        ballNode.physicsBody?.contactTestBitMask = 1 //4
        ballNode.physicsBody?.isAffectedByGravity = false //4
        ballNode.physicsBody?.categoryBitMask = CollisionCategory.missileCategory.rawValue
        ballNode.physicsBody?.collisionBitMask = CollisionCategory.targetCategory.rawValue
        sceneView.scene.rootNode.addChildNode(ballNode)
        ballNode.physicsBody?.applyForce(direction, asImpulse: true)
        spawnShape()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    
    // Explosion Work in progress
    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact) {
//6
        let cloudNodes = sceneView.scene.rootNode.childNodes
        
        for node in cloudNodes {
        if (contact.nodeA == node || contact.nodeA == ballNode) && (contact.nodeB == node || contact.nodeB == ballNode) {
//            let particleSystem = SCNParticleSystem(named: "Explosion", inDirectory: nil)!
            let systemNode = SCNNode()
//            systemNode.addParticleSystem(particleSystem)
            systemNode.position = contact.nodeA.position
            sceneView.scene.rootNode.addChildNode(systemNode)
             
            contact.nodeA.removeFromParentNode()
            contact.nodeB.removeFromParentNode()
        }
        }
    }
    
}
struct CollisionCategory: OptionSet {
   let rawValue: Int
   static let missileCategory  = CollisionCategory(rawValue: 1 << 0)
   static let targetCategory = CollisionCategory(rawValue: 1 << 1)
}

struct CloudFreeViewControllerRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        return CloudFreeViewController()

    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }

}
