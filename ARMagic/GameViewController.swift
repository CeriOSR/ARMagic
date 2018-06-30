//
//  GameViewController.swift
//  ARMagic
//
//  Created by Rey Cerio on 2018-06-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
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
        
        arscnView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        arscnView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        arscnView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        arscnView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        plusButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)

    }
    
    private func configureAR(arView: ARSCNView) {
        arView.session.run(configuration, options: [])
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    @objc func handlePlusButtonTapped() {
        print("Button pressed!")
    }
    
    
}
