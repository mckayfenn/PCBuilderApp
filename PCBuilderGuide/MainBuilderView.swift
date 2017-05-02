//
//  MainBuilderView.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/18/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class MainBuilderView: UIView {
    
    private var mainStackView: UIStackView? = nil
    private var buildInterfaceView: BuildInterfaceView? = nil
    private var _buildButtonsView: BuildButtonsView? = nil
    private var scrollView: UIScrollView? = nil
    
    private var _costTotalLabel: UILabel? = nil
    private var _costTotalText: Int = 0
    
    init(frame: CGRect, buildView: BuildInterfaceView, buildButtonsView: BuildButtonsView) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        buildInterfaceView = buildView
        buildInterfaceView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height / 4))
        scrollView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        scrollView?.contentSize = CGSize(width: frame.width * 5, height: (frame.height / 5))
        
        _costTotalLabel = UILabel()
        _costTotalLabel?.text = "Total: $" + String(describing: _costTotalText)
        _costTotalLabel?.textAlignment = NSTextAlignment.center
        _costTotalLabel?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height / 8)
        _costTotalLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        _costTotalLabel?.textColor = UIColor.black
        _costTotalLabel?.backgroundColor = UIColor.white

        
        _buildButtonsView = buildButtonsView
        _buildButtonsView?.frame = CGRect(x: 0.0, y: 0.0, width: (scrollView?.frame.width)! * 5, height: (scrollView?.frame.height)!)
        setGradientColors(viewPassed: _buildButtonsView!, colors: [UIColor.white, UIColor.lightGray], gradientLocations: [0.0,0.5,1.0])

        
        scrollView?.addSubview(_buildButtonsView!)
        
        addSubview(buildInterfaceView!)
        addSubview(_costTotalLabel!)
        addSubview(scrollView!)
        
        setNeedsDisplay()
        setNeedsLayout()

    }
    override func draw(_ rect: CGRect) {
        _costTotalLabel?.text = "Total: $" + String(describing: _costTotalText)
    }
    override func layoutSubviews() {
        var rect: CGRect = bounds
        

        (buildInterfaceView!.frame, rect) = rect.divided(atDistance: rect.height * 0.635, from: .minYEdge)
        (_costTotalLabel!.frame, rect) = rect.divided(atDistance: rect.height * 0.3, from: .minYEdge)
        (scrollView!.frame,rect) = rect.divided(atDistance: rect.height, from: .maxYEdge)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setGradientColors(viewPassed: UIView,colors: [UIColor], gradientLocations: [NSNumber])
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = viewPassed.frame
        gradient.colors = colors.map {$0.cgColor}
        gradient.locations = gradientLocations
        viewPassed.layer.insertSublayer(gradient, at: 0)
        
    }
    var costTotalText: Int { get{return _costTotalText} set{_costTotalText = newValue}}
    
}
