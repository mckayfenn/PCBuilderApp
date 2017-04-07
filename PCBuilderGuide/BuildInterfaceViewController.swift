//
//  BuildInterfaceViewController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/7/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class BuildInterfaceViewController: UIViewController, BuildInterfaceViewDelegate {
    
    private var buildInterfaceView: BuildInterfaceView { return view as! BuildInterfaceView }
    //private var buildInterfaceView: BuildInterfaceView { return view as! BuildInterfaceView }
    
    override func loadView() {
        view = BuildInterfaceView()
        self.edgesForExtendedLayout = [] // don't remember what this does
        
        buildInterfaceView.delegate = self
    }
    
    override func viewDidLoad() {
        buildInterfaceView.backgroundColor = UIColor.white
        
        let saveBuild = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClicked))
        self.navigationItem.rightBarButtonItem = saveBuild
        
    }
    
    func buttonTouched() {
        print("Button was touched")
    }
    
    func saveClicked() {
        print("Save clicked!")
    }
}
