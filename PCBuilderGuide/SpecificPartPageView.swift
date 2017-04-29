//
//  SpecificPartPageView.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/21/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol SpecificPartPageDelegate: class {
    func selectPartClicked(part: MyParts)
}

protocol PartViewDelegate: class {
    func selectPartClickedHere(part: MyParts)
}

class SpecificPartPageView: UIView, PartViewDelegate {
    
    private var scrollView: UIScrollView? = nil
    private var partView: PartView? = nil
    
    init(frame: CGRect, part: MyParts) {
        super.init(frame: frame)
        
        
        
        let screenView = bounds.height
        
        // Have a scroll view
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        scrollView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        scrollView?.contentSize = CGSize(width: frame.width, height: screenView)
        addSubview(scrollView!)
        
        partView = PartView(frame: frame, part: part)
        partView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: screenView)
        //partView?.backgroundColor = UIColor.white
        
        scrollView?.addSubview(partView!)
        
        partView?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectPartClickedHere(part: MyParts) {
        delegate?.selectPartClicked(part: part)
    }
    
    
    weak var delegate: SpecificPartPageDelegate? = nil
    
}





class PartView: UIView {
    
    private var stackView: UIStackView? = nil
    private var imageView: UIImageView? = nil
    private var _part: MyParts? = nil
    
    init(frame: CGRect, part: MyParts) {
        super.init(frame: frame)
        
        _part = part
        
        print("in PartView")
        
        
        // have a stack view
        stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        stackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        stackView?.axis = UILayoutConstraintAxis.vertical
        stackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        stackView?.isLayoutMarginsRelativeArrangement = true
        stackView?.distribution = UIStackViewDistribution.fillEqually
        stackView?.spacing = 15.0
        //stackView?.backgroundColor = UIColor.blue
        setGradientColors(viewPassed: stackView!, colors: [UIColor.white, UIColor.lightGray], gradientLocations: [0.0,0.7,1.0])
        
        addSubview(stackView!)
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
    func setGradientColors(button: UIView,colors: [UIColor], gradientLocations: [NSNumber])
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 1.9, y: 1.0, width: button.frame.width * 0.96, height: button.frame.height * 0.95)
        gradient.colors = colors.map {$0.cgColor}
        gradient.locations = gradientLocations
        button.layer.insertSublayer(gradient, at: 0)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        stackView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        
        let selectButton: UIButton = UIButton()
        selectButton.frame.size = CGSize(width: frame.width / 2, height: frame.height / 10)
        selectButton.frame.origin.x = frame.midX - frame.midX / 2 + 6
        selectButton.frame.origin.y = 10 + 6
        selectButton.layer.borderWidth = 4.5
        selectButton.layer.borderColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 1.0).cgColor
        selectButton.layer.cornerRadius = 8.0
        //selectButton.backgroundColor = UIColor.blue
        selectButton.setTitle("Select", for: .normal)
        selectButton.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        setGradientColors(button: selectButton, colors: [UIColor.gray, UIColor.darkGray], gradientLocations: [0.0,0.5,1.0])
        
        stackView?.addSubview(selectButton)
        
        
        // load the part image using helper methods
        imageView = UIImageView(frame: CGRect(x: frame.midX - frame.midX / 2, y: selectButton.frame.maxY, width: frame.width / 2, height: frame.height / 3))
        if let checkedURL = URL(string: (_part?._image)!) {
            imageView?.contentMode = .scaleAspectFit
            downloadImage(url: checkedURL)
        }
        stackView?.addSubview(imageView!)
        
        
        // DRAW price
        let priceLabel = UILabel(frame: CGRect(x: 0.0, y: (imageView?.frame.maxY)!, width: frame.width, height: 20))
        priceLabel.text = "Price:   $" + (_part?._price)!
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        priceLabel.textColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 1.0)
        priceLabel.textAlignment = .center
        stackView?.addSubview(priceLabel)
        
        
        
        // DRAW specs
        let specsTitle = UILabel(frame: CGRect(x: 10.0, y: priceLabel.frame.maxY + 20, width: frame.width, height: 20))
        specsTitle.text = "Specs:"
        specsTitle.font = UIFont.systemFont(ofSize: 18)
        stackView?.addSubview(specsTitle)
        
        var finalPosition: CGRect? = nil
        if (_part?._specs != nil || _part?._specs != "") {
            
            
            let specsDataStrings = _part?._specs?.components(separatedBy: ",")
            for i: Int in 0..<(specsDataStrings?.count)! {
                let specsDataRect = CGRect(x: specsTitle.frame.minX + 10, y: specsTitle.frame.maxY + CGFloat(i * 15), width: frame.width, height: 20)
                let specsDataLabel = UILabel(frame: specsDataRect)
                specsDataLabel.text = "• " + (specsDataStrings?[i])!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                specsDataLabel.font = UIFont.systemFont(ofSize: 10)
                stackView?.addSubview(specsDataLabel)
                finalPosition = specsDataRect
            }
        }
        
        
        let linkButton = UIButton(frame: CGRect(x: frame.midX - frame.midX / 2, y: (finalPosition?.maxY)! + 20, width: frame.width / 2, height: frame.height / 10))
        linkButton.setTitle("Newegg.com", for: .normal)
        linkButton.setTitleColor(UIColor.blue, for: .normal)
        linkButton.addTarget(self, action: #selector(linkSelected), for: .touchUpInside)
        stackView?.addSubview(linkButton)
        
    }
    
    func buttonSelected() {
        delegate?.selectPartClickedHere(part: _part!)
    }
    
    func linkSelected() {
        let url = NSURL(string: (_part?._link)!)!
        UIApplication.shared.openURL(url as URL)
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

    
    weak var delegate: PartViewDelegate? = nil
    
}
