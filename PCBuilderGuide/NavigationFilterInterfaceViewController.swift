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
    private var _firstLevel: String? = nil
    private var _specificPartType: String? = nil
    
    private var _usersCurrentParts: [MyParts] = []
    public var usersCurrentParts: [MyParts] { get { return _usersCurrentParts } set { _usersCurrentParts = newValue } }
    
    
    init?(partType: String) {
        super.init(nibName: nil, bundle: nil)
        
        //categoryViewController.usersCurrentParts = _usersCurrentParts
        
        _showCategoryPage = false
        partFilterView = PartFilterInterfaceView()
        
        _inList = partType
//        switch partType {
//        case "CPU":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "Processor"))
//            break
//        case "Motherboard":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "Motherboard"))
//            break
//        case "RAM":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "RAM"))
//            break
//        case "Graphics Card":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "GPU"))
//            break
//        case "Case":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "Case"))
//            break
//        case "Power Supply":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "PSU"))
//            break
//        case "Cooler":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "Cooler"))
//            break
//        case "Storage":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "Storage"))
//            break
//        case "Optical Drive":
//            self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: "Optical Drive"))
//            break
//        default:
//            // don't do anything
//            break
//        }
        
        self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: _inList))
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
        //partFilterView?.backgroundColor = UIColor.yellow
        
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
//        switch _inList {
//        case "CPU":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Processor", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Processor")
//            }
//            break
//        case "Motherboard":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Motherboard", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Motherboard")
//            }
//            break
//        case "RAM":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "RAM", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "RAM")
//            }
//            break
//        case "GPU":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "GPU", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "GPU")
//            }
//            break
//        case "Case":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Case", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Case")
//            }
//            break
//        case "PSU":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "PSU", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "PSU")
//            }
//            break
//        case "Cooler":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Cooler", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Cooler")
//            }
//            break
//        case "Storage":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Storage", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Storage")
//            }
//            break
//        case "Optical Drive":
//            if (_secondLevel) {
//                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Optical Drive", firstLevelSelection: _specificPartType!)
//            }
//            else {
//                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Optical Drive")
//            }
//            break
//        default:
//            break
//        }
        
        if (_secondLevel) {
            categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: _inList, firstLevelSelection: _specificPartType!)
        }
        else {
            categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: _inList)
        }
        
        navigationController?.pushViewController(categoryViewController, animated: true)
        
    }
    
    func buttonTouched(specificPartType: String) {
        _specificPartType = specificPartType
//        switch _inList {
//        case "CPU":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Processor", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "Processor", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        case "Motherboard":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Motherboard", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "Motherboard", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        case "RAM":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "RAM", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "RAM", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        case "Graphics Card":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "GPU", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "GPU", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        case "Case":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Case", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "Case", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        case "Power Supply":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "PSU", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "PSU", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        case "Cooler":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Cooler", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "Cooler", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        case "Storage":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Storage", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "Storage", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        case "Optical Drive":
//            if (_showCategoryPage) {
//                categoryViewController.usersCurrentParts = _usersCurrentParts
//                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Optical Drive", secondLevelSelection: specificPartType)
//                navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//            else {
//                _secondLevel = true
//                partFilterView = PartFilterInterfaceView()
//                self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: "Optical Drive", firstLevelSelection: specificPartType))
//                loadView()
//            }
//            _showCategoryPage = true
//            break
//        default:
//            // don't do anything
//            break
//        }
        
        if (!_secondLevel) {
            _firstLevel = specificPartType
        }
        
        if (_showCategoryPage) {
            categoryViewController.usersCurrentParts = _usersCurrentParts
            categoryViewController.partsList = _partsList.getPartsForCategory(type: _inList, firstLevelSelection: _firstLevel!, secondLevelSelection: specificPartType)
            navigationController?.pushViewController(categoryViewController, animated: true)
        }
        else {
            _secondLevel = true
            partFilterView = PartFilterInterfaceView()
            self.partFilterView?.setButtonAttributes(partType: _partsList.getSecondLevelParts(type: _inList, firstLevelSelection: specificPartType))
            loadView()
        }
        _showCategoryPage = true
    }
    
    
    
    func partWasSelected(part: MyParts) {
        delegate?.partWasSelected(part: part)
    }
    
    
    weak var delegate: NavigationFilterInterfaceControllerDelegate? = nil
}
