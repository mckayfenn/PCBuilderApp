//
//  NavigationFilterInterfaceViewController.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/10/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol NavigationFilterInterfaceControllerDelegate: class {
    func partWasSelected(part: MyParts)
}

class NavigationFilterInterfaceViewController: UIViewController, PartFilterInterfaceViewDelegate, CategoryViewControllerDelegate, CustomPartViewDelegate {
    
    private var mainFilterView: MainFilterView { return view as! MainFilterView }
    private var partFilterView: PartFilterInterfaceView? = nil
    private var customPartViewController: CustomPartViewController? = nil
    var buttons = [UIBarButtonItem]()
    
    private var categoryViewController: CategoryViewController = CategoryViewController()
    
    
    private var _partsList: PartsList = PartsList.Instance
    private var _inList: String = ""
    private var _showCategoryPage: Bool = false
    private var _secondLevel: Bool = false
    private var _specificPartType: String? = nil
    
    private var _usersCurrentParts: [MyParts] = []
    public var usersCurrentParts: [MyParts] { get { return _usersCurrentParts } set { _usersCurrentParts = newValue } }
    
    
    init?(partType: String) {
        super.init(nibName: nil, bundle: nil)
        
        //categoryViewController.usersCurrentParts = _usersCurrentParts
        
        _showCategoryPage = false
        partFilterView = PartFilterInterfaceView()
        
        _inList = partType
        switch partType {
        case "CPU":
            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "Processor"))
            break
        case "Motherboard":
            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "Motherboard"))
            break
        case "RAM":
            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "RAM"))
            break
            
        default:
            // don't do anything
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = MainFilterView(frame: UIScreen.main.bounds, nextView: partFilterView!)
        self.edgesForExtendedLayout = [] // don't remember what this does but I think it's needed
        
        partFilterView?.delegate = self
        
        categoryViewController.delegate = self
        customPartViewController?.delegate = self
    }
    
    override func viewDidLoad() {
        partFilterView?.backgroundColor = UIColor.white
        
        let viewAll = UIBarButtonItem(title: "View All", style: .plain, target: self, action: #selector(viewAllClicked))
        buttons.append(viewAll)
        
        let createPart = UIBarButtonItem(title: "Add Part", style: .plain, target: self, action: #selector(addPartClicked))
        buttons.append(createPart)
        
        self.navigationItem.setRightBarButtonItems(buttons, animated: true)
    }
    
    func addPartClicked()
    {
        customPartViewController = CustomPartViewController(partAsString: _inList)
        customPartViewController?.delegate = self
        navigationController?.pushViewController(customPartViewController!, animated: true)
    }
    
    func viewAllClicked()
    {
        categoryViewController.usersCurrentParts = _usersCurrentParts
        switch _inList {
        case "CPU":
            if (_secondLevel) {
                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Processor", category: _specificPartType!)
            }
            else {
                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Processor")
            }
            break
        case "Motherboard":
            if (_secondLevel) {
                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Motherboard", category: _specificPartType!)
            }
            else {
                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Motherboard")
            }
        default:
            break
        }
        
        navigationController?.pushViewController(categoryViewController, animated: true)
        
    }
    
    func buttonTouched(specificPartType: String) {
        _specificPartType = specificPartType
        switch _inList {
        case "CPU":
            if (_showCategoryPage) {
                categoryViewController.usersCurrentParts = _usersCurrentParts
                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Processor", family: specificPartType)
                navigationController?.pushViewController(categoryViewController, animated: true)
            }
            else {
                _secondLevel = true
                partFilterView = PartFilterInterfaceView()
                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "Processor", manufacturer: specificPartType))
                loadView()
            }
            _showCategoryPage = true
            break
        case "Motherboard":
            if (_showCategoryPage) {
                categoryViewController.usersCurrentParts = _usersCurrentParts
                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Motherboard", family: specificPartType)
                navigationController?.pushViewController(categoryViewController, animated: true)
            }
            else {
                _secondLevel = true
                partFilterView = PartFilterInterfaceView()
                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "Motherboard", manufacturer: specificPartType))
                loadView()
            }
            _showCategoryPage = true
            break
        default:
            // don't do anything
            break
        }
        
    }
    
    
    func partWasSelected(part: MyParts) {
        delegate?.partWasSelected(part: part)
    }
    
    
    weak var delegate: NavigationFilterInterfaceControllerDelegate? = nil
}
