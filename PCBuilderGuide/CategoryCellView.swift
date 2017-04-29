//
//  CategoryView.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/19/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class CategoryCellView: UIView {
    
    private var _modelLabel: String? = nil
    private var _priceLabel: String? = nil
    
    var modelLabel: String { get { return _modelLabel! } set { _modelLabel = newValue } }
    var priceLabel: String { get { return _priceLabel! } set { _priceLabel = newValue } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

    
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        let preview: CGRect = CGRect(x: 0.0 + 3, y: 0.0 + 3, width: bounds.size.width - 6, height: bounds.size.height - 6)
        
        
        context.setFillColor(UIColor.blue.cgColor)
        context.addRect(preview)
        context.drawPath(using: .fill)
        
        
        let modelTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: preview.width / 8), NSForegroundColorAttributeName: UIColor.white]
        let modelTextSize: CGSize = _modelLabel!.size(attributes: modelTextAttribute)
        _modelLabel?.draw(at: CGPoint(x: preview.midX - modelTextSize.width / 2, y: preview.midY + modelTextSize.height / 2), withAttributes: modelTextAttribute)
        
        let priceTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: preview.width / 10), NSForegroundColorAttributeName: UIColor.white]
        let priceTextSize: CGSize = _priceLabel!.size(attributes: priceTextAttribute)
        _priceLabel?.draw(at: CGPoint(x: preview.midX - priceTextSize.width / 2, y: preview.midY + 4 * priceTextSize.height / 2), withAttributes: priceTextAttribute)
    }
    
}
