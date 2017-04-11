//
//  BuildInterfaceView.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/7/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol BuildInterfaceViewDelegate: class {
    func buttonTouched(partType: String)
}


class BuildInterfaceView: UIView {
    
    private var buttonRect: CGRect = CGRect.zero
    private var buttonRect2: CGRect = CGRect.zero
    private var buttonColor: CGColor = UIColor.blue.cgColor
    private var buttonColor2: CGColor = UIColor.blue.cgColor
    let stringText: NSString = "CPU"
    let stringText2: NSString = "Mobo"
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        buttonRect = CGRect.zero
        
        let dimension: CGFloat = min(bounds.width, bounds.height)
        
        
        buttonRect.size.width = dimension / 2
        buttonRect.size.height = dimension / 4
        
        buttonRect.origin.x = bounds.midX - buttonRect.size.width / 2
        buttonRect.origin.y = bounds.midY - buttonRect.size.height / 2 - 60
        
        
        context.addRect(buttonRect)
        context.setFillColor(buttonColor)
        context.drawPath(using: .fill)
        
        
        let stringTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: buttonRect.width / 4)]
        let stringSize: CGSize = stringText.size(attributes: stringTextAttribute)
        stringText.draw(at: CGPoint(x: buttonRect.midX - stringSize.width / 2, y: buttonRect.midY - stringSize.height / 2), withAttributes: stringTextAttribute)
        
        
        buttonRect2 = CGRect.zero
        
        buttonRect2.size.width = dimension / 2
        buttonRect2.size.height = dimension / 4
        
        buttonRect2.origin.x = bounds.midX - buttonRect2.size.width / 2
        buttonRect2.origin.y = bounds.midY - buttonRect2.size.height / 2 + 60
        
        
        context.addRect(buttonRect2)
        context.setFillColor(buttonColor2)
        context.drawPath(using: .fill)
        
        
        let stringTextAttribute2: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: buttonRect2.width / 4)]
        let stringSize2: CGSize = stringText.size(attributes: stringTextAttribute2)
        stringText2.draw(at: CGPoint(x: buttonRect2.midX - stringSize2.width / 2, y: buttonRect2.midY - stringSize2.height / 2), withAttributes: stringTextAttribute2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buttonColor = UIColor.cyan.cgColor
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let touchPoint = touch.location(in: self)
        buttonColor = UIColor.blue.cgColor
        setNeedsDisplay()
        
        if (buttonRect.contains(touchPoint)) {
            delegate?.buttonTouched(partType: stringText as String)
        }
        else if (buttonRect2.contains(touchPoint)) {
            delegate?.buttonTouched(partType: stringText2 as String)
        }
    }
    
    weak var delegate: BuildInterfaceViewDelegate? = nil
    
}
