//
//  CategoryViewController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/19/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol CategoryViewControllerDelegate: class {
    func partWasSelected(part: MyParts)
}

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SpecificPartPageControllerDelegate {
    
    private var allPartsList: PartsList = PartsList.Instance
    private var _sortOrder: Bool = true // true will be low, false will be high
    
    private var categoryView: UICollectionView { return view as! UICollectionView }
    private var _partsToShow: [MyParts] = []
    public var partsList: [MyParts] { get { return _partsToShow} set { _partsToShow = newValue } }
    
    private var _usersCurrentParts: [MyParts] = []
    public var usersCurrentParts: [MyParts] { get { return _usersCurrentParts } set { _usersCurrentParts = newValue } }
    
    private var partViewController: SpecificPartPageController? = nil
    
    
    override func loadView() {
        super.loadView()
        
        self.edgesForExtendedLayout = []
        
        let categoryLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        categoryLayout.itemSize = CGSize(width: view.bounds.width / 2 - 20, height: view.bounds.height / 3)
        categoryLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        view = UICollectionView(frame: CGRect.zero, collectionViewLayout: categoryLayout)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        categoryView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        
        categoryView.dataSource = self
        categoryView.delegate = self
        
        let sort = UIBarButtonItem(title: "Sort Price", style: .plain, target: self, action: #selector(sortPriceSelected))
        
        navigationItem.setRightBarButton(sort, animated: true)
        
        self.view.backgroundColor = UIColor.darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoryView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _partsToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let part = _partsToShow[indexPath.item] // part to be displayed in the cellView
        
        let compatible = allPartsList.isPartCompatibleTo(currentParts: _usersCurrentParts, thisPart: part)
        
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)
        let cellView: CategoryCellView = CategoryCellView()
        
        if (compatible) {
            cellView.compatible = true
        }
        else {
            cellView.compatible = false
        }
        
        cell.layer.borderColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 1.0).cgColor
        cell.backgroundColor = UIColor.white
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.borderWidth = 4.5
        cell.layer.cornerRadius = 7.0
        
        
        cellView.frame = cell.bounds
        
        
        
        cellView.modelLabel = part._model!
        cellView.priceLabel = "$" + part._price!
        cellView.imageURL = part._image!
        
        
        cell.contentView.addSubview(cellView)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let part = _partsToShow[indexPath.item]
        let compatible = allPartsList.isPartCompatibleTo(currentParts: _usersCurrentParts, thisPart: part)
        
        partViewController = SpecificPartPageController(part: part)
        partViewController?.usersParts = _usersCurrentParts
        
        if (!compatible) {
            partViewController?.isCompatible = false
        }
        
        partViewController?.delegate = self
        
        navigationController?.pushViewController(partViewController!, animated: true)
    }
    
    
    func partWasSelected(part: MyParts) {
        delegate?.partWasSelected(part: part)
    }
    
    func sortPriceSelected() {
        if (!_sortOrder) { // true is low
            _partsToShow = allPartsList.sortByPrice(listOfParts: _partsToShow, order: "low")
        }
        else { // false is high
            _partsToShow = allPartsList.sortByPrice(listOfParts: _partsToShow, order: "high")
        }
        _sortOrder = !_sortOrder
        categoryView.reloadData()
    }
    
    weak var delegate: CategoryViewControllerDelegate? = nil
}
