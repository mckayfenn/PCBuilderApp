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
    private var _imageURL: String? = nil
    private var _compatible: Bool = true
    private var imageView: UIImageView? = nil
    
    var modelLabel: String { get { return _modelLabel! } set { _modelLabel = newValue } }
    var priceLabel: String { get { return _priceLabel! } set { _priceLabel = newValue } }
    var imageURL: String { get { return _imageURL! } set { _imageURL = newValue } }
    var compatible: Bool { get { return _compatible } set { _compatible = newValue } }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

    
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        let preview: CGRect = CGRect(x: 0.0 + 3, y: 0.0 + 3, width: bounds.size.width - 6, height: bounds.size.height - 6)
        
        let colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors , locations: [0.0, 0.8, 1])
        
        
        context.addRect(preview)
        context.clip(to: preview)
        context.drawLinearGradient(gradient!, start: CGPoint(x: preview.minX, y: preview.minY) , end: CGPoint(x: preview.minX , y: preview.maxY), options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        
        
        let imageRect = CGRect(x: preview.midX - preview.midX / 2 - 15, y: preview.minY + 10, width: preview.width / 2 + 30, height: preview.height / 3 + 20)
        
        imageView = UIImageView(frame: imageRect)
        
        if let checkedURL = URL(string: (imageURL)) {
            imageView?.contentMode = .scaleAspectFit
            downloadImage(url: checkedURL)
        }
        
        let url = URL(string: imageURL)
        
        
        addSubview(imageView!)
        
        context.addRect(imageRect)
        
        
        let modelLength: Int = (_modelLabel?.characters.count)!
        var modelTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: preview.width / (CGFloat(modelLength) * 0.9)), NSForegroundColorAttributeName: UIColor.white]
        if(modelLength > 9)
        {
            modelTextAttribute = [NSFontAttributeName:UIFont.systemFont(ofSize: preview.width / (CGFloat(modelLength) * 0.65)), NSForegroundColorAttributeName: UIColor.white]
        }


        let modelTextSize: CGSize = _modelLabel!.size(attributes: modelTextAttribute)
        _modelLabel?.draw(at: CGPoint(x: preview.midX - modelTextSize.width / 2, y: imageRect.maxY + preview.midX / 4 + modelTextSize.height / 2), withAttributes: modelTextAttribute)
        
        let priceTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: preview.width / 10), NSForegroundColorAttributeName: UIColor.white]
        let priceTextSize: CGSize = _priceLabel!.size(attributes: priceTextAttribute)
        _priceLabel?.draw(at: CGPoint(x: preview.midX - priceTextSize.width / 2, y: imageRect.maxY + preview.midX / 4 + 4 * priceTextSize.height / 2), withAttributes: priceTextAttribute)
        
        
        if (!compatible) {
            let compatibleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: preview.width + 30, height: preview.height + 30))
            compatibleLabel.text = "NOT COMPATIBLE"
            compatibleLabel.textColor = UIColor(red: 200.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 0.5)
            compatibleLabel.font = UIFont.boldSystemFont(ofSize:18)
            compatibleLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -3.5).translatedBy(x: 0.0, y: -15.0)
            addSubview(compatibleLabel)
        }
    }
    
    // get the image data from url.    FROM (http://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift)
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    // download the image.     FROM (http://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift)
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                self.imageView?.image = UIImage(data: data)
            }
        }
    }
    
}
