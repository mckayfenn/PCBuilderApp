//
//  CustomPartViewController.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/23/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol CustomPartViewDelegate: class{
    func partWasSelected(part: MyParts)
}

class CustomPartViewController: UIViewController {
    
    private var customPartView: CustomPartView { return view as! CustomPartView}
    private var _partAsString: String? = nil
    
    init?(partAsString: String) {
        super.init(nibName: nil, bundle: nil)
        _partAsString = partAsString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CustomPartView(frame: UIScreen.main.bounds, part: _partAsString!)
        self.title = "Add a Part"
        
    }
    override func viewDidLoad() {
        customPartView.backgroundColor = UIColor.white
        let doneWithPart = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithPartClicked))
        self.navigationItem.rightBarButtonItem = doneWithPart
    }
    func doneWithPartClicked()
    {
        //delegate?.partWasSelected(part: _part)
    }
    weak var delegate: CustomPartViewDelegate? = nil
}
