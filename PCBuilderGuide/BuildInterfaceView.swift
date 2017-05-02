//
//  BuildInterfaceView.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/7/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

protocol BuildInterfaceViewDelegate: class {
    func buttonTouched(partType: String)
}


class BuildInterfaceView: UIView {
    let caseText: NSString = "Case"
    private var caseRect: CGRect = CGRect.zero
    private var caseColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var caseSelected: Bool = false
    
    let motherboardText: NSString = "Motherboard"
    private var motherboardRect: CGRect = CGRect.zero
    private var motherboardColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var motherboardSelected: Bool = false
    
    let cpuText: NSString = "CPU"
    private var cpuRect: CGRect = CGRect.zero
    private var cpuColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var cpuSelected: Bool = false
    
    let ramText: NSString = "RAM"
    private var ramRect: CGRect = CGRect.zero
    private var ramColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var ramSelected = false
    
    let gpuText: NSString = "Graphics Card"
    private var gpuRect: CGRect = CGRect.zero
    private var gpuColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var gpuSelected: Bool = false
    
    let psuText: NSString = "Power Supply"
    private var psuRect: CGRect = CGRect.zero
    private var psuColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var psuSelected: Bool = false
    
    let storageText: NSString = "Storage"
    private var storageRect: CGRect = CGRect.zero
    private var storageColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var storageSelected: Bool = false
    
    let opticalDriveText: NSString = "Optical Drive"
    private var opticalDriveRect: CGRect = CGRect.zero
    private var opticalDriveColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var opticalDriveSelected: Bool = false
    
    let coolerText: NSString = "Cooler"
    private var coolerRect: CGRect = CGRect.zero
    private var coolerColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    private var coolerSelected: Bool = false
    
    
    private var noImageBackgroundColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    
    
    let showPhotos = true
    
    private var strokeColor = UIColor(red: 82.0/255.0, green: 128.0/255.0, blue: 164.0/255.0, alpha: 1.0).cgColor
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        
        
        let dimension: CGFloat = min(bounds.width, bounds.height)

        
        // DRAW CASE BUTTON
        caseRect = CGRect.zero
        
        caseRect.size.width = dimension
        caseRect.size.height = dimension
        
        caseRect.origin.x = bounds.minX
        caseRect.origin.y = bounds.minY
        
