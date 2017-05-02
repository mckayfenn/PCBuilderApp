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
        scrollView?.contentSize = CGSize(width: frame.width, height: screenView * 1.25)
        addSubview(scrollView!)
        
        partView = PartView(frame: frame, part: part)
        partView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: screenView * 1.25)
        
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
        
        // have a stack view
        stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 1.25))
        stackView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        stackView?.axis = UILayoutConstraintAxis.vertical
        stackView?.layoutMargins = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
        stackView?.isLayoutMarginsRelativeArrangement = true
        stackView?.distribution = UIStackViewDistribution.fillEqually
        stackView?.spacing = 15.0
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
        gradient.frame = CGRect(x: 3, y: 1.5, width: button.frame.width * 0.96, height: button.frame.height * 0.95)
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
        selectButton.frame.origin.x = frame.midX - frame.midX / 2
        selectButton.frame.origin.y = 10
        selectButton.layer.borderWidth = 4.5
        selectButton.layer.borderColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 1.0).cgColor
        selectButton.layer.cornerRadius = 8.0
        selectButton.setTitle("Select", for: .normal)
        selectButton.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        setGradientColors(button: selectButton, colors: [UIColor.gray, UIColor.darkGray], gradientLocations: [0.0,0.5,1.0])
        
        stackView?.addSubview(selectButton)
        
        var finalPosition: CGRect = selectButton.frame
        
        
        // load the part image using helper methods
        if (_part?._image != nil && _part?._image != "") {
            imageView = UIImageView(frame: CGRect(x: frame.midX - frame.midX / 2, y: selectButton.frame.maxY, width: frame.width / 2, height: frame.height / 3))
            if let checkedURL = URL(string: (_part?._image)!) {
                imageView?.contentMode = .scaleAspectFit
                downloadImage(url: checkedURL)
            }
            stackView?.addSubview(imageView!)
            finalPosition = (imageView?.frame)!
        }
        
        
        // DRAW price
        let priceLabel = UILabel(frame: CGRect(x: 0.0, y: finalPosition.maxY + 10, width: frame.width, height: 20))
        if (_part?._price != nil && _part?._price != "") {
            
            priceLabel.text = "Price:   $" + (_part?._price)!
            priceLabel.font = UIFont.systemFont(ofSize: 20)
            priceLabel.textColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 1.0)
            priceLabel.textAlignment = .center
            stackView?.addSubview(priceLabel)
            finalPosition = priceLabel.frame
        }
        
        
        
        // DRAW specs
        if (_part?._specs != nil && _part?._specs != "") {
            
            let specsTitle = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            specsTitle.text = "Specs:"
            specsTitle.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(specsTitle)
            
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
        
        // DRAW socket
        if (_part?._socket != nil && _part?._socket != "" && type(of: _part).self != CPU.self) {
            let socketTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 10, width: frame.width, height: 20))
            socketTitleLabel.text = "Socket"
            socketTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(socketTitleLabel)
            finalPosition = socketTitleLabel.frame
            
            let socketLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            socketLabel.text = "• " + (_part?._socket)!
            socketLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(socketLabel)
            finalPosition = socketLabel.frame
        }
        
        // DRAW chipset
        if (_part?._chipset != nil && _part?._chipset != "") {
            let chipsetTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            chipsetTitleLabel.text = "Chipset"
            chipsetTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(chipsetTitleLabel)
            finalPosition = chipsetTitleLabel.frame
            
            let chipsetLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            chipsetLabel.text = "• " + (_part?._chipset)!
            chipsetLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(chipsetLabel)
            finalPosition = chipsetLabel.frame
        }
        
        // DRAW RAM Type
        if (_part?._ram != nil && _part?._ram != "") {
            let propertyTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            propertyTitleLabel.text = "RAM Type"
            propertyTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(propertyTitleLabel)
            finalPosition = propertyTitleLabel.frame
            
            let propertyLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            propertyLabel.text = "• " + (_part?._ram)!
            propertyLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(propertyLabel)
            finalPosition = propertyLabel.frame
        }
        
        // DRAW size
        if (_part?._size != nil && _part?._size != "") {
            let propertyTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            propertyTitleLabel.text = "Size"
            propertyTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(propertyTitleLabel)
            finalPosition = propertyTitleLabel.frame
            
            let propertyLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            propertyLabel.text = "• " + (_part?._size)!
            propertyLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(propertyLabel)
            finalPosition = propertyLabel.frame
        }
        
        
        // DRAW speed
        if (_part?._speed != nil && _part?._speed != "") {
            let propertyTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            propertyTitleLabel.text = "Speed"
            propertyTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(propertyTitleLabel)
            finalPosition = propertyTitleLabel.frame
            
            let propertyLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            propertyLabel.text = "• " + (_part?._speed)!
            propertyLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(propertyLabel)
            finalPosition = propertyLabel.frame
        }
        
        // DRAW Series
        if (_part?._series != nil && _part?._series != "") {
            let propertyTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            propertyTitleLabel.text = "Series / Family"
            propertyTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(propertyTitleLabel)
            finalPosition = propertyTitleLabel.frame
            
            let propertyLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            propertyLabel.text = "• " + (_part?._series)!
            propertyLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(propertyLabel)
            finalPosition = propertyLabel.frame
        }
        
        // DRAW VRAM
        if (_part?._vram != nil && _part?._vram != "") {
            let propertyTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            propertyTitleLabel.text = "VRAM"
            propertyTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(propertyTitleLabel)
            finalPosition = propertyTitleLabel.frame
            
            let propertyLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            propertyLabel.text = "• " + (_part?._vram)!
            propertyLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(propertyLabel)
            finalPosition = propertyLabel.frame
        }
        
        // DRAW Wattage
        if (_part?._wattage != nil && _part?._wattage != "") {
            let propertyTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            propertyTitleLabel.text = "Wattage"
            propertyTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(propertyTitleLabel)
            finalPosition = propertyTitleLabel.frame
            
            let propertyLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            propertyLabel.text = "• " + (_part?._wattage)!
            propertyLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(propertyLabel)
            finalPosition = propertyLabel.frame
        }
        
        // DRAW Efficiency
        if (_part?._efficiency != nil && _part?._efficiency != "") {
            let propertyTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            propertyTitleLabel.text = "Efficiency"
            propertyTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(propertyTitleLabel)
            finalPosition = propertyTitleLabel.frame
            
            let propertyLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            propertyLabel.text = "• " + (_part?._efficiency)!
            propertyLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(propertyLabel)
            finalPosition = propertyLabel.frame
        }
        
        // DRAW Modular
        if (_part?._modular != nil && _part?._modular != "") {
            let propertyTitleLabel = UILabel(frame: CGRect(x: 10.0, y: finalPosition.maxY + 20, width: frame.width, height: 20))
            propertyTitleLabel.text = "Modular"
            propertyTitleLabel.font = UIFont.systemFont(ofSize: 18)
            stackView?.addSubview(propertyTitleLabel)
            finalPosition = propertyTitleLabel.frame
            
            let propertyLabel = UILabel(frame: CGRect(x: finalPosition.minX + 10, y: finalPosition.maxY + 5, width: frame.width, height: 10))
            propertyLabel.text = "• " + (_part?._modular)!
            propertyLabel.font = UIFont.systemFont(ofSize: 10)
            stackView?.addSubview(propertyLabel)
            finalPosition = propertyLabel.frame
        }
        
        let linkButton = UIButton(frame: CGRect(x: frame.midX - frame.midX / 2, y: finalPosition.maxY + 20, width: frame.width / 2, height: frame.height / 10))
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
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                self.imageView?.image = UIImage(data: data)
            }
        }
    }
    
    
    weak var delegate: PartViewDelegate? = nil
    
}
