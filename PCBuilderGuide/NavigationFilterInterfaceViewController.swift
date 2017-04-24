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

class NavigationFilterInterfaceViewController: UIViewController, PartFilterInterfaceViewDelegate, CategoryViewControllerDelegate {
    
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
    
    
    init?(partType: String) {
        super.init(nibName: nil, bundle: nil)
        
        _showCategoryPage = false
        partFilterView = PartFilterInterfaceView()
        
        switch partType {
        case "CPU":
            _inList = partType
            self.partFilterView?.setButtonAttributes(partType: _partsList.getListOfPartsByManufacturer(partType: "Processor"))
            break
        case "Motherboard":
            _inList = partType
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
        customPartViewController = CustomPartViewController()
        navigationController?.pushViewController(customPartViewController!, animated: true)
    }
    
    func viewAllClicked()
    {
        switch _inList {
        case "CPU":
            if (_secondLevel) {
                categoryViewController.partsList = _partsList.getAllPartsSecondLevel(type: "Processor", category: _specificPartType!)
            }
            else {
                categoryViewController.partsList = _partsList.getAllPartsFirstLevel(type: "Processor")
            }
            break
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
                categoryViewController.partsList = _partsList.getPartsForCategory(type: "Processor", family: specificPartType)
                navigationController?.pushViewController(categoryViewController, animated: true)
            }
            else {
                _secondLevel = true
                partFilterView = PartFilterInterfaceView()
                self.partFilterView?.setButtonAttributes(partType: _partsList.getFamilyPartsOfManufacturer(type: "Processor", manufacturer: specificPartType))
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
