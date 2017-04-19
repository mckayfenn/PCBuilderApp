//
//  NavigationFilterInterfaceViewController.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/10/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class NavigationFilterInterfaceViewController: UIViewController, PartFilterInterfaceViewDelegate {
    
    private var mainFilterView: MainFilterView { return view as! MainFilterView }
    private var partFilterView: PartFilterInterfaceView? = nil
    
    
    private var _partsList: PartsList = PartsList.Instance
    private var _inList: String = ""
    private var _showListOfSpecificParts: Bool = false
    
    
    
    init?(partType: String) {
        super.init(nibName: nil, bundle: nil)
        partFilterView = PartFilterInterfaceView()
        
        switch partType {
        case "CPU":
            //listOfCPUs = _partsList.getPartsByFamily(string: "Processor")
            //self.partFilterView?.setButtonAttributes(partType: listOfCPUs)
            
            _inList = partType
            self.partFilterView?.setButtonAttributes(partType: _partsList.getListOfPartsByManufacturer(partType: "Processor"))
            break
        case "Motherboard":
            //listOfCPUs = _partsList.getPartsByFamily(string: "Motherboard")
            _inList = partType
            var mobos: [String] = _partsList.getPartsByName(string: "Motherboard")
            self.partFilterView?.setButtonAttributes(partType: mobos)
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
    }
    
    override func viewDidLoad() {
        partFilterView?.backgroundColor = UIColor.white
        
    }
    
    func buttonTouched(specificPartType: String) {
        print("Button was touched in part filter interface: " + "\(specificPartType)")
        //        for processor in Processors!{
        //            //print("Changed to: " + "\(String(describing: type(of: processor)))")
        //            if(specificPartType == processor.key)
        //            {
        //                //remove white space in given string so it matches with name of array
        //                print("Changed to: " + "\(processor.key)")
        //                partFilterView = PartFilterInterfaceView()
        //                self.partFilterView?.setButtonAttributes(partType: processor.value)
        //                loadView()
        //            }
        //        }
        
        
        
        switch _inList {
        case "CPU":
            partFilterView = PartFilterInterfaceView()
            self.partFilterView?.setButtonAttributes(partType: _partsList.getFamilyPartsOfManufacturer(type: "Processor", manufacturer: specificPartType))
            loadView()
            break
        default:
            // don't do anything
            break
        }
    }
    
}
