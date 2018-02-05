//
//  SCNNodeHelpers.swift
//  jumpARun
//
//  Created by Sergej Nawalnew on 28.11.17.
//  Copyright © 2017 Sergej Nawalnew. All rights reserved.
//

import SceneKit
import ARKit
import GameplayKit

func nodeWithModelName(_ modelName: String) -> SCNNode {
    return SCNScene(named: modelName)!.rootNode.clone()
}

func createPlaneNode(center: vector_float3, extent: vector_float3) -> SCNNode {
    let plane = SCNPlane(width: CGFloat(extent.x), height: CGFloat(extent.z))
    
    let planeMaterial = SCNMaterial()
    planeMaterial.diffuse.contents = UIColor.blue.withAlphaComponent(0.4)
    plane.materials = [planeMaterial]
    let planeNode = SCNNode(geometry: plane)
    planeNode.position = SCNVector3Make(center.x, 0, center.z)
    planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
    
    return planeNode
}

// Random Obstacles
func createRandomObstacleNode(center: vector_float3, width: CGFloat, height: CGFloat, length: CGFloat ) -> SCNNode {
    let field = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
    
    let planeMaterial = SCNMaterial()
    
    
    planeMaterial.diffuse.contents = "blockstone.jpg"
    
    
    
    
    field.materials = [planeMaterial]
    
    let fieldNode = SCNNode(geometry: field)
    fieldNode.position = SCNVector3Make(center.x, center.y, center.z)
    //    fieldNode.transform = SCNMatrix4MakeRotation(-Float.pi / Float(width), Float(length), Float(height), 0)
    // fieldNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)

    
    return fieldNode
}

// Spielfigur erstellen
// Create Player NODE
func createPlayerFigureNode(center: vector_float3, width: CGFloat, height: CGFloat, length: CGFloat ) -> SCNNode {
    let player = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
    
    let planeMaterial = SCNMaterial()
    
    
    planeMaterial.diffuse.contents = UIColor.green.withAlphaComponent(1)
    
    
    
    
    player.materials = [planeMaterial]
    
    let fieldNode = SCNNode(geometry: player)
    fieldNode.position = SCNVector3Make(center.x, center.y, center.z)
    //    fieldNode.transform = SCNMatrix4MakeRotation(-Float.pi / Float(width), Float(length), Float(height), 0)
    // fieldNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
    
    
    return fieldNode
}

// Spielfeld erstellen
func createFieldNode(center: vector_float3) -> SCNNode {
    let field = SCNBox(width: 1, height: 0.05, length: 1, chamferRadius: 0)

    let planeMaterial = SCNMaterial()
    // Material festlegen
        planeMaterial.diffuse.contents = "gras.jpg"
    

    field.materials = [planeMaterial]

    let fieldNode = SCNNode(geometry: field)
    fieldNode.position = SCNVector3Make(center.x, 0, center.z)
    // fieldNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)

    return fieldNode
}





//func createFieldNode2(center: vector_float3) -> SCNNode {
//    let field = SCNBox(width: 0.5, height: 0.05, length: 0.5, chamferRadius: 0)
//
//    let planeMaterial = SCNMaterial()
//    planeMaterial.diffuse.contents = UIColor.red.withAlphaComponent(1)
//    field.materials = [planeMaterial]
//
//    let fieldNode = SCNNode(geometry: field)
//    fieldNode.position = SCNVector3Make(center.x, 0, 0)
//    // fieldNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
//
//    return fieldNode
//}



func updatePlaneNode(_ node: SCNNode, center: vector_float3, extent: vector_float3) {
    let geometry = node.geometry as! SCNPlane
    
    geometry.width = CGFloat(extent.x)
    geometry.height = CGFloat(extent.z)
    node.position = SCNVector3Make(center.x, 0, center.z)
}

func removeChildren(inNode node: SCNNode) {
    for node in node.childNodes {
        node.removeFromParentNode()
    }
}

func createSphereNode(radius: CGFloat) -> SCNNode {
    let sphere = SCNSphere(radius:radius)
    sphere.firstMaterial?.diffuse.contents = UIColor.red
    
    
    return SCNNode(geometry: sphere)
}

func createLineNode(fromNode: SCNNode, toNode: SCNNode) -> SCNNode {
    let line = lineFrom(vector: fromNode.position, toVector: toNode.position)
    let lineNode = SCNNode(geometry: line)
    let planeMaterial = SCNMaterial()
    planeMaterial.diffuse.contents = UIColor.red
    line.materials = [planeMaterial]
    return lineNode
}

func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
    let indices: [Int32] = [0, 1]
    
    let source = SCNGeometrySource(vertices: [vector1, vector2])
    let element = SCNGeometryElement(indices: indices, primitiveType: .line)
    
    return SCNGeometry(sources: [source], elements: [element])
}


func applyForce(to node: SCNNode) {
    let forceX = Float(GKRandomSource.sharedRandom().nextInt(upperBound: 3))
    let forceY = Float(GKRandomSource.sharedRandom().nextInt(upperBound: 3))
    let forceZ = Float(GKRandomSource.sharedRandom().nextInt(upperBound: 3))
    node.physicsBody?.applyForce(SCNVector3Make(forceX, forceY, forceZ), asImpulse: true)
}


