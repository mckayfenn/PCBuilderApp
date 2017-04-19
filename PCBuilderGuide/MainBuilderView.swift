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
    
    private var costTotalLabel: UILabel? = nil
    
    init(frame: CGRect, buildView: BuildInterfaceView, buildButtonsView: BuildButtonsView) {
        super.init(frame: frame)
        
        buildInterfaceView = buildView
        buildInterfaceView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)

        costTotalLabel = UILabel()
        costTotalLabel?.text = "TOTAL: $10,000"
        costTotalLabel?.textAlignment = NSTextAlignment.center
        costTotalLabel?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width / 4, height: frame.height / 4)
        costTotalLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        costTotalLabel?.textColor = UIColor.black
        costTotalLabel?.backgroundColor = UIColor.white
        
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height / 4))
        scrollView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        scrollView?.contentSize = CGSize(width: frame.width * 2, height: (frame.height / 5))
        
        _buildButtonsView = buildButtonsView
        _buildButtonsView?.frame = CGRect(x: 0.0, y: 0.0, width: (scrollView?.frame.width)! * 2, height: (scrollView?.frame.height)!)
        
        scrollView?.addSubview(_buildButtonsView!)
        
        addSubview(buildInterfaceView!)
        addSubview(costTotalLabel!)
        addSubview(scrollView!)
        
        setNeedsLayout()

    }
    override func layoutSubviews() {
        var rect: CGRect = bounds
        

        (buildInterfaceView!.frame, rect) = rect.divided(atDistance: rect.height * 0.635, from: .minYEdge)
        (costTotalLabel!.frame, rect) = rect.divided(atDistance: rect.height * 0.3, from: .minYEdge)
        (scrollView!.frame,rect) = rect.divided(atDistance: rect.height, from: .maxYEdge)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
