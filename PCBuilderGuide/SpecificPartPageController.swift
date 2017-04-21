//
//  SpecificPartPageController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/21/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class SpecificPartPageController: UIViewController {
    
    private var _part: MyParts? = nil
    public var part: MyParts { get { return _part! } set { _part = newValue } }
    
    private var specificPartView: SpecificPartPageView { return view as! SpecificPartPageView }
    
    init(part: MyParts) {
        super.init(nibName: nil, bundle: nil)
        
        _part = part
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SpecificPartPageView(frame: UIScreen.main.bounds, part: _part!)
        
        self.edgesForExtendedLayout = []
        
        self.title = _part?._model
    }
    
}
