//
//  CategoryViewController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/19/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var categoryView: UICollectionView { return view as! UICollectionView }
    //private var _partsNames: [String]? = nil
    private var _parts: [MyParts] = []
    
    //public var parts: [String] { get { return _partsNames!} set { _partsNames = newValue } }
    public var partsList: [MyParts] { get { return _parts} set { _parts = newValue } }
    
    override func loadView() {
        super.loadView()
        
        self.edgesForExtendedLayout = []
        
        let categoryLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        categoryLayout.itemSize = CGSize(width: view.bounds.width / 2 - 20, height: view.bounds.height / 4 - 10)
        categoryLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        view = UICollectionView(frame: CGRect.zero, collectionViewLayout: categoryLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate
        
        categoryView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        categoryView.backgroundColor = UIColor.white
        
        categoryView.dataSource = self
        categoryView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoryView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _parts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)
        
        cell.backgroundColor = UIColor.white
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2.5
        cell.layer.cornerRadius = 10.0
        
        let cellView: CategoryCellView = CategoryCellView()
        cellView.frame = cell.bounds
        
        
        let part = _parts[indexPath.item]
        
        cellView.modelLabel = part._model
        cellView.priceLabel = "$" + part._price
        
        cell.contentView.addSubview(cellView)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let part = _parts[indexPath.item]
        
        let partViewController: SpecificPartPageController = SpecificPartPageController(part: part)
        
        navigationController?.pushViewController(partViewController, animated: true)
        print("Create a view with this specific part")
    }
}
