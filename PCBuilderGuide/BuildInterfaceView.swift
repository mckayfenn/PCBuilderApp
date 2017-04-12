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
    private var caseColor: CGColor = UIColor.blue.cgColor
    
    let motherboardText: NSString = "Motherboard"
    private var motherboardRect: CGRect = CGRect.zero
    private var motherboardColor: CGColor = UIColor.blue.cgColor
    
    let cpuText: NSString = "CPU"
    private var cpuRect: CGRect = CGRect.zero
    private var cpuColor: CGColor = UIColor.blue.cgColor
    
    let ramText: NSString = "RAM"
    private var ramRect: CGRect = CGRect.zero
    private var ramColor: CGColor = UIColor.blue.cgColor
    
    let gpuText: NSString = "Graphics Card"
    private var gpuRect: CGRect = CGRect.zero
    private var gpuColor: CGColor = UIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.7).cgColor
    
    let psuText: NSString = "Power Supply"
    private var psuRect: CGRect = CGRect.zero
    private var psuColor: CGColor = UIColor.blue.cgColor
    
    
    let showPhotos = false
    
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
        if (showPhotos) {
            let caseImage: UIImage = UIImage(named: "CasePhoto.jpg")!
            let caseImageView: UIImageView = UIImageView(image: caseImage)
            caseImageView.frame = caseRect
            
            caseImage.draw(in: caseRect)
        }
        else {
            context.addRect(caseRect)
            context.setStrokeColor(caseColor)
            context.setFillColor(UIColor.clear.cgColor)
            context.drawPath(using: .fillStroke)
            
            
            let caseTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: caseRect.width / 15)]
            let caseTextSize: CGSize = caseText.size(attributes: caseTextAttribute)
            //caseText.draw(at: CGPoint(x: caseRect.midX - caseTextSize.width / 2, y: caseRect.midY - caseTextSize.height / 2), withAttributes: caseTextAttribute)
            caseText.draw(at: CGPoint(x: caseRect.maxX - caseTextSize.width, y: caseRect.maxY - caseTextSize.height) , withAttributes: caseTextAttribute)
        }
        
        
        
        
        // DRAW MOTHERBOARD
        motherboardRect = CGRect.zero
        
        motherboardRect.size.width = caseRect.width / 2 - 25
        motherboardRect.size.height = caseRect.height - caseRect.height / 3 - 25
        
        motherboardRect.origin.x = caseRect.minX + 35
        motherboardRect.origin.y = caseRect.minY + 45
        
        
        //var motherboardSelected = true
        if (showPhotos) {
            let motherboardImage: UIImage = UIImage(named: "MotherboardPhoto.jpg")!
            let motherboardImageView: UIImageView = UIImageView(image: motherboardImage)
            motherboardImageView.frame = motherboardRect
            motherboardImage.draw(in: motherboardRect)
        }
        else {
            context.addRect(motherboardRect)
            context.setStrokeColor(motherboardColor)
            //context.setFillColor(UIColor.clear.cgColor)
            //context.setFillColor(motherboardColor)
            context.drawPath(using: .stroke)
            
            
            let motherboardTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: motherboardRect.width / 15)]
            let motherboardTextSize: CGSize = motherboardText.size(attributes: motherboardTextAttribute)
            motherboardText.draw(at: CGPoint(x: motherboardRect.minX + 5, y: motherboardRect.minY), withAttributes: motherboardTextAttribute)
        }
        
        
        
        
        // DRAW CPU
        cpuRect = CGRect.zero
        cpuRect.size.width = motherboardRect.width / 5
        cpuRect.size.height = motherboardRect.width / 5
        
        cpuRect.origin.x = motherboardRect.midX - 10
        cpuRect.origin.y = motherboardRect.midY - motherboardRect.midY / 3 - 10
        
        //let cpuSelected = true
        if (showPhotos) {
            let cpuImage: UIImage = UIImage(named: "CPUPhoto.jpg")!
            let cpuImageView: UIImageView = UIImageView(image: cpuImage)
            cpuImageView.frame = cpuRect
            cpuImage.draw(in: cpuRect)
        }
        else {
            context.addRect(cpuRect)
            context.setStrokeColor(cpuColor)
            context.setFillColor(UIColor.clear.cgColor)
            context.drawPath(using: .fillStroke)
            
            
            let cpuTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: cpuRect.width / 3)]
            let cpuSize: CGSize = cpuText.size(attributes: cpuTextAttribute)
            cpuText.draw(at: CGPoint(x: cpuRect.midX - cpuSize.width / 2, y: cpuRect.midY - cpuSize.height / 2), withAttributes: cpuTextAttribute)
        }
        
        
        
        
        // DRAW RAM
        ramRect = CGRect.zero
        ramRect.size.width = motherboardRect.width / 6
        ramRect.size.height = motherboardRect.height / 2 - 5
        
        ramRect.origin.x = motherboardRect.midX + motherboardRect.midX / 4 + 5
        ramRect.origin.y = motherboardRect.midY - motherboardRect.midY / 2 - 20
        
        //let ramSelected = true
        if (showPhotos) {
            let ramImage: UIImage = UIImage(named: "RAMPhoto.jpg")!
            let ramImageView: UIImageView = UIImageView(image: ramImage)
            ramImageView.frame = ramRect
            ramImage.draw(in: ramRect)
        }
        else {
            context.addRect(ramRect)
            context.setStrokeColor(ramColor)
            context.drawPath(using: .stroke)
            
            let ramTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: ramRect.width / 3)]
            let ramTextSize: CGSize = ramText.size(attributes: ramTextAttribute)
            ramText.draw(at: CGPoint(x: ramRect.midX - ramTextSize.width / 2, y: ramRect.midY - ramTextSize.height / 2), withAttributes: ramTextAttribute)
        }
        
        
        
        // DRAW GRAPHICS CARD
        gpuRect = CGRect.zero
        gpuRect.size.width = caseRect.width / 2
        gpuRect.size.height = motherboardRect.height / 6
        
        gpuRect.origin.x = motherboardRect.minX
        gpuRect.origin.y = motherboardRect.midY + 10
        
        //let gpuSelected = true
        if (showPhotos) {
            let gpuImage: UIImage = UIImage(named: "GPUPhoto.jpg")!
            let gpuImageView: UIImageView = UIImageView(image: gpuImage)
            gpuImageView.frame = gpuRect
            gpuImage.draw(in: gpuRect)
        }
        else {
            context.addRect(gpuRect)
            context.setStrokeColor(UIColor.blue.cgColor)
            context.setFillColor(gpuColor)
            context.drawPath(using: .fillStroke)
            
            let gpuTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: gpuRect.width / 10)]
            let gpuTextSize: CGSize = gpuText.size(attributes: gpuTextAttribute)
            gpuText.draw(at: CGPoint(x: gpuRect.midX - gpuTextSize.width / 2, y: gpuRect.midY - gpuTextSize.height / 2), withAttributes: gpuTextAttribute)
        }
        
        
        
        // DRAW POWER SUPPLY
        psuRect = CGRect.zero
        psuRect.size.width = caseRect.width / 4
        psuRect.size.height = caseRect.height / 5
        
        psuRect.origin.x = caseRect.minX + 20
        psuRect.origin.y = caseRect.maxY - psuRect.height - 10
        
        //let psuSelected = true
        if (showPhotos) {
            let psuImage: UIImage = UIImage(named: "PowerSupplyPhoto.jpg")!
            let psuImageView: UIImageView = UIImageView(image: psuImage)
            psuImageView.frame = psuRect
            psuImage.draw(in: psuRect)
        }
        else {
            context.addRect(psuRect)
            context.setStrokeColor(psuColor)
            context.setFillColor(UIColor.clear.cgColor)
            context.drawPath(using: .fillStroke)
            
            let psuTextAttribute: [String:Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: psuRect.width / 8)]
            let psuTextSize: CGSize = psuText.size(attributes: psuTextAttribute)
            psuText.draw(at: CGPoint(x: psuRect.midX - psuTextSize.width / 2, y: psuRect.midY - psuTextSize.height / 2), withAttributes: psuTextAttribute)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cpuColor = UIColor.cyan.cgColor
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let touchPoint = touch.location(in: self)
        cpuColor = UIColor.blue.cgColor
        setNeedsDisplay()
        
        if (cpuRect.contains(touchPoint)) {
            delegate?.buttonTouched(partType: cpuText as String)
        }
        else if (motherboardRect.contains(touchPoint)) {
            delegate?.buttonTouched(partType: motherboardText as String)
        }
    }
    
    weak var delegate: BuildInterfaceViewDelegate? = nil
    
}