        //var caseSelected = true
        if (caseSelected) {
            let caseImage: UIImage = UIImage(named: "CasePhoto.jpg")!
            let caseImageView: UIImageView = UIImageView(image: caseImage)
            caseImageView.frame = caseRect
            
            caseImage.draw(in: caseRect)
        }
        else {
            context.addRect(caseRect)
            context.setStrokeColor(strokeColor)
            context.setFillColor(caseColor)
            context.drawPath(using: .fillStroke)
            
            
            let caseTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: caseRect.width / 15)]
            let caseTextSize: CGSize = caseText.size(attributes: caseTextAttribute)
            //caseText.draw(at: CGPoint(x: caseRect.midX - caseTextSize.width / 2, y: caseRect.midY - caseTextSize.height / 2), withAttributes: caseTextAttribute)
            caseText.draw(at: CGPoint(x: caseRect.maxX - (caseTextSize.width * 2), y: caseRect.minY + (caseTextSize.height*4)) , withAttributes: caseTextAttribute)
        }
         
        
        // DRAW MOTHERBOARD
        motherboardRect = CGRect.zero
        
        motherboardRect.size.width = caseRect.width / 2 - caseRect.width / 11.5
        motherboardRect.size.height = caseRect.height / 2 + caseRect.height / 10
        
        motherboardRect.origin.x = caseRect.minX + caseRect.midX / 4.5
        motherboardRect.origin.y = caseRect.minY + caseRect.midY / 3.5
        
        
        //var motherboardSelected = true
        if (motherboardSelected) {
            let motherboardImage: UIImage = UIImage(named: "MotherboardPhoto.jpg")!
            let motherboardImageView: UIImageView = UIImageView(image: motherboardImage)
            motherboardImageView.frame = motherboardRect
            motherboardImage.draw(in: motherboardRect)
        }
        else {
            context.addRect(motherboardRect)
            context.setStrokeColor(strokeColor)
            context.setFillColor(motherboardColor)
            context.drawPath(using: .fillStroke)
            
            
            let motherboardTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: motherboardRect.width / 15)]
            let motherboardTextSize: CGSize = motherboardText.size(attributes: motherboardTextAttribute)
            motherboardText.draw(at: CGPoint(x: motherboardRect.minX + 5, y: motherboardRect.minY), withAttributes: motherboardTextAttribute)
        }
        
        
        
        
        // DRAW CPU
        cpuRect = CGRect.zero
        cpuRect.size.width = motherboardRect.width / 6
        cpuRect.size.height = motherboardRect.width / 6
        
        cpuRect.origin.x = motherboardRect.midX - motherboardRect.midX / 12
        cpuRect.origin.y = motherboardRect.midY - motherboardRect.midY / 2 + motherboardRect.midY / 7.5
        
        //let cpuSelected = true
        if (cpuSelected) {
            let cpuImage: UIImage = UIImage(named: "CPUPhoto.jpg")!
            let cpuImageView: UIImageView = UIImageView(image: cpuImage)
            cpuImageView.frame = cpuRect
            cpuImage.draw(in: cpuRect)
        }
        else {
            context.addRect(cpuRect)
            context.setStrokeColor(strokeColor)
            context.setFillColor(cpuColor)
            context.drawPath(using: .fillStroke)
            
            
            let cpuTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: cpuRect.width / 3)]
            let cpuSize: CGSize = cpuText.size(attributes: cpuTextAttribute)
            cpuText.draw(at: CGPoint(x: cpuRect.midX - cpuSize.width / 2, y: cpuRect.midY - cpuSize.height / 2), withAttributes: cpuTextAttribute)
        }
        
        
        
        
        // DRAW RAM
        ramRect = CGRect.zero
        ramRect.size.width = motherboardRect.width / 6
        ramRect.size.height = motherboardRect.height / 2 - motherboardRect.height / 50
        
        ramRect.origin.x = motherboardRect.midX + motherboardRect.midX / 4 + motherboardRect.midX / 20
        ramRect.origin.y = motherboardRect.minY + motherboardRect.midY / 20
        
        //let ramSelected = true
        if (ramSelected) {
            let ramImage: UIImage = UIImage(named: "RAMPhoto.jpg")!
            let ramImageView: UIImageView = UIImageView(image: ramImage)
            ramImageView.frame = ramRect
            ramImage.draw(in: ramRect)
        }
        else {
            context.addRect(ramRect)
            context.setStrokeColor(strokeColor)
            context.setFillColor(ramColor)
            context.drawPath(using: .fillStroke)
            
            let ramTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: ramRect.width / 3)]
            let ramTextSize: CGSize = ramText.size(attributes: ramTextAttribute)
            ramText.draw(at: CGPoint(x: ramRect.midX - ramTextSize.width / 2, y: ramRect.midY - ramTextSize.height / 2), withAttributes: ramTextAttribute)
        }
        
        
        
        // DRAW GRAPHICS CARD
        gpuRect = CGRect.zero
        gpuRect.size.width = motherboardRect.width + motherboardRect.width / 5
        gpuRect.size.height = motherboardRect.height / 6
        
        gpuRect.origin.x = motherboardRect.minX
        gpuRect.origin.y = motherboardRect.midY + motherboardRect.midY / 10
        
        //let gpuSelected = true
        if (gpuSelected) {
            let gpuImage: UIImage = UIImage(named: "GPUPhoto.jpg")!
            let gpuImageView: UIImageView = UIImageView(image: gpuImage)
            gpuImageView.frame = gpuRect
            gpuImage.draw(in: gpuRect)
        }
        else {
            context.addRect(gpuRect)
            context.setStrokeColor(strokeColor)
            context.setFillColor(gpuColor)
            context.drawPath(using: .fillStroke)
            
            let gpuTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: gpuRect.width / 10)]
            let gpuTextSize: CGSize = gpuText.size(attributes: gpuTextAttribute)
            gpuText.draw(at: CGPoint(x: gpuRect.midX - gpuTextSize.width / 2, y: gpuRect.midY - gpuTextSize.height / 2), withAttributes: gpuTextAttribute)
        }
        
        
        
        // DRAW POWER SUPPLY
        psuRect = CGRect.zero
        psuRect.size.width = caseRect.width / 4
        psuRect.size.height = caseRect.height / 6
        
        psuRect.origin.x = caseRect.minX + caseRect.midX / 10
        psuRect.origin.y = caseRect.maxY - psuRect.height - caseRect.midY / 10
        
        //let psuSelected = true
        if (psuSelected) {
            let psuImage: UIImage = UIImage(named: "PowerSupplyPhoto.jpg")!
            let psuImageView: UIImageView = UIImageView(image: psuImage)
            psuImageView.frame = psuRect
            psuImage.draw(in: psuRect)
        }
        else {
            context.addRect(psuRect)
            context.setStrokeColor(strokeColor)
            context.setFillColor(psuColor)
            context.drawPath(using: .fillStroke)
            
            let psuTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: psuRect.width / 8)]
            let psuTextSize: CGSize = psuText.size(attributes: psuTextAttribute)
            psuText.draw(at: CGPoint(x: psuRect.midX - psuTextSize.width / 2, y: psuRect.midY - psuTextSize.height / 2), withAttributes: psuTextAttribute)
        }
        
        
        // DRAW STORAGE
        storageRect = CGRect.zero
        storageRect.size.width = caseRect.width / 8
        storageRect.size.height = caseRect.height / 6
        
        storageRect.origin.x = caseRect.midX + caseRect.midX / 4 + caseRect.midX / 6
        storageRect.origin.y = caseRect.midY + caseRect.midY / 4
        
        //let psuSelected = true
        if (storageSelected) {
            let storageImage: UIImage = UIImage(named: "StoragePhoto.jpg")!
            let storageImageView: UIImageView = UIImageView(image: storageImage)
            storageImageView.frame = storageRect
            storageImage.draw(in: storageRect)
        }
        else {
            context.addRect(storageRect)
            context.setStrokeColor(strokeColor)
            context.setFillColor(noImageBackgroundColor)
            context.drawPath(using: .fillStroke)
            
            let storageTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: storageRect.width / 6)]
            let storageTextSize: CGSize = storageText.size(attributes: storageTextAttribute)
            storageText.draw(at: CGPoint(x: storageRect.midX - storageTextSize.width / 2, y: storageRect.midY - storageTextSize.height / 2), withAttributes: storageTextAttribute)
        }
        
        
        // DRAW Optical Drive
        opticalDriveRect = CGRect.zero
        opticalDriveRect.size.width = caseRect.width / 6
        opticalDriveRect.size.height = caseRect.height / 8
        
        opticalDriveRect.origin.x = caseRect.midX + caseRect.midX / 4 + caseRect.midX / 6
        opticalDriveRect.origin.y = caseRect.minY + caseRect.height * 0.1
        
        //let psuSelected = true
        if (opticalDriveSelected) {
            let opticalDriveImage: UIImage = UIImage(named: "OpticalDrivePhoto.jpg")!
            let opticalDriveImageView: UIImageView = UIImageView(image: opticalDriveImage)
            opticalDriveImageView.frame = opticalDriveRect
            opticalDriveImage.draw(in: opticalDriveRect)
        }
        else {
            context.addRect(opticalDriveRect)
            context.setStrokeColor(strokeColor)
            context.setFillColor(noImageBackgroundColor)
            context.drawPath(using: .fillStroke)
            
            let opticalDriveTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: opticalDriveRect.width / 6)]
            let opticalDriveTextSize: CGSize = opticalDriveText.size(attributes: opticalDriveTextAttribute)
            opticalDriveText.draw(at: CGPoint(x: opticalDriveRect.midX - opticalDriveTextSize.width / 2, y: opticalDriveRect.midY - opticalDriveTextSize.height / 2), withAttributes: opticalDriveTextAttribute)
        }
        
        
        // DRAW Cooler
        coolerRect = CGRect.zero
        if(cpuSelected)
        {
            
            coolerRect.size.width = caseRect.width / 6
            coolerRect.size.height = caseRect.height / 6
            
            coolerRect.origin.x = cpuRect.minX - coolerRect.width * 0.3
            coolerRect.origin.y = cpuRect.minY - coolerRect.height * 0.3

            //let psuSelected = true
            if (coolerSelected) {
                let coolerImage: UIImage = UIImage(named: "CoolerPhoto.jpg")!
                let coolerImageView: UIImageView = UIImageView(image: coolerImage)
                coolerImageView.frame = coolerRect
                coolerImage.draw(in: coolerRect)
            }
            else {
                context.addRect(coolerRect)
                context.setStrokeColor(strokeColor)
                context.setFillColor(noImageBackgroundColor)
                context.drawPath(using: .fillStroke)
                
                let coolerTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: coolerRect.width / 6)]
                let coolerTextSize: CGSize = coolerText.size(attributes: coolerTextAttribute)
                coolerText.draw(at: CGPoint(x: coolerRect.midX - coolerTextSize.width / 2, y: coolerRect.midY - coolerTextSize.height / 2), withAttributes: coolerTextAttribute)
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint = touch.location(in: self)
        
        let newColor = UIColor(red: 100.0/255.0, green: 128.0/255.0, blue: 160.0/255.0, alpha: 1.0).cgColor
        
        if (coolerRect.contains(touchPoint)) {
            coolerColor = newColor
            setNeedsDisplay()
        }
        else if (cpuRect.contains(touchPoint)) {
            cpuColor = newColor
            setNeedsDisplay()
        }
        else if (ramRect.contains(touchPoint)) {
            ramColor = newColor
            setNeedsDisplay()
        }
        else if (gpuRect.contains(touchPoint)) {
            gpuColor = newColor
            setNeedsDisplay()
        }
        else if (motherboardRect.contains(touchPoint)) {
            motherboardColor = newColor
            setNeedsDisplay()
        }
        else if (psuRect.contains(touchPoint)) {
            psuColor = newColor
            setNeedsDisplay()
        }
        else if (storageRect.contains(touchPoint)) {
            storageColor = newColor
            setNeedsDisplay()
        }
        else if (opticalDriveRect.contains(touchPoint)) {
            opticalDriveColor = newColor
            setNeedsDisplay()
        }
        else if (caseRect.contains(touchPoint)) {
            caseColor = newColor
            setNeedsDisplay()
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint = touch.location(in: self)
        
        
        if (coolerRect.contains(touchPoint)) {
            coolerColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: coolerText as String)
        }
        else if (cpuRect.contains(touchPoint)) {
            cpuColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: cpuText as String)
        }
        else if (ramRect.contains(touchPoint)) {
            ramColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: ramText as String)
        }
        else if (gpuRect.contains(touchPoint)) {
            gpuColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: gpuText as String)
        }
        else if (motherboardRect.contains(touchPoint)) {
            motherboardColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: motherboardText as String)
        }
        else if (psuRect.contains(touchPoint)) {
            psuColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: psuText as String)
        }
        else if (storageRect.contains(touchPoint)) {
            storageColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: storageText as String)
        }
        else if (opticalDriveRect.contains(touchPoint)) {
            opticalDriveColor = UIColor.blue.cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: opticalDriveText as String)
        }
        else if (caseRect.contains(touchPoint)) {
            caseColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
            setNeedsDisplay()
            delegate?.buttonTouched(partType: caseText as String)
        }

    }
    
    weak var delegate: BuildInterfaceViewDelegate? = nil
    
    var cpuSelectedBool: Bool {get{return cpuSelected} set{cpuSelected = newValue}}
    var gpuSelectedBool: Bool {get{return gpuSelected} set{gpuSelected = newValue}}
    var ramSelectedBool: Bool {get{return ramSelected} set{ramSelected = newValue}}
    var psuSelectedBool: Bool {get{return psuSelected} set{psuSelected = newValue}}
    var motherboardSelectedBool: Bool {get{return motherboardSelected} set{motherboardSelected = newValue}}
    var storageSelectedBool: Bool {get{return storageSelected} set{storageSelected = newValue}}
    var caseSelectedBool: Bool {get{return caseSelected} set{caseSelected = newValue}}
    var coolerSelectedBool: Bool {get{return coolerSelected} set{coolerSelected = newValue}}
    var opticalDriveSelectedBool: Bool {get{return opticalDriveSelected} set{opticalDriveSelected = newValue}}

    
}
