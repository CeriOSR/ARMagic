//
//  GameViewController.swift
//  ARMagic
//
//  Created by Rey Cerio on 2018-06-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

//import UIKit
import Foundation
import ARKit
import LBTAComponents

class GameViewController: UIViewController {
    
    let arscnView: ARSCNView = {
        let view = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plusButtonWidth = ScreenSize.width * 0.1
    
    lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Plus", for: UIControl.State.normal)
        button.tintColor = UIColor(red: 230, green: 145, blue: 31)
        button.layer.masksToBounds = true
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(handlePlusButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Minus", for: UIControl.State.normal)
        button.tintColor = UIColor(red: 230, green: 145, blue: 31)
        button.layer.masksToBounds = true
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(handleMinusButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: UIControl.State.normal)
        button.tintColor = UIColor(red: 230, green: 145, blue: 31)
        button.layer.masksToBounds = true
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(handleResetButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        setupViews()
        configureAR(arView: arscnView)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupViews() {
        view.addSubview(arscnView)
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        view.addSubview(resetButton)
        
        arscnView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        arscnView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        arscnView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        arscnView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        plusButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        
        minusButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        
        resetButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        resetButton.anchorCenterXToSuperview()

    }
    
    private func configureAR(arView: ARSCNView) {
        //setup of the ARView
        arView.session.run(configuration, options: [])
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        arView.autoenablesDefaultLighting = true
    }
    
    @objc func handlePlusButtonTapped() {
        print("Plus Button pressed!")
        addShape()
    }
    
    @objc func handleMinusButtonTapped() {
        print("Minus Button pressed!")
        removeElements()
    }
    
    @objc func handleResetButtonTapped() {
        print("Reset Button pressed!")
        resetScene()
    }
    
    private func addShape() {
        //adding a box into the ar scene view with the button push
        let shapeNode = SCNNode()
//        shapeNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0002)
//        shapeNode.geometry = SCNCapsule(capRadius: 0.05, height: 0.20) // if capRadius is half of height then circle.
//        shapeNode.geometry = SCNCone(topRadius: 0.0, bottomRadius: 0.10, height: 0.50)
//        shapeNode.geometry = SCNTorus(ringRadius: 0.1, pipeRadius: 0.02)
        shapeNode.geometry = SCNTube(innerRadius: 0.02, outerRadius: 0.1, height: 0.2)
        //to change the box content, you have to diffuse the contents
        shapeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        shapeNode.name = "box"
        shapeNode.position = SCNVector3(0.0, 0.0, -0.3)
        arscnView.scene.rootNode.addChildNode(shapeNode)
    }
    
    private func removeElements() {
        //remove elements based on name
        arscnView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "box" {
                node.removeFromParentNode()
            }
        }
    }
    
    private func resetScene() {
        //have to pause scene first before resetting
        arscnView.session.pause()
        arscnView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node" {
                node.removeFromParentNode()
            }
        }
        //then run it again with bare nodes
        arscnView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
}
