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
    
    private var userBuildTotalPrice = [Int](repeating: 0, count: 9)
    
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
        
        mainBuilderView.costTotalText = 0
        for part in _usersParts!
        {
            showPictureAndTextFor(part: part)
            mainBuilderView.costTotalText += Int(part._price!)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let saveBuild = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClicked))
        self.navigationItem.rightBarButtonItem = saveBuild
        
    }
    
    func buttonTouched(partType: String) {
        navigationFilterViewController = NavigationFilterInterfaceViewController(partType: partType)!
        
        
        navigationFilterViewController?.delegate = self
        navigationFilterViewController?.usersCurrentParts = (_userBuild?.getAllParts())!
        
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
        
        view.reloadInputViews()
    }
    
    // a part was selected so pop back to this viewController
    func partWasSelected(part: MyParts) {
        navigationController?.popToViewController(self, animated: true)
        _userBuild?.addPart(part: part)
        
        showPictureAndTextFor(part: part)
        
        //iterate through userBuildsPrice total array
        mainBuilderView.costTotalText = 0
        for i in 0 ..< 9
        {
            mainBuilderView.costTotalText += userBuildTotalPrice[i]
        }
        mainBuilderView.setNeedsDisplay()
        
        if (part._isCustom)! {
            _partsList.addCustomPart(part: part)
            _partsList.saveCustomParts()
        }
        
    }
    func showPictureAndTextFor(part: MyParts)
    {
        switch part {
        case is CPU:
            buildInterfaceView?.cpuSelectedBool = true
            buildButtonsView?.cpuButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[0] = Int(part._price!)!
            break
        case is Motherboard:
            buildInterfaceView?.motherboardSelectedBool = true
            buildButtonsView?.motherboardButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[1] = Int(part._price!)!
            break
        case is RAM:
            buildInterfaceView?.ramSelectedBool = true
            buildButtonsView?.ramButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[2] = Int(part._price!)!
            break
        case is GPU:
            buildInterfaceView?.gpuSelectedBool = true
            buildButtonsView?.gpuButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[3] = Int(part._price!)!
            break
        case is Case:
            buildInterfaceView?.caseSelectedBool = true
            buildButtonsView?.caseButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[4] = Int(part._price!)!
            break
        case is PSU:
            buildInterfaceView?.psuSelectedBool = true
            buildButtonsView?.psuButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[5] = Int(part._price!)!
            break
        case is Cooler:
            buildInterfaceView?.coolerSelectedBool = true
            buildButtonsView?.coolerButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[6] = Int(part._price!)!
            break
        case is Storage:
            buildInterfaceView?.storageSelectedBool = true
            buildButtonsView?.storageButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[7] = Int(part._price!)!
            break
        case is OpticalDrive:
            buildInterfaceView?.opticalDriveSelectedBool = true
            buildButtonsView?.opticalDriveButtonTitleText = part._model! + "\n" + "Price: $" + part._price!
            userBuildTotalPrice[8] = Int(part._price!)!
            break
        default:
            // don't do anything
            break
        }
        buildInterfaceView?.setNeedsDisplay()
        buildButtonsView?.setNeedsDisplay()
    }
    
    weak var delegate: BuildInterfaceViewControllerDelegate? = nil
}
