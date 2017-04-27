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
        
        buildInterfaceView = buildView
        buildInterfaceView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height / 4))
        scrollView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        scrollView?.contentSize = CGSize(width: frame.width * 3, height: (frame.height / 5))
        
        _costTotalLabel = UILabel()
        _costTotalLabel?.text = "Total: $" + String(describing: _costTotalText)
        _costTotalLabel?.textAlignment = NSTextAlignment.center
        _costTotalLabel?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width / 4, height: frame.height / 4)
        _costTotalLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        _costTotalLabel?.textColor = UIColor.black
        _costTotalLabel?.backgroundColor = UIColor.white
        
        _buildButtonsView = buildButtonsView
        _buildButtonsView?.frame = CGRect(x: 0.0, y: 0.0, width: (scrollView?.frame.width)! * 3, height: (scrollView?.frame.height)!)
        _buildButtonsView?.backgroundColor = UIColor.white
        
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
    var costTotalText: Int { get{return _costTotalText} set{_costTotalText = newValue}}
    
}
