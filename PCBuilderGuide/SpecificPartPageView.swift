//
//  SpecificPartPageView.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/21/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class SpecificPartPageView: UIView {
    
    private var scrollView: UIScrollView? = nil
    private var partView: PartView? = nil
    
    init(frame: CGRect, part: MyParts) {
        super.init(frame: frame)
        
        let screenView = bounds.height
        
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        scrollView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        scrollView?.contentSize = CGSize(width: frame.width, height: screenView)
        addSubview(scrollView!)
        
        partView = PartView(frame: frame, part: part)
        partView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: screenView)
        partView?.backgroundColor = UIColor.white
        
        scrollView?.addSubview(partView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





class PartView: UIView {
    
    private var stackView: UIStackView? = nil
    private var imageView: UIImageView? = nil
    private var _part: MyParts? = nil
    
    init(frame: CGRect, part: MyParts) {
        super.init(frame: frame)
        
        _part = part
        
        print("in PartView")
        
        
        
        stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        stackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        stackView?.axis = UILayoutConstraintAxis.vertical
        stackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        stackView?.isLayoutMarginsRelativeArrangement = true
        stackView?.distribution = UIStackViewDistribution.fillEqually
        stackView?.spacing = 15.0
        stackView?.backgroundColor = UIColor.blue
        
        addSubview(stackView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        stackView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        
        let selectButton: UIButton = UIButton()
        //selectButton.frame = CGRect(x: frame.midX - selectButton.frame.width, y: 10, width: frame.width / 2, height: frame.height / 10)
        selectButton.frame.size = CGSize(width: frame.width / 2, height: frame.height / 10)
        selectButton.frame.origin.x = frame.midX - selectButton.frame.width / 2
        selectButton.frame.origin.y = 10
        selectButton.layer.borderWidth = 2.5
        selectButton.layer.borderColor = UIColor.lightGray.cgColor
        selectButton.layer.cornerRadius = 10.0
        selectButton.backgroundColor = UIColor.blue
        selectButton.setTitle("Select", for: .normal)
        selectButton.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        
        stackView?.addSubview(selectButton)
        
        
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        label.textColor = UIColor.black
        label.text = _part?._model
        
        stackView?.addSubview(label)
        
        
        imageView = UIImageView(frame: CGRect(x: frame.midX - frame.midX / 2, y: selectButton.frame.maxY, width: frame.width / 2, height: frame.height / 3))
        if let checkedURL = URL(string: (_part?._image)!) {
            imageView?.contentMode = .scaleAspectFit
            downloadImage(url: checkedURL)
        }
        
        
        stackView?.addSubview(imageView!)
        
    }
    
    func buttonSelected() {
        print("Select button was selected")
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
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.imageView?.image = UIImage(data: data)
            }
        }
    }
    
    
}
