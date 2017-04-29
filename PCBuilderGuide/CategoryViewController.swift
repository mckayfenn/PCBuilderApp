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
        categoryLayout.itemSize = CGSize(width: view.bounds.width / 2 - 20, height: view.bounds.height / 4 - 10)
        categoryLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        view = UICollectionView(frame: CGRect.zero, collectionViewLayout: categoryLayout)
        
    
        
        //partViewController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate
        
        categoryView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        //categoryView.backgroundColor = UIColor.white
        
        let collectionGradient = CAGradientLayer()
        collectionGradient.frame = self.categoryView.frame
        collectionGradient.colors = [UIColor.gray, UIColor.white]
        collectionGradient.locations = [0.0, 0.5, 1.0]
        categoryView.layer.insertSublayer(collectionGradient, at: 0)
        
        categoryView.dataSource = self
        categoryView.delegate = self
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
            cell.layer.borderColor = UIColor.green.cgColor
        }
        else {
            cell.layer.borderColor = UIColor.red.cgColor
            //cell.isUserInteractionEnabled = false
        }
        
        
        cell.backgroundColor = UIColor.white
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2.5
        cell.layer.cornerRadius = 10.0
        
        
        cellView.frame = cell.bounds
        
        
        
        
        cellView.modelLabel = part._model!
        cellView.priceLabel = "$" + part._price!
        
        
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
        print("Create a view with this specific part")
    }
    
    
    func partWasSelected(part: MyParts) {
        delegate?.partWasSelected(part: part)
    }
    
    weak var delegate: CategoryViewControllerDelegate? = nil
}
