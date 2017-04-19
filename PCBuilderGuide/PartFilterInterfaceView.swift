//
//  PartFilterInterfaceView.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/18/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol PartFilterInterfaceViewDelegate: class {
    func buttonTouched(specificPartType: String)
}

class PartFilterInterfaceView: UIView
{
    private var buttonAttributes: [(text: NSString, color: UIColor)] = []
    private var stackView: UIStackView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: (frame.height / 3) * CGFloat(buttonAttributes.count) * 0.95))
        stackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        stackView?.axis = UILayoutConstraintAxis.vertical
        stackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        stackView?.isLayoutMarginsRelativeArrangement = true
        stackView?.distribution = UIStackViewDistribution.fillEqually
        stackView?.spacing = 15.0
        stackView?.backgroundColor = UIColor.white
        addSubview(stackView!)
        
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setButtonAttributes(partType: [String])
    {
        buttonAttributes.removeAll()
        for i: Int in 0..<(partType.count)
        {
            let buttonColor: UIColor = UIColor.blue
            let stringText: NSString = partType[i] as NSString
            
            buttonAttributes.append((text: stringText, color: buttonColor))
            
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let dimension: CGFloat = min(bounds.width, bounds.height)
        stackView?.frame = CGRect(x: 0.0, y: 0.0, width: rect.width, height: (dimension / 3) * CGFloat(buttonAttributes.count) * 0.95)
        for i: Int in 0..<(buttonAttributes.count)
        {
            let button: UIButton = UIButton()
            button.frame = CGRect(x: 0.0, y: 0.0, width: dimension, height: dimension / 2)
            button.layer.borderWidth = 2.5
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.cornerRadius = 10.0
            
            button.setTitle(buttonAttributes[i].text as String, for: .normal)
            button.backgroundColor = buttonAttributes[i].color
            button.tag = i
            button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
            
            
            stackView?.addArrangedSubview(button)
        }
        
    }
    func buttonTouchDown(button: UIButton)
    {
        button.backgroundColor = UIColor.cyan
    }
    func buttonTouchUp(button: UIButton)
    {
        button.backgroundColor = UIColor.cyan
        let buttonName = buttonAttributes[button.tag].text
        delegate?.buttonTouched(specificPartType: buttonName as String)
    }
    
    var getButtonAttributes: [(text: NSString, color: UIColor)] {return buttonAttributes}
    weak var delegate: PartFilterInterfaceViewDelegate? = nil

}
