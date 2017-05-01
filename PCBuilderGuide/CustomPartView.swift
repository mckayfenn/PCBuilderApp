//
//  CustomPartView.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/23/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class CustomPartView: UIView, UITextFieldDelegate
{
    
    private var scrollView: UIScrollView? = nil
    private var stackView: UIStackView? = nil
    
    private var partStackView: UIStackView? = nil
    private var partTypeField: UITextField? = nil
    private var partTypeLabel: UILabel? = nil
    
    private var fields: [String] = ["Manufacturer: ", "Model: ", "Price: ", "Brand: ", "Specs: ", "Ram Type: ", "Speed: ", "Socket: ", "Chipset: ", "Link: ", "Image URL: ", "Family: "]
    
    private var _partCreating: String? = nil
      
    
    
    init(frame: CGRect, partCreating: String) {
        super.init(frame: frame)
        
        _partCreating = partCreating
        
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        scrollView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        scrollView?.contentSize = CGSize(width: frame.width, height: frame.height * 2)
        addSubview(scrollView!)

        stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 2))
        stackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        stackView?.axis = UILayoutConstraintAxis.vertical
        stackView?.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView?.isLayoutMarginsRelativeArrangement = true
        stackView?.distribution = UIStackViewDistribution.fillEqually
        stackView?.spacing = 45.0
        stackView?.backgroundColor = UIColor.white
        setGradientColors(viewPassed: stackView!, colors: [UIColor.white, UIColor.lightGray], gradientLocations: [0.0,0.5,1.0])
        scrollView?.addSubview(stackView!)

        
        for i: Int in 0..<fields.count {
            
            // create this first so it can be edited it the switch
            let partTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
            
            // continue if this field is not applicable to the part being created
            switch i {
            case 3: // brand
                if (partCreating == "GPU"){
                    // fall through
                    partTypeField.placeholder = "e.g. MSI / EVGA"
                }
                else {
                    continue
                }
                
            case 4: // specs
                if (partCreating == "CPU" || partCreating == "RAM" || partCreating == "Cooler" || partCreating == "Storage" || partCreating == "Optical Drive") {
                    // fall through
                    partTypeField.placeholder = "Enter your text here"
                }
                else {
                    continue
                }
                
            case 5: // ram type
                if (partCreating == "CPU" || partCreating == "RAM" || partCreating == "Motherboard") {
                    // fall through
                    partTypeField.placeholder = "e.g. DDR4 / DDR3"
                }
                else {
                    continue
                }
                
            case 6: // speed
                if (partCreating == "RAM" || partCreating == "Storage" || partCreating == "Optical Drive") {
                    // fall through
                    partTypeField.placeholder = "Enter your text here"
                }
                else {
                    continue
                }
                
            case 7: // socket
                if (partCreating == "CPU" || partCreating == "Motherboard" || partCreating == "RAM") {
                    // fall through
                    partTypeField.placeholder = "Enter your text here"
                }
                else {
                    continue
                }
                
            case 8: // chipset
                if (partCreating == "Motherboard") {
                    // fall through
                    partTypeField.placeholder = "Enter your text here"
                }
                else {
                    continue
                }
                
            case 11: // family (core i7)
                if (partCreating == "CPU") {
                    // fall through
                    partTypeField.placeholder = "e.g. Core i5 / Ryzen 3"
                }
                else {
                    continue
                }
                
            default:
                partTypeField.placeholder = "Enter your text here"
                break
            }
            let partStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
            partStackView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            partStackView.axis = UILayoutConstraintAxis.horizontal
            partStackView.distribution = UIStackViewDistribution.fill
            partStackView.spacing = 5.0
            partStackView.backgroundColor = UIColor.white
            
            let partLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
            partLabel.text = fields[i]
            partLabel.font = UIFont(name: "Helvetica", size: 15)
            partStackView.addArrangedSubview(partLabel)
            
            
            partTypeField.allowsEditingTextAttributes = true
            partTypeField.font = UIFont.systemFont(ofSize: 15)
            partTypeField.keyboardType = UIKeyboardType.default
            partTypeField.returnKeyType = UIReturnKeyType.done
            partTypeField.clearButtonMode = UITextFieldViewMode.whileEditing
            partTypeField.borderStyle = UITextBorderStyle.roundedRect
            partTypeField.autocorrectionType = UITextAutocorrectionType.no
            partTypeField.backgroundColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 0.7)
            partTypeField.tag = i
            partTypeField.delegate = self
            partStackView.addArrangedSubview(partTypeField)
            stackView?.addArrangedSubview(partStackView)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.gray
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldShouldReturn(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        textField.backgroundColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 0.7)
        switch textField.tag {
        case 0:
            _manufacturer = textField.text!
        case 1:
            _model = textField.text!
        case 2:
            _price = textField.text!
        case 3:
            _brand = textField.text!
        case 4:
            _specs = textField.text!
        case 5:
            _ram = textField.text!
        case 6:
            _speed = textField.text!
        case 7:
            _socket = textField.text!
        case 8:
            _chipset = textField.text!
        case 9:
            _link = textField.text!
        case 10:
            _image = textField.text!
        case 11:
            _family = textField.text!
        default:
            print("Unable to change field to variable")
        }

        return true
    }
    
    
    func getAllFieldValuesDict() -> NSDictionary {
        var result: [String : String] = [:]
        
        //["Manufacturer: ", "Model: ", "Price: ", "Brand: ", "Specs: ", "Ram Type: ", "Speed: ", "Socket: ", "Chipset: ", "Link: ", "Image URL: "]
        
        result["Manufacturer"] = (_manufacturer != nil) ? _manufacturer : ""
        result["Model"] = (_model != nil) ? _model : ""
        result["Price"] = (_price != nil) ? _price : "0"
        result["Link"] = (_link != nil) ? _link : ""
        result["Image"] = (_image != nil) ? _image : ""
        
        if (_partCreating == "CPU" || _partCreating == "Motherboard" || _partCreating == "RAM") {
            result["RAM"] = _ram != nil ? _ram : ""
        }
        if (_partCreating == "CPU" || _partCreating == "Motherboard") {
            result["Socket"] = _socket != nil ? _socket : ""
        }
        if (_partCreating == "Motherboard") {
            result["Chipset"] = _chipset != nil ? _chipset : ""
        }
        if (_partCreating == "RAM" || _partCreating == "Storage" || _partCreating == "Optical Drive") {
            result["Speed"] = _speed != nil ? _speed : ""
        }
        if (_partCreating == "GPU") {
            result["Brand"] = _brand != nil ? _brand : ""
        }
        if (_partCreating == "CPU" || _partCreating == "RAM" || _partCreating == "Cooler" || _partCreating == "Storage" || _partCreating == "Optical Drive") {
            result["Specs"] = _specs != nil ? _specs : ""
        }
        if (_partCreating == "CPU") {
            result["Family"] = _family != nil ? _family : ""
        }
        
        result["IsCustom"] = "true"
        
        return result as NSDictionary
    }
    func setGradientColors(viewPassed: UIView,colors: [UIColor], gradientLocations: [NSNumber])
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = viewPassed.frame
        gradient.colors = colors.map {$0.cgColor}
        gradient.locations = gradientLocations
        viewPassed.layer.insertSublayer(gradient, at: 0)
        
    }
    
    var _ram: String? = nil
    var _link: String?  = nil
    var _specs: String?  = nil
    var _image: String?  = nil
    var _price: String?  = nil
    var _model: String?  = nil
    var _brand: String?  = nil
    var _speed: String?  = nil
    var _family: String? = nil
    var _socket: String?  = nil
    var _chipset: String?  = nil
    var _manufacturer: String?  = nil
    
    
}
