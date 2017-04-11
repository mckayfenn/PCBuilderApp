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
    
    public func createButtons() {
        if(_requestedSpecificPartType != nil)
        {
            buttons.removeAll()
            for i: Int in 0..<(_requestedSpecificPartType?.count)!
            {
                var buttonRect: CGRect = CGRect.zero
                let buttonColor: CGColor = UIColor.blue.cgColor
                
                let stringText: NSString = "nil"
                
                buttons.append((name: stringText, rect: buttonRect, color: buttonColor))
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        for i: Int in 0..<(buttons.count)
        {
            let dimension: CGFloat = min(bounds.width, bounds.height)
            
            buttons[i].rect.size.width = dimension / 2
            buttons[i].rect.size.height = dimension / 4
            
            
            
            
            buttons[i].rect.origin.x = bounds.midX - buttons[i].rect.size.width / 2
            buttons[i].rect.origin.y = bounds.minY + ((buttons[i].rect.size.height * 1.3) * CGFloat(i)) + 10
 
            context.addRect(buttons[i].rect)
            context.setFillColor(buttons[i].color)
            context.drawPath(using: .fill)
            
            buttons[i].name = _requestedSpecificPartType![i] as NSString
            
            
            let stringTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: buttons[i].rect.width / 4)]
            let stringSize: CGSize = buttons[i].name.size(attributes: stringTextAttribute)
            buttons[i].name.draw(at: CGPoint(x: buttons[i].rect.midX - stringSize.width / 2, y: buttons[i].rect.midY - stringSize.height / 2), withAttributes: stringTextAttribute)

        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let touchPoint = touch.location(in: self)
        for i: Int in 0..<(buttons.count)
        {
            if (buttons[i].rect.contains(touchPoint)) {
                buttons[i].color = UIColor.cyan.cgColor
                break
            }
            
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let touchPoint = touch.location(in: self)
        
        for i: Int in 0..<(buttons.count)
        {
            if (buttons[i].rect.contains(touchPoint)) {
                delegate?.buttonTouched(specificPartType: buttons[i].name as String)
                buttons[i].color = UIColor.blue.cgColor
                break
            }

        }
        setNeedsDisplay()
    }
    public var requestedSpecificPartType: [String]
    {
        set{
            _requestedSpecificPartType = newValue
            //setNeedsDisplay()
        }
        get
        {
            return _requestedSpecificPartType!
        }
    }
    
    weak var delegate: NavigationFilterInterfaceViewDelegate? = nil
}
