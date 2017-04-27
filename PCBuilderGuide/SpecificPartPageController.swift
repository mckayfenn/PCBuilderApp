//
//  SpecificPartPageController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/21/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol SpecificPartPageControllerDelegate: class {
    func partWasSelected(part: MyParts)
}

class SpecificPartPageController: UIViewController, SpecificPartPageDelegate {
    
    private var _part: MyParts? = nil
    public var part: MyParts { get { return _part! } set { _part = newValue } }
    
    private var _isCompatible: Bool = true
    public var isCompatible: Bool { get { return _isCompatible } set { _isCompatible = newValue } }
    
    private var specificPartView: SpecificPartPageView { return view as! SpecificPartPageView }
    
    
    private var _usersParts: [MyParts]? = nil
    public var usersParts: [MyParts] { get { return _usersParts! } set { _usersParts = newValue } }
    
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
        
        specificPartView.delegate = self
    }
    
    
    func selectPartClicked(part: MyParts) {
        
        var customPart: Bool = false
        for thisPart in _usersParts! {
            switch part {
            case is CPU:
                if (thisPart._isCustom!) {
                    customPart = true
                    break
                }
                break
            case is Motherboard:
                if (thisPart._isCustom!) {
                    customPart = true
                    break
                }
                break
            case is RAM:
                if (thisPart._isCustom!) {
                    customPart = true
                    break
                }
                break
            default:
                break
            }
            
        }
        
        // if it's compatible then delegate up
        if (_isCompatible && !customPart) {
            delegate?.partWasSelected(part: part)
        }
        else if (customPart) {
            let alertController = UIAlertController(title: "Compatibility", message: "We cannot guarantee the compatibility of this part. \n Are you sure you want to select it?", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                self.delegate?.partWasSelected(part: part)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) in }
            
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
        // if its not, then tell the user
        else {
            let alertController = UIAlertController(title: "Not Compatible", message: "This part is not compatible with the rest of your build. \n Please select a different part.", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in }
            
            alertController.addAction(confirmAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    weak var delegate: SpecificPartPageControllerDelegate? = nil
}
