//
//  Parts.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/10/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import Foundation

class Parts {
    
    private var parts = [NSDictionary]()
    
    /// Load data
    public init(dictionary: NSDictionary) {
        let processors: [AnyObject] = dictionary.value(forKey: "Processors") as! [AnyObject]
        
        //parts[0] = ["Processors": [CPU]()]
        
        for cpu in processors {
            let cpu1: NSDictionary = cpu as! NSDictionary
            
            //(parts[0] as AnyObject).append(CPU(dictionary: cpu1))
            //parts.first.append(CPU(dictionary: cpu1))
            //parts[0].addCpu(CPU(dictionary: cpu1))
            //parts[0].value(forKey: "Processors").append(CPU(dictionary: cpu1))
            let cpu = CPU(dictionary: cpu1)
        }
    }
    
}

protocol MyType {
}

// MARK: - Processors
class Processors: MyType {
    public var processors: [CPU] = []
    
    public func addCpu(cpu: CPU) {
        processors.append(cpu)
    }
}
class CPU: MyType {
    private var _name: String? = nil
    private var _link: String? = nil
    private var _specs: String? = nil
    private var _socket: String? = nil
    private var _description: String? = nil
    private var _manufacturer: String? = nil
    
    
    public init(dictionary: NSDictionary) {
        _name = dictionary.value(forKey: "Name") as! String
        _link = dictionary.value(forKey: "Link") as! String
        _specs = dictionary.value(forKey: "Specs") as! String
        _socket = dictionary.value(forKey: "Socket") as! String
        _description = dictionary.value(forKey: "Description") as! String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as! String
    }
    
    
}


// MARK: - Motherboards
class Motherboards: MyType {
    private var boards: [Motherboard] = []
}
class Motherboard {
    private var name: String? = nil
    private var manufacturer: String? = nil
}
