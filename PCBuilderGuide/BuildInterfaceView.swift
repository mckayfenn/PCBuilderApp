//
//  BuildInterfaceView.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/7/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol BuildInterfaceViewDelegate: class {
    func buttonTouched()
}


class BuildInterfaceView: UIView {
    
    private var buttonRect: CGRect = CGRect.zero
    private var buttonColor: CGColor = UIColor.blue.cgColor
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        buttonRect = CGRect.zero
        
        let dimension: CGFloat = min(bounds.width, bounds.height)
        
        
        buttonRect.size.width = dimension / 2
        buttonRect.size.height = dimension / 4
        
        buttonRect.origin.x = bounds.midX - buttonRect.size.width / 2
        buttonRect.origin.y = bounds.midY - buttonRect.size.height / 2
        
        
        context.addRect(buttonRect)
        context.setFillColor(buttonColor)
        context.drawPath(using: .fill)
        
        let stringText: NSString = "Click"
        
        let stringTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: buttonRect.width / 4)]
        let stringSize: CGSize = stringText.size(attributes: stringTextAttribute)
        stringText.draw(at: CGPoint(x: buttonRect.midX - stringSize.width / 2, y: buttonRect.midY - stringSize.height / 2), withAttributes: stringTextAttribute)
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
            delegate?.buttonTouched()
        }
    }
    
    weak var delegate: BuildInterfaceViewDelegate? = nil
    
}
