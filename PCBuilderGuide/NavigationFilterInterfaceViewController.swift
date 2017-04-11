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
    
    private var _parts: [AnyObject] = []
    public var parts: [AnyObject] {
        get { return _parts }
        set { _parts = newValue }
    }
    
    private var _partsList: PartsList = PartsList.Instance
    
    
    
    
    // Shouldn't need these any more
    private var listOfCPUs: [String] = ["Ryzen 7", "Ryzen 5", "Core i7", "Core i5"]
    private var Ryzen7: [String] = ["R7 1800x", "R7 1700x", "R7 1700"]
    private var Ryzen5: [String] = ["R5 1600", "R5 1500x", "R5 1500"]
    private var Corei7: [String] = ["i7 6900k", "i7 6800k", "i7 7700k"]
    private var Corei5: [String] = ["i5 7600k", "i5 7500", "i5 6600k"]
    
    //private var Processors: [Any] = [Ryzen7, Ryzen5, Corei5, Corei7]
    var Processors: [String: [String]]? = nil
    //private var buildInterfaceView: BuildInterfaceView { return view as! BuildInterfaceView }
    
    init?(partType: String) {
        super.init(nibName: nil, bundle: nil)
        Processors = ["Ryzen 7": Ryzen7, "Ryzen 5": Ryzen5, "Core i5": Corei5, "Core i7": Corei7]
        if(partType == "CPU")
        {
            
        }
        
        switch partType {
        case "CPU":
            //listOfCPUs = _partsList.getPartsByFamily(string: "Processor")
            self.navigationFilterView.requestedSpecificPartType = listOfCPUs
            self.navigationFilterView.createButtons()
            break
        case "Mobo":
            listOfCPUs = _partsList.getPartsByFamily(string: "Motherboard")
            self.navigationFilterView.requestedSpecificPartType = listOfCPUs
            self.navigationFilterView.createButtons()
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
        view = NavigationFilterInterfaceView()
        self.edgesForExtendedLayout = [] // don't remember what this does but I think it's needed
        
        navigationFilterView.delegate = self
    }
    
    override func viewDidLoad() {
        navigationFilterView.backgroundColor = UIColor.white
        
    }
    
    func buttonTouched(specificPartType: String) {
        print("Button was touched: " + "\(specificPartType)")
        for processor in Processors!{
            //print("Changed to: " + "\(String(describing: type(of: processor)))")
            if(specificPartType == processor.key)
            {
                //remove white space in given string so it matches with name of array
                print("Changed to: " + "\(processor.key)")
                self.navigationFilterView.requestedSpecificPartType = processor.value
                self.navigationFilterView.createButtons()
            }
        }

    }

}
