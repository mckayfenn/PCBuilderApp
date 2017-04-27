//
//  BuildButtonsView.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/19/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol BuildButtonsViewDelegate: class {
    func buttonTouched(partType: String)
}

class BuildButtonsView: UIView
{
    private var cpuButton: UIButton? = nil
    private var gpuButton: UIButton? = nil
    private var motherboardButton: UIButton? = nil
    private var psuButton: UIButton? = nil
    private var caseButton: UIButton? = nil
    private var ramButton: UIButton? = nil
    private var storageButton: UIButton? = nil
    
    var buttonStackView: UIStackView? = nil
    
    
    private var cpuButtonTitle: String = "CPU: Select CPU"
    private var gpuButtonTitle: String = "GPU: Select GPU"
    private var psuButtonTitle: String = "Power Supply: Select Power Supply"
    private var ramButtonTitle: String = "RAM: Select RAM"
    private var caseButtonTitle: String = "Case: Select CASE"
    private var motherboardButtonTitle: String = "Motherboard: Select Motherboard"
    private var storageButtonTitle: String = "Storage: Select Storage"
    private var opticalDriveButtonTitle: String = "Optical Drive: Select Optical Drive"
    private var coolerButtonTitle: String = "Cooler: Select CPU Cooler"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        buttonStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        buttonStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        buttonStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 40, right: 5)
        buttonStackView?.isLayoutMarginsRelativeArrangement = true
        buttonStackView?.axis = UILayoutConstraintAxis.horizontal
        //buttonStackView?.alignment = UIStackViewAlignment
        buttonStackView?.distribution = UIStackViewDistribution.fillEqually
        
        buttonStackView?.backgroundColor = UIColor.brown
        buttonStackView?.spacing = 8.0
        
        cpuButton = UIButton()
        cpuButton?.backgroundColor = UIColor.gray
        cpuButton?.layer.cornerRadius = 8.0
        cpuButton?.layer.borderWidth = 1.5
        cpuButton?.layer.borderColor = UIColor.lightGray.cgColor
        cpuButton?.setTitle(cpuButtonTitle, for: .normal)
        cpuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        cpuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        gpuButton = UIButton()
        gpuButton?.backgroundColor = UIColor.gray
        gpuButton?.layer.cornerRadius = 8.0
        gpuButton?.layer.borderWidth = 1.5
        gpuButton?.layer.borderColor = UIColor.lightGray.cgColor
        gpuButton?.setTitle(gpuButtonTitle, for: .normal)
        gpuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        gpuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        caseButton = UIButton()
        caseButton?.backgroundColor = UIColor.gray
        caseButton?.layer.cornerRadius = 8.0
        caseButton?.layer.borderWidth = 1.5
        caseButton?.layer.borderColor = UIColor.lightGray.cgColor
        caseButton?.setTitle(caseButtonTitle, for: .normal)
        caseButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        caseButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        psuButton = UIButton()
        psuButton?.backgroundColor = UIColor.gray
        psuButton?.layer.cornerRadius = 8.0
        psuButton?.layer.borderWidth = 1.5
        psuButton?.layer.borderColor = UIColor.lightGray.cgColor
        psuButton?.setTitle(psuButtonTitle, for: .normal)
        psuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        psuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        ramButton = UIButton()
        ramButton?.backgroundColor = UIColor.gray
        ramButton?.layer.cornerRadius = 8.0
        ramButton?.layer.borderWidth = 1.5
        ramButton?.layer.borderColor = UIColor.lightGray.cgColor
        ramButton?.setTitle(ramButtonTitle, for: .normal)
        ramButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        ramButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        motherboardButton = UIButton()
        motherboardButton?.backgroundColor = UIColor.gray
        motherboardButton?.layer.cornerRadius = 8.0
        motherboardButton?.layer.borderWidth = 1.5
        motherboardButton?.layer.borderColor = UIColor.lightGray.cgColor
        motherboardButton?.setTitle(motherboardButtonTitle, for: .normal)
        motherboardButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        motherboardButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        buttonStackView?.addArrangedSubview(cpuButton!)
        buttonStackView?.addArrangedSubview(motherboardButton!)
        buttonStackView?.addArrangedSubview(gpuButton!)
        buttonStackView?.addArrangedSubview(caseButton!)
        buttonStackView?.addArrangedSubview(psuButton!)
        
        
        addSubview(buttonStackView!)
    }
    override func draw(_ rect: CGRect) {
        cpuButton?.setTitle(cpuButtonTitle, for: .normal)
        gpuButton?.setTitle(gpuButtonTitle, for: .normal)
        caseButton?.setTitle(caseButtonTitle, for: .normal)
        psuButton?.setTitle(psuButtonTitle, for: .normal)
        ramButton?.setTitle(ramButtonTitle, for: .normal)
        motherboardButton?.setTitle(motherboardButtonTitle, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buttonTouchUp(button: UIButton)
    {
        var splitString = button.currentTitle?.components(separatedBy: ":")
        let partType = splitString?[0]
        
        delegate?.buttonTouched(partType: partType!)
    }
    weak var delegate: BuildButtonsViewDelegate? = nil
    
    var cpuButtonTitleText: String {get{return cpuButtonTitle} set{cpuButtonTitle = "CPU: " + newValue}}
    var gpuButtonTitleText: String {get{return gpuButtonTitle} set{gpuButtonTitle = "GPU: " + newValue}}
    var psuButtonTitleText: String {get{return psuButtonTitle} set{psuButtonTitle = "Power Supply: " + newValue}}
    var motherboardButtonTitleText: String {get{return motherboardButtonTitle} set{motherboardButtonTitle = "Motherboard: " + newValue}}
    var caseButtonTitleText: String {get{return caseButtonTitle} set{caseButtonTitle = "Case: " + newValue}}
    var ramButtonTitleText: String {get{return ramButtonTitle} set{ramButtonTitle = "RAM: " + newValue}}
    var storageButtonTitleText: String {get{return storageButtonTitle} set{storageButtonTitle = "Storage: " + newValue}}
    var opticalDriveButtonTitleText: String {get{return opticalDriveButtonTitle} set{opticalDriveButtonTitle = "Optical Drive" + newValue}}
    var coolerButtonTitleText: String {get{return coolerButtonTitle} set{coolerButtonTitle = "Cooler: " + newValue}}
}
