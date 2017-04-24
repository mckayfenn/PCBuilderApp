//
//  CustomPartViewController.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/23/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class CustomPartViewController: UIViewController {
    
    private var customPartView: CustomPartView { return view as! CustomPartView}
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CustomPartView(frame: UIScreen.main.bounds)
        self.title = "Add a Part"
        
    }
    override func viewDidLoad() {
        customPartView.backgroundColor = UIColor.white
        let doneWithPart = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithPartClicked))
        self.navigationItem.rightBarButtonItem = doneWithPart
    }
    func doneWithPartClicked()
    {
        print("Done with part clicked")
    }
}
