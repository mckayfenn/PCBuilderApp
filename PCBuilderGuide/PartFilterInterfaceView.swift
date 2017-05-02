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
            button.frame = CGRect(x: 2.0, y: 2.0, width: dimension * 0.77, height: dimension / 4)
            button.layer.borderWidth = 4.0
            button.layer.borderColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 1.0).cgColor
            button.layer.cornerRadius = 5.0
            
            button.setTitle(buttonAttributes[i].text as String, for: .normal)
            setGradientColors(button: button, colors: [UIColor.gray, UIColor.darkGray], gradientLocations: [0.0,0.5,1.0])
            button.tag = i
            button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
            
            
            stackView?.addArrangedSubview(button)
        }
        
    }
    func buttonTouchDown(button: UIButton)
    {

    }
    func buttonTouchUp(button: UIButton)
    {
        button.backgroundColor = UIColor.cyan
        let buttonName = buttonAttributes[button.tag].text
        delegate?.buttonTouched(specificPartType: buttonName as String)
    }
    func setGradientColors(button: UIButton,colors: [UIColor], gradientLocations: [NSNumber])
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = button.frame
        gradient.colors = colors.map {$0.cgColor}
        gradient.locations = gradientLocations
        button.layer.insertSublayer(gradient, at: 0)
        
    }
    
    var getButtonAttributes: [(text: NSString, color: UIColor)] {return buttonAttributes}
    weak var delegate: PartFilterInterfaceViewDelegate? = nil

}
