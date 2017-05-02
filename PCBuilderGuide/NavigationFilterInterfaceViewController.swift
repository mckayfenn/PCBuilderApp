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
    
    private var categoryViewController: CategoryViewController? = nil
    
    
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
        
        _showCategoryPage = false
        partFilterView = PartFilterInterfaceView()
        
        _inList = partType

        
        self.partFilterView?.setButtonAttributes(partType: _partsList.getFirstLevelParts(partType: _inList))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = MainFilterView(frame: UIScreen.main.bounds, nextView: partFilterView!)
        self.edgesForExtendedLayout = [] // don't remember what this does but I think it's needed
        
        partFilterView?.delegate = self
        
        customPartViewController?.delegate = self
    }
    
    override func viewDidLoad() {
        
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
        categoryViewController = CategoryViewController()
        categoryViewController?.title = _inList
        categoryViewController?.usersCurrentParts = _usersCurrentParts
        categoryViewController?.delegate = self
        
        if (_secondLevel) {
            categoryViewController?.partsList = _partsList.getAllPartsSecondLevel(type: _inList, firstLevelSelection: _firstLevel!)
        }
        else {
            categoryViewController?.partsList = _partsList.getAllPartsFirstLevel(type: _inList)
        }
        
        navigationController?.pushViewController(categoryViewController!, animated: true)
        
    }
    
    func buttonTouched(specificPartType: String) {

        _specificPartType = specificPartType

        if (!_secondLevel) {
            _firstLevel = specificPartType
        }
        
        if (_showCategoryPage) {
            categoryViewController = CategoryViewController()
            categoryViewController?.title = _inList
            categoryViewController?.delegate = self
            categoryViewController?.usersCurrentParts = _usersCurrentParts
            categoryViewController?.partsList = _partsList.getPartsForCategory(type: _inList, firstLevelSelection: _firstLevel!, secondLevelSelection: specificPartType)
            navigationController?.pushViewController(categoryViewController!, animated: true)
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
