//
//  NavigationFilterInterface.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/10/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol NavigationFilterInterfaceViewDelegate: class {
    func buttonTouched(specificPartType: String)
}

class NavigationFilterInterfaceView: UIView {
    

    private var _requestedSpecificPartType: [String]? = nil
    private var buttons: [(name: NSString, rect: CGRect, color: CGColor)] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        
        for i: Int in 0 ..< (_requestedSpecificPartType?.count)!
        {
            var buttonRect: CGRect = CGRect.zero
            
            let dimension: CGFloat = min(bounds.width, bounds.height)
            
            var buttonColor: CGColor = UIColor.blue.cgColor
            
            buttonRect.size.width = dimension / 2
            buttonRect.size.height = dimension / 4//CGFloat(4 + (Double(i) * 0.3))
            
            buttonRect.origin.x = bounds.midX - buttonRect.size.width / 2
            buttonRect.origin.y = bounds.minY + ((buttonRect.size.height * 1.3) * CGFloat(i)) + 10
            
            
            context.addRect(buttonRect)
            context.setFillColor(buttonColor)
            context.drawPath(using: .fill)
            
            let stringText: NSString = _requestedSpecificPartType![i] as NSString
            
            let stringTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: buttonRect.width / 4)]
            let stringSize: CGSize = stringText.size(attributes: stringTextAttribute)
            stringText.draw(at: CGPoint(x: buttonRect.midX - stringSize.width / 2, y: buttonRect.midY - stringSize.height / 2), withAttributes: stringTextAttribute)
            
            buttons.append((name: stringText, rect: buttonRect, color: buttonColor))
            
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let touchPoint = touch.location(in: self)
        for var button in buttons
        {
            if (button.rect.contains(touchPoint)) {
                button.color = UIColor.cyan.cgColor
                break
            }
            
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let touchPoint = touch.location(in: self)
        setNeedsDisplay()
        
        for var button in buttons
        {
            if (button.rect.contains(touchPoint)) {
                delegate?.buttonTouched(specificPartType: button.name as String)
                button.color = UIColor.blue.cgColor
                break
            }

        }
    }
    public var requestedSpecificPartType: [String]
    {
        set{
            _requestedSpecificPartType = newValue
        }
        get
        {
            return _requestedSpecificPartType!
        }
    }
    
    weak var delegate: NavigationFilterInterfaceViewDelegate? = nil
}
