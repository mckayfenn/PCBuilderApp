//
//  BuildInterfaceViewController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/7/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class BuildInterfaceViewController: UIViewController, BuildInterfaceViewDelegate {
    
    private var _partsList: PartsList = PartsList.Instance
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
    
    func buttonTouched(partType: String) {
        print("Button was touched: " + "\(partType)")
        let navigationFilterViewController: NavigationFilterInterfaceViewController = NavigationFilterInterfaceViewController(partType: partType)!
        
        switch partType {
        case "CPU":
            navigationFilterViewController.parts = _partsList.listOfAllParts.getListOfPartsByName(partType: "CPU") as [AnyObject]
            break
        case "Mobo":
            navigationFilterViewController.parts = _partsList.listOfAllParts.getListOfPartsByName(partType: "Motherboard") as [AnyObject]
            break
        default:
            // don't do anything
            break
        }
        
        
        navigationController?.pushViewController(navigationFilterViewController, animated: true)
    }
    
    func saveClicked() {
        print("Save clicked!")
    }
}
