//
//  MainFilterView.swift
//  PCBuilderGuide
//
//  Created by u0669056 on 4/18/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class MainFilterView: UIView
{
    private var mainScrollView: UIScrollView? = nil
    private var partFilterInterfaceView: PartFilterInterfaceView? = nil
    
    init(frame: CGRect, nextView: PartFilterInterfaceView) {
        super.init(frame: frame)
        
        var screenView = (frame.height / 5) * CGFloat(nextView.getButtonAttributes.count)
        
        mainScrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        mainScrollView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        //mainScrollView?.alwaysBounceVertical = true
        mainScrollView?.contentSize = CGSize(width: frame.width, height: screenView)
        addSubview(mainScrollView!)
        
        partFilterInterfaceView = nextView
        if(screenView < frame.height)
        {
            screenView = frame.height
        }
        partFilterInterfaceView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: screenView)
        partFilterInterfaceView?.backgroundColor = UIColor.white
        
        mainScrollView?.addSubview(partFilterInterfaceView!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mainScrollingView: UIScrollView? {return mainScrollView}
    var partFilteringInterfaceView: PartFilterInterfaceView? {return partFilterInterfaceView}
}
