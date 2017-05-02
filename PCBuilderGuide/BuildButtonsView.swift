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
    private var opticalDriveButton: UIButton? = nil
    private var coolerButton: UIButton? = nil
    
    var buttonStackView: UIStackView? = nil
    
    private var buttons = [UIButton]()
    
    private var cpuButtonTitle: String = "CPU: Select CPU"
    private var gpuButtonTitle: String = "Graphics Card: Select GPU"
    private var psuButtonTitle: String = "Power Supply: Select Power Supply"
    private var ramButtonTitle: String = "RAM: Select RAM"
    private var caseButtonTitle: String = "Case: Select CASE"
    private var motherboardButtonTitle: String = "Motherboard: Select Motherboard"
    private var storageButtonTitle: String = "Storage: Select Storage"
    private var opticalDriveButtonTitle: String = "Optical Drive: Select Optical Drive"
    private var coolerButtonTitle: String = "Cooler: Select CPU Cooler"
    
    
    private var _borderColor: CGColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 1.0).cgColor

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        buttonStackView = UIStackView()
        buttonStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        buttonStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 40, right: 5)
        buttonStackView?.isLayoutMarginsRelativeArrangement = true
        buttonStackView?.axis = UILayoutConstraintAxis.horizontal
        buttonStackView?.distribution = UIStackViewDistribution.fillEqually
        
        buttonStackView?.backgroundColor = UIColor.brown
        buttonStackView?.spacing = 8.0
        
        cpuButton = UIButton()
        cpuButton?.layer.cornerRadius = 7.0
        cpuButton?.layer.borderWidth = 4.7
        cpuButton?.layer.borderColor = _borderColor
        cpuButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cpuButton?.titleLabel?.textAlignment = .center
        cpuButton?.setTitle(cpuButtonTitle, for: .normal)
        cpuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(cpuButton!)
        cpuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        cpuButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        gpuButton = UIButton()
        gpuButton?.layer.cornerRadius = 7.0
        gpuButton?.layer.borderWidth = 4.7
        gpuButton?.layer.borderColor = _borderColor
        gpuButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        gpuButton?.titleLabel?.textAlignment = .center
        gpuButton?.setTitle(gpuButtonTitle, for: .normal)
        gpuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(gpuButton!)
        gpuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        gpuButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        caseButton = UIButton()
        caseButton?.layer.cornerRadius = 7.0
        caseButton?.layer.borderWidth = 4.7
        caseButton?.layer.borderColor = _borderColor
        caseButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        caseButton?.titleLabel?.textAlignment = .center
        caseButton?.setTitle(caseButtonTitle, for: .normal)
        caseButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(caseButton!)
        caseButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        caseButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        psuButton = UIButton()
        psuButton?.layer.cornerRadius = 7.0
        psuButton?.layer.borderWidth = 4.7
        psuButton?.layer.borderColor = _borderColor
        psuButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        psuButton?.titleLabel?.textAlignment = .center
        psuButton?.setTitle(psuButtonTitle, for: .normal)
        psuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(psuButton!)
        psuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        psuButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        ramButton = UIButton()
        ramButton?.layer.cornerRadius = 7.0
        ramButton?.layer.borderWidth = 4.7
        ramButton?.layer.borderColor = _borderColor
        ramButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        ramButton?.titleLabel?.textAlignment = .center
        ramButton?.setTitle(ramButtonTitle, for: .normal)
        ramButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(ramButton!)
        ramButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        ramButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        motherboardButton = UIButton()
        motherboardButton?.layer.cornerRadius = 7.0
        motherboardButton?.layer.borderWidth = 4.7
        motherboardButton?.layer.borderColor = _borderColor
        motherboardButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        motherboardButton?.titleLabel?.textAlignment = .center
        motherboardButton?.setTitle(motherboardButtonTitle, for: .normal)
        motherboardButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(motherboardButton!)
        motherboardButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        motherboardButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        storageButton = UIButton()
        storageButton?.layer.cornerRadius = 7.0
        storageButton?.layer.borderWidth = 4.7
        storageButton?.layer.borderColor = _borderColor
        storageButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        storageButton?.titleLabel?.textAlignment = .center
        storageButton?.setTitle(storageButtonTitle, for: .normal)
        storageButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(storageButton!)
        storageButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        storageButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        opticalDriveButton = UIButton()
        opticalDriveButton?.layer.cornerRadius = 7.0
        opticalDriveButton?.layer.borderWidth = 4.7
        opticalDriveButton?.layer.borderColor = _borderColor
        opticalDriveButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        opticalDriveButton?.titleLabel?.textAlignment = .center
        opticalDriveButton?.setTitle(opticalDriveButtonTitle, for: .normal)
        opticalDriveButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(opticalDriveButton!)
        opticalDriveButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        opticalDriveButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        coolerButton = UIButton()
        coolerButton?.layer.cornerRadius = 7.0
        coolerButton?.layer.borderWidth = 4.7
        coolerButton?.layer.borderColor = _borderColor
        coolerButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        coolerButton?.titleLabel?.textAlignment = .center
        coolerButton?.setTitle(coolerButtonTitle, for: .normal)
        coolerButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        buttons.append(coolerButton!)
        coolerButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        coolerButton?.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        buttonStackView?.addArrangedSubview(cpuButton!)
        buttonStackView?.addArrangedSubview(motherboardButton!)
        buttonStackView?.addArrangedSubview(gpuButton!)
        buttonStackView?.addArrangedSubview(ramButton!)
        buttonStackView?.addArrangedSubview(caseButton!)
        buttonStackView?.addArrangedSubview(psuButton!)
        buttonStackView?.addArrangedSubview(storageButton!)
        buttonStackView?.addArrangedSubview(coolerButton!)
        buttonStackView?.addArrangedSubview(opticalDriveButton!)
        
        
        addSubview(buttonStackView!)
    }
    override func draw(_ rect: CGRect) {
        cpuButton?.setTitle(cpuButtonTitle, for: .normal)
        gpuButton?.setTitle(gpuButtonTitle, for: .normal)
        caseButton?.setTitle(caseButtonTitle, for: .normal)
        psuButton?.setTitle(psuButtonTitle, for: .normal)
        ramButton?.setTitle(ramButtonTitle, for: .normal)
        motherboardButton?.setTitle(motherboardButtonTitle, for: .normal)
        storageButton?.setTitle(storageButtonTitle, for: .normal)
        coolerButton?.setTitle(coolerButtonTitle, for: .normal)
        opticalDriveButton?.setTitle(opticalDriveButtonTitle, for: .normal)
        
        for button in buttons
        {
            setGradientColors(button: button, colors: [UIColor.lightGray, UIColor.darkGray], gradientLocations: [0.0,0.5,1.0])
        }
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
    func buttonTouchDown(button: UIButton)
    {

    }
    
    func setGradientColors(button: UIButton,colors: [UIColor], gradientLocations: [NSNumber])
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 1.5, y: 1.5, width: frame.width * 0.104, height: frame.height * 0.62)
        gradient.colors = colors.map {$0.cgColor}
        gradient.locations = gradientLocations
        button.layer.insertSublayer(gradient, at: 0)
    }

    weak var delegate: BuildButtonsViewDelegate? = nil
    
    var cpuButtonTitleText: String {get{return cpuButtonTitle} set{cpuButtonTitle = "CPU: " + newValue}}
    var gpuButtonTitleText: String {get{return gpuButtonTitle} set{gpuButtonTitle = "Graphics Card: " + newValue}}
    var psuButtonTitleText: String {get{return psuButtonTitle} set{psuButtonTitle = "Power Supply: " + newValue}}
    var motherboardButtonTitleText: String {get{return motherboardButtonTitle} set{motherboardButtonTitle = "Motherboard: " + newValue}}
    var caseButtonTitleText: String {get{return caseButtonTitle} set{caseButtonTitle = "Case: " + newValue}}
    var ramButtonTitleText: String {get{return ramButtonTitle} set{ramButtonTitle = "RAM: " + newValue}}
    var storageButtonTitleText: String {get{return storageButtonTitle} set{storageButtonTitle = "Storage: " + newValue}}
    var opticalDriveButtonTitleText: String {get{return opticalDriveButtonTitle} set{opticalDriveButtonTitle = "Optical Drive: " + newValue}}
    var coolerButtonTitleText: String {get{return coolerButtonTitle} set{coolerButtonTitle = "Cooler: " + newValue}}
    
    var borderColor: CGColor {get{return _borderColor} set{_borderColor = newValue}}
}
