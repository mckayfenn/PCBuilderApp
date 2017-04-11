//
//  Parts.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/10/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import Foundation

class Parts {
    
    // Just have a list of each type of parts
    private var _processors: [CPU] = []
    private var _motherboards: [Motherboard] = []
    
    var processors: [CPU] { get { return _processors } }
    var motherboards: [Motherboard] { get { return _motherboards } }
    
    /// Load data
    public init(dictionary: NSDictionary) {
        let processors: [AnyObject] = dictionary.value(forKey: "Processors") as! [AnyObject]
        for cpu in processors {
            let cpu1: NSDictionary = cpu as! NSDictionary
            _processors.append(CPU(dictionary: cpu1))
        }
        
        let motherboards: [AnyObject] = dictionary.value(forKey: "Motherboards") as! [AnyObject]
        for motherboard in motherboards {
            let mobo: NSDictionary = motherboard as! NSDictionary
            _motherboards.append(Motherboard(dictionary: mobo))
        }
        
        print("jsonData has been processed")
    }
    
    
    /**
        Returns a specified list of parts with only names
        Give the parameter a part type
        Example: getListOfPartsByName("Processor") will return
        ["i7 7700k", "R7 1700x", .... ]
     
        Parameter must match one of these:
        "Processor", "Motherboard"
    */
    public func getListOfPartsByName(partType: String) -> [String] {
        var result: [String] = []
        
        switch partType {
            case "Processor":
                for cpu in _processors {
                    result.append(cpu.name)
                }
                break
            case "Motherboard":
                for mobo in _motherboards {
                    result.append(mobo.name)
                }
                break
            default:
                // return an empty list if parameter wasnt correct
                break
        }
    
        return result
    }
    
    
    public func getListOfPartsByFamily(partType: String) -> [String] {
        var result: [String] = []
        
        switch partType {
        case "Processor":
            for cpu in _processors {
                if (!result.contains(cpu.family)) {
                    result.append(cpu.family)
                }
            }
            break
        case "Motherboard":
            for mobo in _motherboards {
                result.append(mobo.name) // THIS IS WRONG RIGHT NOW
            }
            break
        default:
            // return an empty list if parameter wasnt correct
            break
        }
        
        return result.sorted()
    }
    
    
    /**
        Return a list of compatible parts (NAMES) to a given part.
        partType is the list of parts you want.
        compatibleTo is the part you have that you want parts compatible to.
     
        Example: cpu = R7 1700
        getCompatiblePartsTo(partType: "Motherboard", compatibleTo: cpu) will return
        ["Asus Prime X370", .... ]
    */
    public func getCompatiblePartsTo(partType: String, compatibleTo: AnyObject) -> [String] {
        var result: [String] = []
        
        
        // Switch on which part they passed us
        switch compatibleTo {
        case is CPU:
            let part: CPU = compatibleTo as! CPU
            
            
            // Switch on which part they are wanting
            switch partType {
            case "Motherboard":
                for mobo in _motherboards {
                    if (mobo.socket == part.socket) {
                        result.append(mobo.name)
                    }
                }
                break
            default:
                // nothing
                break
            }
            
            
            
        default:
            // return an empty list if parameters arent correct
            break
        }
        
        return result
    }
    
    
}


class CPU {
    private var _name: String? = nil
    private var _link: String? = nil
    private var _specs: String? = nil
    private var _price: String? = nil
    private var _socket: String? = nil
    private var _family: String? = nil
    private var _generation: String? = nil
    private var _description: String? = nil
    private var _manufacturer: String? = nil
    
    
    // Create a CPU from a dictionary
    public init(dictionary: NSDictionary) {
        _name = dictionary.value(forKey: "Name") as? String
        _link = dictionary.value(forKey: "Link") as? String
        _specs = dictionary.value(forKey: "Specs") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _socket = dictionary.value(forKey: "Socket") as? String
        _family = dictionary.value(forKey: "Family") as? String
        _generation = dictionary.value(forKey: "Generation") as? String
        _description = dictionary.value(forKey: "Description") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
    }
    
    var name: String { get { return _name! } }
    var link: String { get { return _link! } }
    var specs: String { get { return _specs! } }
    var price: String { get { return _price! } }
    var socket: String { get { return _socket! } }
    var family: String { get { return _family! } }
    var generation: String { get { return _generation! } }
    var description: String { get { return _description! } }
    var manufacturer: String { get { return _manufacturer! } }
    
}

class Motherboard {
    private var _name: String? = nil
    private var _size: String? = nil
    private var _socket: String? = nil
    private var _chipset: String? = nil
    private var _manufacturer: String? = nil
    
    
    // Create a motherboard from a dictionary
    public init(dictionary: NSDictionary) {
        _name = dictionary.value(forKey: "Name") as? String
        _size = dictionary.value(forKey: "Size") as? String
        _socket = dictionary.value(forKey: "Socket") as? String
        _chipset = dictionary.value(forKey: "Chipset") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
    }
    
    var name: String { get { return _name! } }
    var size: String { get { return _size! } }
    var socket: String { get { return _socket! } }
    var chipset: String { get { return _chipset! } }
    var manufacturer: String { get { return _manufacturer! } }
}
