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
        button.setTitle("Plus", for: .normal)
        button.tintColor = UIColor(red: 230, green: 145, blue: 31)
        button.layer.masksToBounds = true
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(handlePlusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Minus", for: .normal)
        button.tintColor = UIColor(red: 230, green: 145, blue: 31)
        button.layer.masksToBounds = true
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(handleMinusButtonTapped), for: .touchUpInside)
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
        
        arscnView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        arscnView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        arscnView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        arscnView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        plusButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        
        minusButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)

    }
    
    private func configureAR(arView: ARSCNView) {
        //setup of the ARView
        arView.session.run(configuration, options: [])
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        arView.autoenablesDefaultLighting = true
    }
    
    @objc func handlePlusButtonTapped() {
        print("Button pressed!")
        addBox()
    }
    
    @objc func handleMinusButtonTapped() {
        print("Button pressed!")
        removeElements()
    }
    
    private func addBox() {
        //adding a box into the ar scene view with the button push
        let boxNode = SCNNode()
        boxNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0002)
        //to change the box content, you have to diffuse the contents
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        boxNode.name = "box"
        let floatRandom = Float.random(in: -0.5...0.5)
        boxNode.position = SCNVector3(floatRandom,floatRandom,floatRandom)
        arscnView.scene.rootNode.addChildNode(boxNode)
    }
    
    private func removeElements() {
        //remove elements based on name
        arscnView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "box" {
                node.removeFromParentNode()
            }
        }
    }
}
