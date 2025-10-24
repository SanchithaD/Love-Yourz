//
//  Extensions.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 4/6/24.
//

import Foundation
import SceneKit
import ARKit

var width : CGFloat = 0.02
var height : CGFloat = 2
var length : CGFloat = 2

var doorLength : CGFloat = 0.3
func createBox(isDoor: Bool) -> SCNNode {
    let node = SCNNode()
    
    let firstBox = SCNBox(width: width, height: height,  length: isDoor ? doorLength : length, chamferRadius: 0)
    firstBox.firstMaterial?.diffuse.contents = UIColor(red: 204 / 255, green: 153 / 255, blue: 255 / 255, alpha: 1)
    let firstBoxNode = SCNNode(geometry: firstBox)
    firstBoxNode.renderingOrder = 200
    
    node.addChildNode(firstBoxNode)
    
    let maskedBox = SCNBox(width: width, height: height, length: length, chamferRadius : 0)
    maskedBox.firstMaterial?.diffuse.contents = UIColor(red: 153 / 255, green: 102 / 255, blue: 204 / 255, alpha: 1)
    
    maskedBox.firstMaterial?.transparency = 0.00001
    
    let maskedBoxNode = SCNNode(geometry: maskedBox)
    maskedBoxNode.renderingOrder = 100
    maskedBoxNode.position = SCNVector3.init(width, 0, 0)
    
    node.addChildNode(maskedBoxNode)
    return node
}

extension FloatingPoint {
    var degreesToRadians : Self {
        return self * .pi / 180
    }
}
