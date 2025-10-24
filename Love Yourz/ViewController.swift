//
//  ViewController.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 4/6/24.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import SwiftUI



class ARView: UIViewController, ARSCNViewDelegate {
    @State private var showingAlert = false
    var boundingBox: CGRect = CGRect()

    var sceneView: ARSCNView {
        return self.view as! ARSCNView
    }
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/scene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    func setupScene() {
        let node = SCNNode()
        node.position = SCNVector3.init(0, 0, 0)
        
        let audioNode = SCNNode()
        if let audioSource = SCNAudioSource(fileNamed: "art.scnassets/LoveYourzMusic.mp3") {
            
            audioSource.volume = 1
            audioSource.isPositional = true
            audioSource.shouldStream = false
            audioSource.loops = true
            audioSource.load()
            
            let soundAction = SCNAction.playAudio(audioSource, waitForCompletion: false)
            
            audioNode.runAction(soundAction)
            
            // Add the first node to the scene
            node.addChildNode(audioNode)
        }
        
        let mirror = SCNScene(named: "art.scnassets/affirmationmirror.scn")
        let mirrorNode = mirror?.rootNode
        mirrorNode?.geometry?.firstMaterial?.lightingModel = SCNMaterial.LightingModel.constant
        mirrorNode?.position = SCNVector3.init(0, 0, (-length / 2) + width + 0.1)
        mirrorNode?.eulerAngles = SCNVector3.init(0, 180.0.degreesToRadians, 0)
        
        
        
        let journal = SCNScene(named: "art.scnassets/journaltable.scn")
        let journalNode = journal?.rootNode
        journalNode?.position = SCNVector3.init(-0.5, -0.75, -0.5)
        
        let jar = SCNScene(named: "art.scnassets/jar.scn")
        let jarNode = jar?.rootNode
        jarNode?.position = SCNVector3.init(0.5, -0.75, -0.5)
        
        let painting = SCNScene(named: "art.scnassets/painting.scn")
        print(painting?.rootNode.childNodes)
        let paintingNode = painting?.rootNode
        paintingNode?.eulerAngles = SCNVector3.init(0, -90.0.degreesToRadians, 0)
        
        paintingNode?.position = SCNVector3.init((length / 2) - width - 0.02, 0.2, -0.2)
        
        let beanbag = SCNScene(named: "art.scnassets/beanbag.scn")
        let beanbagNode = beanbag?.rootNode
        beanbagNode?.eulerAngles = SCNVector3.init(0, 90.0.degreesToRadians, 0)
        beanbagNode?.position = SCNVector3.init(-0.5, -0.75, 0.3)
        
        let castle = SCNScene(named: "art.scnassets/castle.scn")
        let castleNode = castle?.rootNode
        castleNode?.position = SCNVector3.init(0.05, -0.75, (-length / 2) + width + 0.12)
        
        let leftWall = createBox(isDoor: false)
        leftWall.worldPosition = SCNVector3.init((-length / 2) + width, 0, 0)
        leftWall.eulerAngles = SCNVector3.init(0, 180.0.degreesToRadians, 0)
        
        let rightWall = createBox(isDoor: false)
        rightWall.worldPosition = SCNVector3.init((length / 2) - width, 0, 0)
        
        let topWall = createBox(isDoor: false)
        topWall.worldPosition = SCNVector3.init(0, (height / 2) - width, 0)
        topWall.eulerAngles = SCNVector3.init(0, 0, 90.0.degreesToRadians)
        
        let bottomWall = createBox(isDoor: false)
        bottomWall.worldPosition = SCNVector3.init(0, (-height / 2) + width, 0)
        bottomWall.eulerAngles = SCNVector3.init(0, 0, -90.0.degreesToRadians)
        
        let backWall = createBox(isDoor: false)
        backWall.worldPosition = SCNVector3.init(0, 0, (-length / 2) + width)
        backWall.eulerAngles = SCNVector3.init(0, 90.0.degreesToRadians, 0)
        
        let leftDoorSide = createBox(isDoor: true)
        leftDoorSide.worldPosition = SCNVector3.init((-length / 2 + width) + (doorLength / 2), 0, (length / 2) - width)
        leftDoorSide.eulerAngles = SCNVector3.init(0, -90.0.degreesToRadians, 0)
        
        let rightDoorSide = createBox(isDoor: true)
        rightDoorSide.worldPosition = SCNVector3.init((length / 2 - width) - (doorLength / 2), 0, (length / 2) - width)
        rightDoorSide.eulerAngles = SCNVector3.init(0, -90.0.degreesToRadians, 0)
        
        let minX = backWall.boundingBox.min.x
        let minY = backWall.boundingBox.min.y
        let origin = CGPoint(x: Double(minX), y: Double(minY))
        
        let maxX = backWall.boundingBox.max.x
        let maxY = backWall.boundingBox.max.y
        
        let size = CGSize(width: Double(maxX), height: Double(maxY))
        
        boundingBox = CGRect(origin: origin, size: size)
        
        print("Max bound box: X: " + boundingBox.maxX.description + " Max bound box: Y: " + boundingBox.maxY.description + "Min bound box: X: " + boundingBox.minX.description + " Min bound box: Y: " + boundingBox.minY.description)
        
        print("BackWall: minX" + backWall.boundingBox.min.x.description)
        
        print("leftDoorSide: minX" + backWall.boundingBox.min.x.description)
        
        //Create Light
        
        let light = SCNLight()
        light.type = .omni
        light.intensity = 500
        
        let constraint = SCNLookAtConstraint(target: bottomWall)
        let constraint2 = SCNLookAtConstraint(target: leftWall)
        let constraint3 = SCNLookAtConstraint(target: rightWall)
        let constraint4 = SCNLookAtConstraint(target: topWall)
        let constraint5 = SCNLookAtConstraint(target: leftDoorSide)
        let constraint6 = SCNLookAtConstraint(target: rightDoorSide)
        
        constraint.isGimbalLockEnabled = true
        constraint2.isGimbalLockEnabled = true
        constraint3.isGimbalLockEnabled = true
        
        
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3.init(0, 0, 1)
        lightNode.constraints = [constraint, constraint2, constraint3, constraint4, constraint5, constraint6]
        node.addChildNode(lightNode)
        node.addChildNode(leftWall)
        node.addChildNode(rightWall)
        node.addChildNode(topWall)
        node.addChildNode(bottomWall)
        node.addChildNode(backWall)
        node.addChildNode(leftDoorSide)
        node.addChildNode(rightDoorSide)
        node.addChildNode(mirrorNode!)
        node.addChildNode(journalNode!)
        node.addChildNode(jarNode!)
        node.addChildNode(paintingNode!)
        node.addChildNode(beanbagNode!)
        node.addChildNode(castleNode!)
        
        print(node.childNodes)
   

        let yourLabel = UILabel(frame: CGRectMake(15, 0, 500, 200))
        yourLabel.textColor = UIColor.black
        yourLabel.text = "Click on the journal, mirror, or castle to explore!"
        self.sceneView.scene.rootNode.addChildNode(node)

    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /*
         1. Get The Current Touch Location
         2. Check That We Have Touched A Valid Node
         3. Check If The Node Has A Name
         4. Handle The Touch
         */
        
        guard let touchLocation = touches.first?.location(in: sceneView),
              let hitNode = sceneView.hitTest(touchLocation, options: nil).first?.node,
              let nodeName = hitNode.name
                
                
        else {
            //No Node Has Been Tapped
            return
            
        }
        if (nodeName == "Mirror") {
            let hostingController = UIHostingController(rootView: AffirmationsMirror(audioRecorder: AudioRecorder()))
            navigationController?.pushViewController(hostingController, animated: true)
        }
//            if (nodeName == "Painting") {
//                let persistenceController = PersistenceController.shared
//                let hostingController = UIHostingController(rootView: DrawingApp().environment(\.managedObjectContext, persistenceController.container.viewContext))
//                navigationController?.pushViewController(hostingController, animated: true)
//            }
        if (nodeName == "Journal") {
            let hostingController = UIHostingController(rootView: Journal())
            navigationController?.pushViewController(hostingController, animated: true)
        }
        if (nodeName == "Painting" || nodeName == "Jar") {
            let alert = UIAlertController(title: "Stay tuned!", message: "This feature will be coming soon.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
                    
        }
        if (nodeName == "Beanbag") {
            let hostingController = UIHostingController(rootView: CloudFreeViewControllerRepresentable())
            navigationController?.pushViewController(hostingController, animated: false)
        }
        if (nodeName == "Castle") {
            let hostingController = UIHostingController(rootView: AdventureView())
            navigationController?.pushViewController(hostingController, animated: false)
        }
        
        
        
        //Handle Event Here e.g. PerformSegue
        print(nodeName)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
      Override to create and configure nodes for anchors added to the view's session.*/

    func renderer(_ renderer: any SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
    }
     
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        let node = self.sceneView.scene.rootNode
        let maxX = boundingBox.maxX
        let maxY = boundingBox.maxY
        
        let minX = boundingBox.minX
        let minY = boundingBox.minY
        
        print("Max bound box: X: " + boundingBox.maxX.description + " Max bound box: Y: " + boundingBox.maxY.description + "Min bound box: X: " + boundingBox.minX.description + " Min bound box: Y: " + boundingBox.minY.description)
        
        
        
//        let minX = backWall.boundingBox.min.x
//        let minY = backWall.boundingBox.min.y
//
//
//
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    func makeUIViewController(context: Context) -> UINavigationController {
        var navigationController = UINavigationController()
        var arView = ARView()
        navigationController.viewControllers = [arView]
        return navigationController
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

