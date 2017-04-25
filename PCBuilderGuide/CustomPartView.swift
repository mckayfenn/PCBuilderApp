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
    
    private var manufacturerStackView: UIStackView? = nil
    private var manufacturerTypeField: UITextField? = nil
    private var manufacturerTypeLabel: UILabel? = nil
    
    private var modelStackView: UIStackView? = nil
    private var modelTypeField: UITextField? = nil
    private var modelTypeLabel: UILabel? = nil
    
    private var specsStackView: UIStackView? = nil
    private var specsTypeField: UITextField? = nil
    private var specsTypeLabel: UILabel? = nil
    
    private var priceStackView: UIStackView? = nil
    private var priceTypeField: UITextField? = nil
    private var priceTypeLabel: UILabel? = nil
    
    private var familyStackView: UIStackView? = nil
    private var familyTypeField: UITextField? = nil
    private var familyTypeLabel: UILabel? = nil
    
    private var socketStackView: UIStackView? = nil
    private var socketTypeField: UITextField? = nil
    private var socketTypeLabel: UILabel? = nil
    
    private var generationStackView: UIStackView? = nil
    private var generationTypeField: UITextField? = nil
    private var generationTypeLabel: UILabel? = nil
    
    private var linkStackView: UIStackView? = nil
    private var linkTypeField: UITextField? = nil
    private var linkTypeLabel: UILabel? = nil
    
    private var imageStackView: UIStackView? = nil
    private var imageTypeField: UITextField? = nil
    private var imageTypeLabel: UILabel? = nil
    
    private var descriptionStackView: UIStackView? = nil
    private var descriptionTypeField: UITextField? = nil
    private var descriptionTypeLabel: UILabel? = nil
    
    
    var _link: String?  = nil
    var _specs: String?  = nil
    var _image: String?  = nil
    var _price: String?  = nil
    var _model: String?  = nil
    var _socket: String?  = nil
    var _family: String?  = nil
    var _generation: String?  = nil
    var _description: String?  = nil
    var _manufacturer: String?  = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
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
        scrollView?.addSubview(stackView!)
        
        
        partStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        partStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        partStackView?.axis = UILayoutConstraintAxis.horizontal
        //partStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //partStackView?.isLayoutMarginsRelativeArrangement = true
        partStackView?.distribution = UIStackViewDistribution.fill
        partStackView?.spacing = 5.0
        partStackView?.backgroundColor = UIColor.white
        
        partTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        partTypeLabel?.text = "Part: "
        partTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //partTypeLabel?.textColor = UIColor.black
        partStackView?.addArrangedSubview(partTypeLabel!)
        
        partTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        partTypeField?.allowsEditingTextAttributes = true
        partTypeField?.placeholder = "Enter your text here"
        partTypeField?.font = UIFont.systemFont(ofSize: 15)
        partTypeField?.keyboardType = UIKeyboardType.default
        partTypeField?.returnKeyType = UIReturnKeyType.done
        partTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        partTypeField?.borderStyle = UITextBorderStyle.roundedRect
        partTypeField?.autocorrectionType = UITextAutocorrectionType.no
        partTypeField?.backgroundColor = UIColor.lightGray
        partTypeField?.clearsOnBeginEditing = true
        partTypeField?.tag = 0
        partTypeField?.delegate = self
        partStackView?.addArrangedSubview(partTypeField!)
        //stackView?.addArrangedSubview(partStackView!)
        
        
        manufacturerStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        manufacturerStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        manufacturerStackView?.axis = UILayoutConstraintAxis.horizontal
        //manufacturerStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //manufacturerStackView?.isLayoutMarginsRelativeArrangement = true
        manufacturerStackView?.distribution = UIStackViewDistribution.fill
        manufacturerStackView?.spacing = 5.0
        manufacturerStackView?.backgroundColor = UIColor.white
        
        manufacturerTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        manufacturerTypeLabel?.text = "Manufacturer: "
        manufacturerTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //manufacturerTypeLabel?.textColor = UIColor.black
        manufacturerStackView?.addArrangedSubview(manufacturerTypeLabel!)
        
        manufacturerTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        manufacturerTypeField?.allowsEditingTextAttributes = true
        manufacturerTypeField?.placeholder = "Enter your text here"
        manufacturerTypeField?.font = UIFont.systemFont(ofSize: 15)
        manufacturerTypeField?.keyboardType = UIKeyboardType.default
        manufacturerTypeField?.returnKeyType = UIReturnKeyType.done
        manufacturerTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        manufacturerTypeField?.borderStyle = UITextBorderStyle.roundedRect
        manufacturerTypeField?.autocorrectionType = UITextAutocorrectionType.no
        manufacturerTypeField?.backgroundColor = UIColor.lightGray
        manufacturerTypeField?.clearsOnBeginEditing = true
        manufacturerTypeField?.tag = 1
        manufacturerTypeField?.delegate = self
        manufacturerStackView?.addArrangedSubview(manufacturerTypeField!)
        stackView?.addArrangedSubview(manufacturerStackView!)
        
        
        modelStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        modelStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        modelStackView?.axis = UILayoutConstraintAxis.horizontal
        //modelStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //modelStackView?.isLayoutMarginsRelativeArrangement = true
        modelStackView?.distribution = UIStackViewDistribution.fill
        modelStackView?.spacing = 5.0
        modelStackView?.backgroundColor = UIColor.white
        
        modelTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        modelTypeLabel?.text = "Model: "
        modelTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //modelTypeLabel?.textColor = UIColor.black
        modelStackView?.addArrangedSubview(modelTypeLabel!)
        
        modelTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        modelTypeField?.allowsEditingTextAttributes = true
        modelTypeField?.placeholder = "Enter your text here"
        modelTypeField?.font = UIFont.systemFont(ofSize: 15)
        modelTypeField?.keyboardType = UIKeyboardType.default
        modelTypeField?.returnKeyType = UIReturnKeyType.done
        modelTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        modelTypeField?.borderStyle = UITextBorderStyle.roundedRect
        modelTypeField?.autocorrectionType = UITextAutocorrectionType.no
        modelTypeField?.backgroundColor = UIColor.lightGray
        modelTypeField?.clearsOnBeginEditing = true
        modelTypeField?.tag = 2
        modelTypeField?.delegate = self
        modelStackView?.addArrangedSubview(modelTypeField!)
        stackView?.addArrangedSubview(modelStackView!)
        
        
        specsStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        specsStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        specsStackView?.axis = UILayoutConstraintAxis.horizontal
        //specsStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //specsStackView?.isLayoutMarginsRelativeArrangement = true
        specsStackView?.distribution = UIStackViewDistribution.fill
        specsStackView?.spacing = 5.0
        specsStackView?.backgroundColor = UIColor.white
        
        specsTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        specsTypeLabel?.text = "Specs: "
        specsTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //partTypeLabel?.textColor = UIColor.black
        specsStackView?.addArrangedSubview(specsTypeLabel!)
        
        specsTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        specsTypeField?.allowsEditingTextAttributes = true
        specsTypeField?.placeholder = "Enter your text here"
        specsTypeField?.font = UIFont.systemFont(ofSize: 15)
        specsTypeField?.keyboardType = UIKeyboardType.default
        specsTypeField?.returnKeyType = UIReturnKeyType.done
        specsTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        specsTypeField?.borderStyle = UITextBorderStyle.roundedRect
        specsTypeField?.autocorrectionType = UITextAutocorrectionType.no
        specsTypeField?.backgroundColor = UIColor.lightGray
        specsTypeField?.clearsOnBeginEditing = true
        specsTypeField?.tag = 3
        specsTypeField?.delegate = self
        specsStackView?.addArrangedSubview(specsTypeField!)
        stackView?.addArrangedSubview(specsStackView!)
        
        
        priceStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        priceStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        priceStackView?.axis = UILayoutConstraintAxis.horizontal
        //priceStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //priceStackView?.isLayoutMarginsRelativeArrangement = true
        priceStackView?.distribution = UIStackViewDistribution.fill
        priceStackView?.spacing = 5.0
        priceStackView?.backgroundColor = UIColor.white
        
        priceTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        priceTypeLabel?.text = "Price: "
        priceTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //partTypeLabel?.textColor = UIColor.black
        priceStackView?.addArrangedSubview(priceTypeLabel!)
        
        priceTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        priceTypeField?.allowsEditingTextAttributes = true
        priceTypeField?.placeholder = "Enter your text here"
        priceTypeField?.font = UIFont.systemFont(ofSize: 15)
        priceTypeField?.keyboardType = UIKeyboardType.default
        priceTypeField?.returnKeyType = UIReturnKeyType.done
        priceTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        priceTypeField?.borderStyle = UITextBorderStyle.roundedRect
        priceTypeField?.autocorrectionType = UITextAutocorrectionType.no
        priceTypeField?.backgroundColor = UIColor.lightGray
        priceTypeField?.clearsOnBeginEditing = true
        priceTypeField?.tag = 4
        priceTypeField?.delegate = self
        priceStackView?.addArrangedSubview(priceTypeField!)
        stackView?.addArrangedSubview(priceStackView!)
        
        
        familyStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        familyStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        familyStackView?.axis = UILayoutConstraintAxis.horizontal
        //familyStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //familyStackView?.isLayoutMarginsRelativeArrangement = true
        familyStackView?.distribution = UIStackViewDistribution.fill
        familyStackView?.spacing = 5.0
        familyStackView?.backgroundColor = UIColor.white
        
        familyTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        familyTypeLabel?.text = "Family: "
        familyTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //partTypeLabel?.textColor = UIColor.black
        familyStackView?.addArrangedSubview(familyTypeLabel!)
        
        familyTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        familyTypeField?.allowsEditingTextAttributes = true
        familyTypeField?.placeholder = "Enter your text here"
        familyTypeField?.font = UIFont.systemFont(ofSize: 15)
        familyTypeField?.keyboardType = UIKeyboardType.default
        familyTypeField?.returnKeyType = UIReturnKeyType.done
        familyTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        familyTypeField?.borderStyle = UITextBorderStyle.roundedRect
        familyTypeField?.autocorrectionType = UITextAutocorrectionType.no
        familyTypeField?.backgroundColor = UIColor.lightGray
        familyTypeField?.clearsOnBeginEditing = true
        familyTypeField?.tag = 5
        familyTypeField?.delegate = self
        familyStackView?.addArrangedSubview(familyTypeField!)
        stackView?.addArrangedSubview(familyStackView!)
        
        
        socketStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        socketStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        socketStackView?.axis = UILayoutConstraintAxis.horizontal
        //socketStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //socketStackView?.isLayoutMarginsRelativeArrangement = true
        socketStackView?.distribution = UIStackViewDistribution.fill
        socketStackView?.spacing = 5.0
        socketStackView?.backgroundColor = UIColor.white
        
        socketTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        socketTypeLabel?.text = "Socket: "
        socketTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //socketTypeLabel?.textColor = UIColor.black
        socketStackView?.addArrangedSubview(socketTypeLabel!)
        
        socketTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        socketTypeField?.allowsEditingTextAttributes = true
        socketTypeField?.placeholder = "Enter your text here"
        socketTypeField?.font = UIFont.systemFont(ofSize: 15)
        socketTypeField?.keyboardType = UIKeyboardType.default
        socketTypeField?.returnKeyType = UIReturnKeyType.done
        socketTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        socketTypeField?.borderStyle = UITextBorderStyle.roundedRect
        socketTypeField?.autocorrectionType = UITextAutocorrectionType.no
        socketTypeField?.backgroundColor = UIColor.lightGray
        socketTypeField?.clearsOnBeginEditing = true
        socketTypeField?.tag = 6
        socketTypeField?.delegate = self
        socketStackView?.addArrangedSubview(socketTypeField!)
        stackView?.addArrangedSubview(socketStackView!)
        
        
        generationStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        generationStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        generationStackView?.axis = UILayoutConstraintAxis.horizontal
        //generationStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //generationStackView?.isLayoutMarginsRelativeArrangement = true
        generationStackView?.distribution = UIStackViewDistribution.fill
        generationStackView?.spacing = 5.0
        generationStackView?.backgroundColor = UIColor.white
        
        generationTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        generationTypeLabel?.text = "Generation: "
        generationTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //partTypeLabel?.textColor = UIColor.black
        generationStackView?.addArrangedSubview(generationTypeLabel!)
        
        generationTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        generationTypeField?.allowsEditingTextAttributes = true
        generationTypeField?.placeholder = "Enter your text here"
        generationTypeField?.font = UIFont.systemFont(ofSize: 15)
        generationTypeField?.keyboardType = UIKeyboardType.default
        generationTypeField?.returnKeyType = UIReturnKeyType.done
        generationTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        generationTypeField?.borderStyle = UITextBorderStyle.roundedRect
        generationTypeField?.autocorrectionType = UITextAutocorrectionType.no
        generationTypeField?.backgroundColor = UIColor.lightGray
        generationTypeField?.clearsOnBeginEditing = true
        generationTypeField?.tag = 7
        generationTypeField?.delegate = self
        generationStackView?.addArrangedSubview(generationTypeField!)
        stackView?.addArrangedSubview(generationStackView!)
        
        
        linkStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        linkStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        linkStackView?.axis = UILayoutConstraintAxis.horizontal
        //linkStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //linkStackView?.isLayoutMarginsRelativeArrangement = true
        linkStackView?.distribution = UIStackViewDistribution.fill
        linkStackView?.spacing = 5.0
        linkStackView?.backgroundColor = UIColor.white
        
        linkTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        linkTypeLabel?.text = "Link: "
        linkTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //linkTypeLabel?.textColor = UIColor.black
        linkStackView?.addArrangedSubview(linkTypeLabel!)
        
        linkTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        linkTypeField?.allowsEditingTextAttributes = true
        linkTypeField?.placeholder = "Enter your text here"
        linkTypeField?.font = UIFont.systemFont(ofSize: 15)
        linkTypeField?.keyboardType = UIKeyboardType.default
        linkTypeField?.returnKeyType = UIReturnKeyType.done
        linkTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        linkTypeField?.borderStyle = UITextBorderStyle.roundedRect
        linkTypeField?.autocorrectionType = UITextAutocorrectionType.no
        linkTypeField?.backgroundColor = UIColor.lightGray
        linkTypeField?.clearsOnBeginEditing = true
        linkTypeField?.tag = 8
        linkTypeField?.delegate = self
        linkStackView?.addArrangedSubview(linkTypeField!)
        stackView?.addArrangedSubview(linkStackView!)
        
        
        imageStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        imageStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        imageStackView?.axis = UILayoutConstraintAxis.horizontal
        //imageStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //imageStackView?.isLayoutMarginsRelativeArrangement = true
        imageStackView?.distribution = UIStackViewDistribution.fill
        imageStackView?.spacing = 5.0
        imageStackView?.backgroundColor = UIColor.white
        
        imageTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        imageTypeLabel?.text = "Image URL: "
        imageTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //imageTypeLabel?.textColor = UIColor.black
        imageStackView?.addArrangedSubview(imageTypeLabel!)
        
        imageTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        imageTypeField?.allowsEditingTextAttributes = true
        imageTypeField?.placeholder = "Enter your text here"
        imageTypeField?.font = UIFont.systemFont(ofSize: 15)
        imageTypeField?.keyboardType = UIKeyboardType.default
        imageTypeField?.returnKeyType = UIReturnKeyType.done
        imageTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        imageTypeField?.borderStyle = UITextBorderStyle.roundedRect
        imageTypeField?.autocorrectionType = UITextAutocorrectionType.no
        imageTypeField?.backgroundColor = UIColor.lightGray
        imageTypeField?.clearsOnBeginEditing = true
        imageTypeField?.tag = 9
        imageTypeField?.delegate = self
        imageStackView?.addArrangedSubview(imageTypeField!)
        stackView?.addArrangedSubview(imageStackView!)
        
        
        descriptionStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        descriptionStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        descriptionStackView?.axis = UILayoutConstraintAxis.horizontal
        //descriptionStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        //descriptionStackView?.isLayoutMarginsRelativeArrangement = true
        descriptionStackView?.distribution = UIStackViewDistribution.fill
        descriptionStackView?.spacing = 5.0
        descriptionStackView?.backgroundColor = UIColor.white
        
        descriptionTypeLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 30))
        descriptionTypeLabel?.text = "Image URL: "
        descriptionTypeLabel?.font = UIFont(name: "Helvetica", size: 15)
        //imageTypeLabel?.textColor = UIColor.black
        descriptionStackView?.addArrangedSubview(descriptionTypeLabel!)
        
        descriptionTypeField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: frame.width))
        descriptionTypeField?.allowsEditingTextAttributes = true
        descriptionTypeField?.placeholder = "Enter your text here"
        descriptionTypeField?.font = UIFont.systemFont(ofSize: 15)
        descriptionTypeField?.keyboardType = UIKeyboardType.default
        descriptionTypeField?.returnKeyType = UIReturnKeyType.done
        descriptionTypeField?.clearButtonMode = UITextFieldViewMode.whileEditing
        descriptionTypeField?.borderStyle = UITextBorderStyle.roundedRect
        descriptionTypeField?.autocorrectionType = UITextAutocorrectionType.no
        descriptionTypeField?.backgroundColor = UIColor.lightGray
        descriptionTypeField?.clearsOnBeginEditing = true
        descriptionTypeField?.tag = 10
        descriptionTypeField?.delegate = self
        descriptionStackView?.addArrangedSubview(descriptionTypeField!)
        stackView?.addArrangedSubview(descriptionStackView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.gray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        textField.backgroundColor = UIColor.lightGray
        switch textField.tag {
        case 1:
            manufacturer = textField.text!
        case 2:
            model = textField.text!
        case 3:
            specs = textField.text!
        case 4:
            price = textField.text!
        case 5:
            family = textField.text!
        case 6:
            socket = textField.text!
        case 7:
            generation = textField.text!
        case 8:
            link = textField.text!
        case 9:
            image = textField.text!
        case 10:
            descriptionString = textField.text!
        default:
            print("Unable to change field to variable")
        }

        return true
    }
    func getAllFieldValues() -> [String]
    {
        var arr = [String]()
        //these are added in a very specific order so that it matches easily with how the controller calls them in the createPart Func
        arr.append(link)
        arr.append(specs)
        arr.append(price)
        arr.append(image)
        arr.append(model)
        arr.append(socket)
        arr.append(family)
        arr.append(generation)
        arr.append(descriptionString)
        arr.append(manufacturer)
        
        return arr
        
    }
    var descriptionString: String {get{return _description!}set{_description = newValue}}
    var link: String {get{return _link!}set{_link = newValue}}
    var specs: String {get{return _specs!}set{_specs = newValue}}
    var image: String {get{return _image!}set{_image = newValue}}
    var price: String {get{return _price!}set{_price = newValue}}
    var model: String {get{return _model!}set{_model = newValue}}
    var socket: String {get{return _socket!}set{_socket = newValue}}
    var family: String {get{return _family!}set{_family = newValue}}
    var generation: String {get{return _generation!}set{_generation = newValue}}
    var manufacturer: String {get{return _manufacturer!}set{_manufacturer = newValue}}
    
    
    
}
