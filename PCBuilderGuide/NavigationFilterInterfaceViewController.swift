//
//  NavigationFilterInterfaceViewController.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/10/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class NavigationFilterInterfaceViewController: UIViewController, NavigationFilterInterfaceViewDelegate {
    
    private var navigationFilterView: NavigationFilterInterfaceView { return view as! NavigationFilterInterfaceView }
    
    private var CPU: [String] = ["Ryzen 7", "Ryzen 5", "Core i7", "Core i5"]
    //private var buildInterfaceView: BuildInterfaceView { return view as! BuildInterfaceView }
    
    init?(partType: String) {
        super.init(nibName: nil, bundle: nil)
        if(partType == "CPU")
        {
            self.navigationFilterView.requestedSpecificPartType = CPU
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = NavigationFilterInterfaceView()
        self.edgesForExtendedLayout = [] // don't remember what this does
        
        navigationFilterView.delegate = self
    }
    
    override func viewDidLoad() {
        navigationFilterView.backgroundColor = UIColor.white
        
    }
    
    func buttonTouched(specificPartType: String) {
        print("Button was touched: " + "\(specificPartType)")
        //requestedSpecificPartType = specificPartType
    }

}
