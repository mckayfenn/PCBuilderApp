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
    
    init(frame: CGRect, buildView: BuildInterfaceView) {
        super.init(frame: frame)
        
        mainStackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        mainStackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        mainStackView?.axis = UILayoutConstraintAxis.vertical
        mainStackView?.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainStackView?.isLayoutMarginsRelativeArrangement = true
        mainStackView?.distribution = UIStackViewDistribution.fillEqually
        mainStackView?.spacing = 5.0
        mainStackView?.backgroundColor = UIColor.white
        
        addSubview(mainStackView!)
        
        buildInterfaceView = buildView
        buildInterfaceView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        
        mainStackView?.addArrangedSubview(buildInterfaceView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
