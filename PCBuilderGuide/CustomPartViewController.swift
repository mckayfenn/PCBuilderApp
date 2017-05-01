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
        view = CustomPartView(frame: UIScreen.main.bounds, partCreating: _partAsString!)
        
        self.title = "Add a Part"
        
    }
    override func viewDidLoad() {
        customPartView.backgroundColor = UIColor.white
        let doneWithPart = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithPartClicked))
        self.navigationItem.rightBarButtonItem = doneWithPart
    }
    func doneWithPartClicked()
    {
        let dictionary = customPartView.getAllFieldValuesDict()
        let part = createPartWithDict(partAsString: _partAsString!, values: dictionary)
        delegate?.partWasSelected(part: part)
    }

    
    func createPartWithDict(partAsString: String, values: NSDictionary) -> MyParts {
        switch partAsString {
        case "CPU":
            return CPU(dictionary: values)
        case "Motherboard":
            return Motherboard(dictionary: values)
        case "GPU":
            return GPU(dictionary: values)
        case "RAM":
            return RAM(dictionary: values)
        case "CASE":
            return Case(dictionary: values)
        case "Power Supply":
            return PSU(dictionary: values)
        case "Storage":
            return Storage(dictionary: values)
        case "Optical Drive":
            return OpticalDrive(dictionary: values)
        case "Cooler":
            return Cooler(dictionary: values)
        default:
            return CPU(link: "something went wrong", specs: "", price: "", image: "", model: "", socket: "", family: "", generation: "", description: "", manufacturer: "", ram: "", isCustom: true)
            print("Unable to change field to variable")
        }
    }
    weak var delegate: CustomPartViewDelegate? = nil
}
