//
//  ButtonsNLabelView.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/18/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol ButtonsNLabelViewDelegate: class {
    func buttonTouched(partType: String)
}

class ButtonsNLabelView: UIView
{
    private var costTotalLabel: UILabel? = nil
    private var _costTotalString: String = "10,000"
    private var cpuButton: UIButton? = nil
    private var gpuButton: UIButton? = nil
    private var motherboardButton: UIButton? = nil
    private var psuButton: UIButton? = nil
    private var caseButton: UIButton? = nil
    private var ramButton: UIButton? = nil
    private var storageButton: UIButton? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView: UIStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        stackView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.fill
        stackView.spacing = 5.0
        addSubview(stackView)
        
        costTotalLabel = UILabel()
        costTotalLabel?.text = "TOTAL: $" + costTotalString
        costTotalLabel?.textAlignment = NSTextAlignment.center
        costTotalLabel?.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
        costTotalLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        costTotalLabel?.textColor = UIColor.black
        costTotalLabel?.backgroundColor = UIColor.white
        stackView.addArrangedSubview(costTotalLabel!)
        
        let scrollView: UIScrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        scrollView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height * 4)
        stackView.addArrangedSubview(scrollView)
        
        
        
        let buttonStackView: UIStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 4))
        buttonStackView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        buttonStackView.axis = UILayoutConstraintAxis.vertical
        //buttonStackView.alignment = UIStackViewAlignment.fill
        buttonStackView.distribution = UIStackViewDistribution.fillEqually
        buttonStackView.spacing = 5.0
        
        cpuButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: frame.width / 3, height: frame.height))
        cpuButton?.backgroundColor = UIColor.gray
        cpuButton?.layer.cornerRadius = 8.0
        cpuButton?.layer.borderWidth = 1.5
        cpuButton?.layer.borderColor = UIColor.lightGray.cgColor
        cpuButton?.setTitle("CPU", for: .normal)
        cpuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        cpuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        gpuButton = UIButton()
        gpuButton?.backgroundColor = UIColor.gray
        gpuButton?.layer.cornerRadius = 8.0
        gpuButton?.layer.borderWidth = 1.5
        gpuButton?.layer.borderColor = UIColor.lightGray.cgColor
        gpuButton?.setTitle("Graphics Card", for: .normal)
        gpuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        gpuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        caseButton = UIButton()
        caseButton?.backgroundColor = UIColor.gray
        caseButton?.layer.cornerRadius = 8.0
        caseButton?.layer.borderWidth = 1.5
        caseButton?.layer.borderColor = UIColor.lightGray.cgColor
        caseButton?.setTitle("Case", for: .normal)
        caseButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        caseButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        psuButton = UIButton()
        psuButton?.backgroundColor = UIColor.gray
        psuButton?.layer.cornerRadius = 8.0
        psuButton?.layer.borderWidth = 1.5
        psuButton?.layer.borderColor = UIColor.lightGray.cgColor
        psuButton?.setTitle("Power Supply", for: .normal)
        psuButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        psuButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        ramButton = UIButton()
        ramButton?.backgroundColor = UIColor.gray
        ramButton?.layer.cornerRadius = 8.0
        ramButton?.layer.borderWidth = 1.5
        ramButton?.layer.borderColor = UIColor.lightGray.cgColor
        ramButton?.setTitle("RAM", for: .normal)
        ramButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        ramButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        motherboardButton = UIButton()
        motherboardButton?.backgroundColor = UIColor.gray
        motherboardButton?.layer.cornerRadius = 8.0
        motherboardButton?.layer.borderWidth = 1.5
        motherboardButton?.layer.borderColor = UIColor.lightGray.cgColor
        motherboardButton?.setTitle("Motherboard", for: .normal)
        motherboardButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
        motherboardButton?.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(cpuButton!)
        buttonStackView.addArrangedSubview(motherboardButton!)
        buttonStackView.addArrangedSubview(gpuButton!)
        buttonStackView.addArrangedSubview(caseButton!)
        buttonStackView.addArrangedSubview(psuButton!)
        
        
        scrollView.addSubview(buttonStackView)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func buttonTouchUp(button: UIButton)
    {
        let partType = button.currentTitle
        delegate?.buttonTouched(partType: partType!)
    }
    var costTotalString: String
    {
        set{ _costTotalString = newValue}
        get{return _costTotalString}
    }
    
    weak var delegate: ButtonsNLabelViewDelegate? = nil
}
