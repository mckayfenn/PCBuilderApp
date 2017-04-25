//
//  BuildInterfaceViewController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/7/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol BuildInterfaceViewControllerDelegate: class {
    func saveBuilds()
}

class BuildInterfaceViewController: UIViewController, BuildInterfaceViewDelegate, BuildButtonsViewDelegate, NavigationFilterInterfaceControllerDelegate{
    
    private var _partsList: PartsList = PartsList.Instance
    private var _usersParts: [MyParts]? = nil
    
    private var buildInterfaceView: BuildInterfaceView? = nil
    private var buildButtonsView: BuildButtonsView? = nil
    private var mainBuilderView: MainBuilderView { return view as! MainBuilderView }
    
    private var navigationFilterViewController: NavigationFilterInterfaceViewController? = nil
    
    private var _viewTitle: String = "Custom Build"
    
    private var _userBuild: UserBuild? = nil
    
    public init(build: UserBuild) {
        super.init(nibName: nil, bundle: nil)
        
        _usersParts = build.getAllParts()
        _viewTitle = build.buildTitle
    
        
        _userBuild = build
    }
    
    public init(parts: [MyParts], title: String) {
        super.init(nibName: nil, bundle: nil)
        
        _usersParts = parts
        _viewTitle = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.title = _viewTitle
        
        buildInterfaceView = BuildInterfaceView()
        buildButtonsView = BuildButtonsView()
        view = MainBuilderView(frame: UIScreen.main.bounds, buildView: buildInterfaceView! , buildButtonsView: buildButtonsView!)
        self.edgesForExtendedLayout = [] // don't remember what this does
        
        buildInterfaceView?.delegate = self
        buildButtonsView?.delegate = self
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainBuilderView.backgroundColor = UIColor.white
        
        let saveBuild = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClicked))
        self.navigationItem.rightBarButtonItem = saveBuild
        
    }
    
    func buttonTouched(partType: String) {
        navigationFilterViewController = NavigationFilterInterfaceViewController(partType: partType)!
        
//        switch partType {
//        case "CPU":
//            navigationFilterViewController.parts = _partsList.listOfAllParts.getListOfPartsByManufacturer(partType: "CPU") as [AnyObject]
//            break
//        case "Mobo":
//            navigationFilterViewController.parts = _partsList.listOfAllParts.getListOfPartsByName(partType: "Motherboard") as [AnyObject]
//            break
//        default:
//            // don't do anything
//            break
//        }
        
        navigationFilterViewController?.delegate = self
        
        navigationController?.pushViewController(navigationFilterViewController!, animated: true)
    }
    
    func saveClicked() {

        let alertController = UIAlertController(title: "", message: "Please enter a name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                // store your data
                UserDefaults.standard.set(field.text, forKey: "saveBuild")
                UserDefaults.standard.synchronize()
                self.saveBuild(title: field.text!)
            } else {
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
            
    }
    
    func saveBuild(title: String) {
        _viewTitle = title
        
        _userBuild?.buildTitle = title
        
        delegate?.saveBuilds()
    }
    
    // a part was selected so pop back to this viewController
    func partWasSelected(part: MyParts) {
        navigationController?.popToViewController(self, animated: true)
        _userBuild?.addPart(part: part)
    }
    
    weak var delegate: BuildInterfaceViewControllerDelegate? = nil
}
