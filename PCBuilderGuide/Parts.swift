//
//  Parts.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/10/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import Foundation


/// An interface for all of the parts to have
protocol MyParts: class {
    var _link: String { get }
    var _specs: String { get }
    var _image: String { get }
    var _price: String { get }
    var _model: String { get }
    var _socket: String { get }
    var _family: String { get }
    var _generation: String { get }
    var _description: String { get }
    var _manufacturer: String { get }
}

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
    * Get all the parts of a given category
    * EX: getAllPartsForCategory(type: "Processor") -> [i7 7700k, R7 1700, i3 6100, R5 1600x ....]
    * First level of View All
    **/
    public func getAllPartsFirstLevel(type: String) -> [MyParts] {
        var result: [MyParts] = []
        
        switch type {
        case "Processor":
            for cpu in _processors {
                result.append(cpu)
            }
            break
        default:
            // return an empty list if parameter isn't correct
            break
        }
        
        return result
    }
    
    /**
    * Get all parts of given category and manfucturer
    * manufacturer can be different based on which category
    * EX: getAllPartsSecondLevel(category: "Processor", manufacturer: "Intel") -> [i7 7700k, i5 6500, i3 6100, Pentium g4560 ....]
    * Second level of View All
    **/
    public func getAllPartsSecondLevel(type: String, category: String) -> [MyParts] {
        var result: [MyParts] = []
        
        switch type {
        case "Processor":
            for cpu in _processors {
                if (cpu._manufacturer == category) {
                    result.append(cpu)
                }
            }
            break
        default:
            break
        }
        
        return result
    }
    
    /**
        give (type: "Processor", family: "Core i5") get [i5 6600k, i5 6500, ...]
    */
    public func getPartsForCategory(type: String, family: String) -> [MyParts] {
        var result: [MyParts] = []
        
        switch type {
        case "Processor":
            for cpu in _processors {
                if (cpu.family == family) {
                    result.append(cpu)
                }
            }
            break
        default:
            // return an empty list if parameter isn't correct
            break
        }
        
        return result
    }
    
    
    /** is in use **/
    public func getListOfPartsByManufacturer(partType: String) -> [String] {
        var result: [String] = []
        
        switch partType {
        case "Processor":
            for cpu in _processors {
                if (!result.contains(cpu.manufacturer)) {
                    result.append(cpu.manufacturer)
                }
            }
            break
        default:
            // return an empty list if parameter isn't correct
            break
        }
        
        return result
    }
    
    
    /** is in use **/
    public func getFamilyPartsOfManufacturer(type: String, manufacturer: String) -> [String] {
        var result: [String] = []
        
        switch type {
        case "Processor":
            for cpu in _processors {
                if (cpu.manufacturer == manufacturer && !result.contains(cpu.family)) {
                    result.append(cpu.family)
                }
            }
        default:
            // return an empty list if parameters arent correct
            break
        }
        
        return result
    }
    
}


class CPU: MyParts {
    
    internal var _link: String
    internal var _specs: String
    internal var _price: String
    internal var _image: String
    internal var _model: String
    internal var _socket: String
    internal var _family: String
    internal var _generation: String
    internal var _description: String
    internal var _manufacturer: String
    
    
    // Create a CPU from a dictionary
    public init(dictionary: NSDictionary) {
        
        _link = dictionary.value(forKey: "Link") as! String
        _specs = dictionary.value(forKey: "Specs") as! String
        _price = dictionary.value(forKey: "Price") as! String
        _image = dictionary.value(forKey: "Image") as! String
        _model = dictionary.value(forKey: "Model") as! String
        _socket = dictionary.value(forKey: "Socket") as! String
        _family = dictionary.value(forKey: "Family") as! String
        _generation = dictionary.value(forKey: "Generation") as! String
        _description = dictionary.value(forKey: "Description") as! String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as! String
    }
    
    
    var link: String { get { return _link } }
    var specs: String { get { return _specs } }
    var price: String { get { return _price } }
    var image: String { get { return _image } }
    var model: String { get { return _model } }
    var socket: String { get { return _socket } }
    var family: String { get { return _family } }
    var generation: String { get { return _generation } }
    var description: String { get { return _description } }
    var manufacturer: String { get { return _manufacturer } }
    
}

class Motherboard {
    private var _model: String? = nil
    private var _size: String? = nil
    private var _socket: String? = nil
    private var _chipset: String? = nil
    private var _manufacturer: String? = nil
    
    
    // Create a motherboard from a dictionary
    public init(dictionary: NSDictionary) {
        _model = dictionary.value(forKey: "Model") as? String
        _size = dictionary.value(forKey: "Size") as? String
        _socket = dictionary.value(forKey: "Socket") as? String
        _chipset = dictionary.value(forKey: "Chipset") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
    }
    
    var model: String { get { return _model! } }
    var size: String { get { return _size! } }
    var socket: String { get { return _socket! } }
    var chipset: String { get { return _chipset! } }
    var manufacturer: String { get { return _manufacturer! } }
}
