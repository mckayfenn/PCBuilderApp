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
    var _ram: String? { get }
    var _vram: String? { get }
    var _link: String? { get }
    var _size: String? { get }
    var _color: String? { get }
    var _specs: String? { get }
    var _image: String? { get }
    var _price: String? { get }
    var _brand: String? { get }
    var _model: String? { get }
    var _speed: String? { get }
    var _class: String? { get }
    var _series: String? { get }
    var _socket: String? { get }
    var _family: String? { get }
    var _modular: String? { get }
    var _chipset: String? { get }
    var _wattage: String? { get }
    var _efficiency: String? { get }
    var _generation: String? { get }
    var _description: String? { get }
    var _manufacturer: String? { get }
    
    var _isCustom: Bool? { get }
}

class Parts {
    
    // Just have a list of each type of parts
    private var _processors: [CPU] = []
    private var _motherboards: [Motherboard] = []
    private var _rams: [RAM] = []
    private var _gpus: [GPU] = []
    private var _cases: [Case] = []
    private var _psus: [PSU] = []
    private var _coolers: [Cooler] = []
    private var _storages: [Storage] = []
    private var _opticalDrives: [OpticalDrive] = []
    
    var processors: [CPU] { get { return _processors } }
    var motherboards: [Motherboard] { get { return _motherboards } }
    var rams: [RAM] { get { return _rams } }
    var gpus: [GPU] { get { return _gpus } }
    var cases: [Case] { get { return _cases } }
    var psus: [PSU] { get { return _psus } }
    var coolers: [Cooler] { get { return _coolers } }
    var storages: [Storage] { get { return _storages } }
    var opticalDrives: [OpticalDrive] { get { return _opticalDrives } }
    
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
        
        let rams: [AnyObject] = dictionary.value(forKey: "RAM") as! [AnyObject]
        for ramSet in rams {
            let ram: NSDictionary = ramSet as! NSDictionary
            _rams.append(RAM(dictionary: ram))
        }
        
        let videoCards: [AnyObject] = dictionary.value(forKey: "GPU") as! [AnyObject]
        for card in videoCards {
            let gpu: NSDictionary = card as! NSDictionary
            _gpus.append(GPU(dictionary: gpu))
        }
        
        let cases: [AnyObject] = dictionary.value(forKey: "Case") as! [AnyObject]
        for tower in cases {
            _cases.append(Case(dictionary: tower as! NSDictionary))
        }
        
        let psus: [AnyObject] = dictionary.value(forKey: "PSU") as! [AnyObject]
        for psu in psus {
            _psus.append(PSU(dictionary: psu as! NSDictionary))
        }
        
        let coolers: [AnyObject] = dictionary.value(forKey: "Cooler") as! [AnyObject]
        for cooler in coolers {
            _coolers.append(Cooler(dictionary: cooler as! NSDictionary))
        }
        
        let storages: [AnyObject] = dictionary.value(forKey: "Storage") as! [AnyObject]
        for drive in storages {
            _storages.append(Storage(dictionary: drive as! NSDictionary))
        }
        
        let opticalDrives: [AnyObject] = dictionary.value(forKey: "Optical Drive") as! [AnyObject]
        for drive in opticalDrives {
            _opticalDrives.append(OpticalDrive(dictionary: drive as! NSDictionary))
        }
        
        
        
        print("jsonData has been processed")
    }
    
    
    
    public func addCustomPart(part: MyParts) {
        switch part.self {
        case is CPU:
            var contains: Bool = false
            for cpu: CPU in _processors {
                
                // only add unique parts
                if (cpu === part as! CPU) {
                    contains = true
                    break
                }
            }
            
            if (!contains) {
                _processors.append(part as! CPU)
            }
            break
        default:
            break
        }
    }
    
    
    public func isPartCompatibleTo(currentParts: [MyParts], thisPart: MyParts) -> Bool {
        
        // switch on which part they are trying to select
        switch thisPart {
        case is CPU:
            for part in currentParts {
                
                // switch on the parts they already have
                switch part {
                case is Motherboard:
                    if (part._socket != thisPart._socket) {
                        return false
                    }
                case is RAM:
                    if (part._ram != thisPart._ram) {
                        return false
                    }
                default:
                    break
                }
            }
            break
        case is Motherboard:
            for part in currentParts {
                
                // switch on the parts they already have
                switch part {
                case is CPU:
                    if (part._socket != thisPart._socket) {
                        return false
                    }
                case is RAM:
                    if (part._ram != thisPart._ram) {
                        return false
                    }
                default:
                    break
                }
            }
        case is RAM:
            for part in currentParts {
                
                // switch on the parts they already have
                switch part {
                case is CPU:
                    if (part._ram != thisPart._ram) {
                        return false
                    }
                case is Motherboard:
                    if (part._ram != thisPart._ram) {
                        return false
                    }
                default:
                    break
                }
            }
        default:
            break
        }
        
        return true;
    }
    
    /**
     * Get all the parts of a given category
     * EX: getAllPartsForCategory(type: "Processor") -> [i7 7700k, R7 1700, i3 6100, R5 1600x ....]
     * First level of View All
     **/
    public func getAllPartsFirstLevel(type: String) -> [MyParts] {
        var result: [MyParts] = []
        
        switch type {
        case "CPU":
            for cpu in _processors {
                result.append(cpu)
            }
            break
        case "Motherboard":
            for mobo in _motherboards {
                result.append(mobo)
            }
            break
        case "RAM":
            for ram in _rams {
                result.append(ram)
            }
            break
        case "Graphics Card":
            for gpu in _gpus {
                result.append(gpu)
            }
            break
        case "Case":
            for tower in _cases {
                result.append(tower)
            }
            break
        case "Power Supply":
            for psu in _psus {
                result.append(psu)
            }
            break
        case "Cooler":
            for cooler in _coolers {
                result.append(cooler)
            }
            break
        case "Storage":
            for drive in _storages {
                result.append(drive)
            }
            break
        case "Optical Drive":
            for drive in _opticalDrives {
                result.append(drive)
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
    public func getAllPartsSecondLevel(type: String, firstLevelSelection: String) -> [MyParts] {
        var result: [MyParts] = []
        
        switch type {
        case "CPU":
            for cpu in _processors {
                if (cpu._manufacturer == firstLevelSelection) {
                    result.append(cpu)
                }
            }
            break
        case "Motherboard":
            for mobo in _motherboards {
                if (mobo._socket == firstLevelSelection) {
                    result.append(mobo)
                }
            }
            break
        case "RAM":
            for ram in _rams {
                if (ram._ram == firstLevelSelection) {
                    result.append(ram)
                }
            }
            break
        case "Graphics Card":
            for gpu in _gpus {
                if (gpu._manufacturer == firstLevelSelection) {
                    result.append(gpu)
                }
            }
            break
        case "Case":
            for tower in _cases {
                if (tower._manufacturer == firstLevelSelection) {
                    result.append(tower)
                }
            }
            break
        case "Power Supply":
            for psu in _psus {
                if (psu._efficiency == firstLevelSelection) {
                    result.append(psu)
                }
            }
            break
        case "Cooler":
            for cooler in _coolers {
                if (cooler._class == firstLevelSelection) {
                    result.append(cooler)
                }
            }
            break
        case "Storage":
            for drive in _storages {
                if (drive._class == firstLevelSelection) {
                    result.append(drive)
                }
            }
            break
        case "Optical Drive":
            for drive in _opticalDrives {
                if (drive._class == firstLevelSelection) {
                    result.append(drive)
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
    public func getPartsForCategory(type: String, secondLevelSelection: String) -> [MyParts] {
        var result: [MyParts] = []
        
        switch type {
        case "CPU":
            for cpu in _processors {
                if (cpu.family == secondLevelSelection) {
                    result.append(cpu)
                }
            }
            break
        case "Motherboard":
            for mobo in _motherboards {
                if (mobo._manufacturer == secondLevelSelection) {
                    result.append(mobo)
                }
            }
            break
        case "RAM":
            for ram in _rams {
                if (ram._speed == secondLevelSelection) {
                    result.append(ram)
                }
            }
            break
        case "Graphics Card":
            for gpu in _gpus {
                if (gpu._series == secondLevelSelection) {
                    result.append(gpu)
                }
            }
            break
        case "Case":
            for tower in _cases {
                if (tower._size == secondLevelSelection) {
                    result.append(tower)
                }
            }
            break
        case "Power Supply":
            for psu in _psus {
                if (psu._wattage == secondLevelSelection) {
                    result.append(psu)
                }
            }
            break
        case "Cooler":
            for cooler in _coolers {
                if (cooler._manufacturer == secondLevelSelection) {
                    result.append(cooler)
                }
            }
            break
        case "Storage":
            for drive in _storages {
                if (drive._size == secondLevelSelection) {
                    result.append(drive)
                }
            }
        case "Optical Drive":
            for drive in _opticalDrives {
                if (drive._manufacturer == secondLevelSelection) {
                    result.append(drive)
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
    public func getFirstLevelParts(partType: String) -> [String] {
        var result: [String] = []
        
        switch partType {
        case "CPU":
            for cpu in _processors {
                if (!result.contains(cpu._manufacturer!)) {
                    result.append(cpu._manufacturer!)
                }
            }
            break
        case "Motherboard":
            for mobo in _motherboards {
                if (!result.contains(mobo._socket!)) {
                    result.append(mobo._socket!)
                }
            }
            break
        case "RAM":
            for ram in _rams {
                if (!result.contains(ram._ram!)) {
                    result.append(ram._ram!)
                }
            }
            break
        case "Graphics Card":
            for gpu in _gpus {
                if (!result.contains(gpu._manufacturer!)) {
                    result.append(gpu._manufacturer!)
                }
            }
            break
        case "Case":
            for tower in _cases {
                if (!result.contains(tower._manufacturer!)) {
                    result.append(tower._manufacturer!)
                }
            }
            break
        case "Power Supply":
            for psu in _psus {
                if (!result.contains(psu._efficiency!)) {
                    result.append(psu._efficiency!)
                }
            }
            break
        case "Cooler":
            for cooler in _coolers {
                if (!result.contains(cooler._class!)) {
                    result.append(cooler._class!)
                }
            }
            break
        case "Storage":
            for drive in _storages {
                if (!result.contains(drive._class!)) {
                    result.append(drive._class!)
                }
            }
            break
        case "Optical Drive":
            for drive in _opticalDrives {
                if (!result.contains(drive._class!)) {
                    result.append(drive._class!)
                }
            }
        default:
            // return an empty list if parameter isn't correct
            break
        }
        
        return result.sorted()
    }
    
    
    /** is in use **/
    public func getSecondLevelParts(type: String, firstLevelSelection: String) -> [String] {
        var result: [String] = []
        
        switch type {
        case "CPU":
            for cpu in _processors {
                if (cpu._manufacturer == firstLevelSelection && !result.contains(cpu.family)) {
                    result.append(cpu.family)
                }
            }
            break
        case "Motherboard":
            for mobo in _motherboards {
                if (mobo._socket == firstLevelSelection && !result.contains(mobo._manufacturer!)) {
                    result.append(mobo._manufacturer!)
                }
            }
            break
        case "RAM":
            for ram in _rams {
                if (ram._ram == firstLevelSelection && !result.contains(ram._speed!)) {
                    result.append(ram._speed!)
                }
            }
            break
        case "Graphics Card":
            for gpu in _gpus {
                if (gpu._manufacturer == firstLevelSelection && !result.contains(gpu._series!)) {
                    result.append(gpu._series!)
                }
            }
            break
        case "Case":
            for tower in _cases {
                if (tower._manufacturer == firstLevelSelection && !result.contains(tower._size!)) {
                    result.append(tower._size!)
                }
            }
            break
        case "Power Supply":
            for psu in _psus {
                if (psu._efficiency == firstLevelSelection && !result.contains(psu._wattage!)) {
                    result.append(psu._wattage!)
                }
            }
            break
        case "Cooler":
            for cooler in _coolers {
                if (cooler._class == firstLevelSelection && !result.contains(cooler._manufacturer!)) {
                    result.append(cooler._manufacturer!)
                }
            }
            break
        case "Storage":
            for drive in _storages {
                if (drive._class == firstLevelSelection && !result.contains(drive._size!)) {
                    result.append(drive._size!)
                }
            }
            break
        case "Optical Drive":
            for drive in _opticalDrives {
                if (drive._class == firstLevelSelection && !result.contains(drive._manufacturer!)) {
                    result.append(drive._manufacturer!)
                }
            }
        default:
            // return an empty list if parameters arent correct
            break
        }
        
        return result.sorted()
    }
    
}


class CPU: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a CPU from a dictionary
    public init(dictionary: NSDictionary) {
        
        _ram = dictionary.value(forKey: "RAM") as? String
        _link = dictionary.value(forKey: "Link") as? String
        _specs = dictionary.value(forKey: "Specs") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _socket = dictionary.value(forKey: "Socket") as? String
        _family = dictionary.value(forKey: "Family") as? String
        _generation = dictionary.value(forKey: "Generation") as? String
        _description = dictionary.value(forKey: "Description") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        //var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["RAM"] = _ram
        partAttributes["Link"] = _link
        partAttributes["Specs"] = _specs
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Model"] = _model
        partAttributes["Socket"] = _socket
        partAttributes["Family"] = _family
        partAttributes["Generation"] = _generation
        partAttributes["Description"] = _description
        partAttributes["Manufacturer"] = _manufacturer
        // have to do this because swift is stupid
        if (_isCustom)! {
            partAttributes["IsCustom"] = "true"
        }
        else {
            partAttributes["IsCustom"] = "false"
        }
        
        //result["CPU"] = partAttributes
        
        return partAttributes as NSDictionary
    }
    
    var ram: String { get { return _ram! } set { _ram = newValue } }
    var link: String { get { return _link! } set {_link = newValue} }
    var specs: String { get { return _specs! } set {_specs = newValue}}
    var price: String { get { return _price! } set {_price = newValue}}
    var image: String { get { return _image! } set{_image = newValue}}
    var model: String { get { return _model! } set {_model = newValue}}
    var socket: String { get { return _socket! } set {_socket = newValue}}
    var family: String { get { return _family! } set {_family = newValue}}
    var generation: String { get { return _generation! } set{_generation = newValue} }
    var description: String { get { return _description! } set {_description = newValue}}
    var manufacturer: String { get { return _manufacturer! } set {_manufacturer = newValue}}
    var isCustom: Bool {get{return _isCustom! } set{_isCustom = newValue}}
    
}

class Motherboard: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a motherboard from a dictionary
    public init(dictionary: NSDictionary) {
        //parts motherboard
        _ram = dictionary.value(forKey: "RAM") as? String
        _link = dictionary.value(forKey: "Link") as? String
        _size = dictionary.value(forKey: "Size") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _socket = dictionary.value(forKey: "Socket") as? String
        _chipset = dictionary.value(forKey: "Chipset") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
        
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["RAM"] = _ram
        partAttributes["Link"] = _link
        partAttributes["Size"] = _size
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Model"] = _model
        partAttributes["Socket"] = _socket
        partAttributes["Chipset"] = _chipset
        partAttributes["Manufacturer"] = _manufacturer
        partAttributes["IsCustom"] = String(describing: _isCustom)
        
        result["Motherboard"] = partAttributes
        
        return result as NSDictionary
    }

    
    var ram: String { get { return _ram! } set { _ram = newValue } }
    var link: String { get { return _link! } set { _link = newValue } }
    var size: String { get { return _size! } set { _size = newValue } }
    var price: String { get { return _price! } set { _price = newValue} }
    var image: String { get { return _image! } set { _image = newValue } }
    var model: String { get { return _model! } set { _model = newValue } }
    var socket: String { get { return _socket! } set { _socket = newValue } }
    var chipset: String { get { return _chipset! } set { _chipset = newValue } }
    var manufacturer: String { get { return _manufacturer! } set {_manufacturer = newValue}}
    
    var isCustom: Bool { get { return _isCustom! } set { _isCustom = newValue } }
    
}

class RAM: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a RAM from a dictionary
    public init(dictionary: NSDictionary) {
        
        _ram = dictionary.value(forKey: "RAM") as? String
        _link = dictionary.value(forKey: "Link") as? String
        _size = dictionary.value(forKey: "Size") as? String
        _specs = dictionary.value(forKey: "Specs") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _speed = dictionary.value(forKey: "Speed") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["RAM"] = _link
        partAttributes["Link"] = _link
        partAttributes["Size"] = _size
        partAttributes["Specs"] = _specs
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Model"] = _model
        partAttributes["Speed"] = _speed
        partAttributes["Manufacturer"] = _manufacturer
        partAttributes["IsCustom"] = String(describing: _isCustom)
        
        result["RAM"] = partAttributes
        
        return result as NSDictionary
    }
    
    var ram: String { get { return _ram! } set { _ram = newValue } }
    var link: String { get { return _link! } set { _link = newValue } }
    var size: String { get { return _size! } set { _size = newValue } }
    var specs: String { get { return _specs! } set { _specs = newValue } }
    var price: String { get { return _price! } set { _price = newValue } }
    var image: String { get { return _image! } set { _image = newValue } }
    var model: String { get { return _model! } set { _model = newValue } }
    var speed: String { get { return _speed! } set { _speed = newValue } }
    var manufacturer: String { get { return _manufacturer! } set { _manufacturer = newValue } }
    var isCustom: Bool { get { return _isCustom! } set { _isCustom = newValue } }
    
}


class Storage: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a Storage from a dictionary
    public init(dictionary: NSDictionary) {
        
        _link = dictionary.value(forKey: "Link") as? String
        _size = dictionary.value(forKey: "Size") as? String
        _speed = dictionary.value(forKey: "Speed") as? String
        _class = dictionary.value(forKey: "Class") as? String
        _specs = dictionary.value(forKey: "Specs") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["Link"] = _link
        partAttributes["Size"] = _size
        partAttributes["Speed"] = _speed
        partAttributes["Class"] = _class
        partAttributes["Specs"] = _specs
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Model"] = _model
        partAttributes["Manufacturer"] = _manufacturer
        partAttributes["IsCustom"] = String(describing: _isCustom)
        
        result["Storage"] = partAttributes
        
        return result as NSDictionary
    }
    
    var link: String { get { return _link! } set { _link = newValue } }
    var size: String { get { return _size! } set { _size = newValue } }
    var speed: String { get { return _speed! } set { _speed = newValue } }
    var `class`: String { get { return _class! } set { _class = newValue } }
    var specs: String { get { return _specs! } set { _specs = newValue } }
    var price: String { get { return _price! } set { _price = newValue } }
    var image: String { get { return _image! } set { _image = newValue } }
    var model: String { get { return _model! } set { _model = newValue } }
    var manufacturer: String { get { return _manufacturer! } set { _manufacturer = newValue } }
    var isCustom: Bool { get { return _isCustom! } set { _isCustom = newValue } }
    
}


class GPU: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a GPU from a dictionary
    public init(dictionary: NSDictionary) {
        
        _vram = dictionary.value(forKey: "VRAM") as? String
        _link = dictionary.value(forKey: "Link") as? String
        _size = dictionary.value(forKey: "Size") as? String
        _class = dictionary.value(forKey: "Class") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _brand = dictionary.value(forKey: "Brand") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _series = dictionary.value(forKey: "Series") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["VRAM"] = _vram
        partAttributes["Link"] = _link
        partAttributes["Size"] = _size
        partAttributes["Class"] = _class
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Brand"] = _brand
        partAttributes["Model"] = _model
        partAttributes["Series"] = _series
        partAttributes["Manufacturer"] = _manufacturer
        partAttributes["IsCustom"] = String(describing: _isCustom)
        
        result["GPU"] = partAttributes
        
        return result as NSDictionary
    }
    
    var vram: String { get { return _vram! } set { _vram = newValue } }
    var link: String { get { return _link! } set { _link = newValue } }
    var size: String { get { return _size! } set { _size = newValue } }
    var `class`: String { get { return _class! } set { _class = newValue } }
    var price: String { get { return _price! } set { _price = newValue } }
    var image: String { get { return _image! } set { _image = newValue } }
    var brand: String { get { return _brand! } set { _brand = newValue } }
    var model: String { get { return _model! } set { _model = newValue } }
    var series: String { get { return _series! } set { _series = newValue } }
    var manufacturer: String { get { return _manufacturer! } set { _manufacturer = newValue } }
    var isCustom: Bool { get { return _isCustom! } set { _isCustom = newValue } }
    
}


class PSU: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a PSU from a dictionary
    public init(dictionary: NSDictionary) {
        
        _link = dictionary.value(forKey: "Link") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _wattage = dictionary.value(forKey: "Wattage") as? String
        _modular = dictionary.value(forKey: "Modular") as? String
        _efficiency = dictionary.value(forKey: "Efficiency") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["Link"] = _link
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Model"] = _model
        partAttributes["Wattage"] = _wattage
        partAttributes["Modular"] = _modular
        partAttributes["Efficiency"] = _efficiency
        partAttributes["Manufacturer"] = _manufacturer
        partAttributes["IsCustom"] = String(describing: _isCustom)
        
        result["PSU"] = partAttributes
        
        return result as NSDictionary
    }
    
    var link: String { get { return _link! } set { _link = newValue } }
    var price: String { get { return _price! } set { _price = newValue } }
    var image: String { get { return _image! } set { _image = newValue } }
    var model: String { get { return _model! } set { _model = newValue } }
    var wattage: String { get { return _wattage! } set { _wattage = newValue } }
    var modular: String { get { return _modular! } set { _modular = newValue } }
    var efficiency: String { get { return _efficiency! } set { _efficiency = newValue } }
    var manufacturer: String { get { return _manufacturer! } set { _manufacturer = newValue } }
    var isCustom: Bool { get { return _isCustom! } set { _isCustom = newValue } }
    
}


class OpticalDrive: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a Optical Drive from a dictionary
    public init(dictionary: NSDictionary) {
        
        _link = dictionary.value(forKey: "Link") as? String
        _specs = dictionary.value(forKey: "Specs") as? String
        _speed = dictionary.value(forKey: "Speed") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["Link"] = _link
        partAttributes["Specs"] = _specs
        partAttributes["Speed"] = _speed
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Model"] = _model
        partAttributes["Manufacturer"] = _manufacturer
        partAttributes["IsCustom"] = String(describing: _isCustom)
        
        result["Optical Drive"] = partAttributes
        
        return result as NSDictionary
    }
    
    var link: String { get { return _link! } set { _link = newValue } }
    var specs: String { get { return _specs! } set { _specs = newValue } }
    var speed: String { get { return _speed! } set { _speed = newValue } }
    var price: String { get { return _price! } set { _price = newValue } }
    var image: String { get { return _image! } set { _image = newValue } }
    var model: String { get { return _model! } set { _model = newValue } }
    var manufacturer: String { get { return _manufacturer! } set { _manufacturer = newValue } }
    var isCustom: Bool { get { return _isCustom! } set { _isCustom = newValue } }
    
}


class Case: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a Case from a dictionary
    public init(dictionary: NSDictionary) {
        
        _link = dictionary.value(forKey: "Link") as? String
        _size = dictionary.value(forKey: "Size") as? String
        _color = dictionary.value(forKey: "Color") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["Link"] = _link
        partAttributes["Size"] = _size
        partAttributes["Color"] = _color
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Model"] = _model
        partAttributes["Manufacturer"] = _manufacturer
        partAttributes["IsCustom"] = String(describing: _isCustom)
        
        result["Case"] = partAttributes
        
        return result as NSDictionary
    }
    
    var link: String { get { return _link! } set { _link = newValue } }
    var size: String { get { return _size! } set { _size = newValue } }
    var color: String { get { return _color! } set { _color = newValue } }
    var price: String { get { return _price! } set { _price = newValue } }
    var image: String { get { return _image! } set { _image = newValue } }
    var model: String { get { return _model! } set { _model = newValue } }
    var manufacturer: String { get { return _manufacturer! } set { _manufacturer = newValue } }
    var isCustom: Bool { get { return _isCustom! } set { _isCustom = newValue } }
    
}

class Cooler: MyParts {
    internal var _ram: String?
    internal var _vram: String?
    internal var _link: String?
    internal var _size: String?
    internal var _color: String?
    internal var _specs: String?
    internal var _image: String?
    internal var _price: String?
    internal var _brand: String?
    internal var _model: String?
    internal var _speed: String?
    internal var _class: String?
    internal var _series: String?
    internal var _socket: String?
    internal var _family: String?
    internal var _modular: String?
    internal var _chipset: String?
    internal var _wattage: String?
    internal var _efficiency: String?
    internal var _generation: String?
    internal var _description: String?
    internal var _manufacturer: String?
    
    internal var _isCustom: Bool?
    
    public init(link: String, specs: String, price: String, image: String, model: String, socket: String, family: String, generation: String, description: String, manufacturer: String, ram: String, isCustom: Bool)
    {
        _link = link
        _specs = specs
        _price = price
        _image = image
        _model = model
        _socket = socket
        _family = family
        _generation = generation
        _description = description
        _manufacturer = manufacturer
        _ram = ram
        
        _isCustom = isCustom
        
    }
    
    
    // Create a CPU from a dictionary
    public init(dictionary: NSDictionary) {
        
        _link = dictionary.value(forKey: "Link") as? String
        _specs = dictionary.value(forKey: "Specs") as? String
        _class = dictionary.value(forKey: "Class") as? String
        _price = dictionary.value(forKey: "Price") as? String
        _image = dictionary.value(forKey: "Image") as? String
        _model = dictionary.value(forKey: "Model") as? String
        _manufacturer = dictionary.value(forKey: "Manufacturer") as? String
        _isCustom = Bool(dictionary.value(forKey: "IsCustom") as! String)!
    }
    
    
    public var dictionaryRepresentation: NSDictionary {
        var result: [String: [String : String]] = [:]
        var partAttributes: [String : String] = [:]
        
        partAttributes["Link"] = _link
        partAttributes["Specs"] = _specs
        partAttributes["Class"] = _class
        partAttributes["Price"] = _price
        partAttributes["Image"] = _image
        partAttributes["Model"] = _model
        partAttributes["Manufacturer"] = _manufacturer
        partAttributes["IsCustom"] = String(describing: _isCustom)
        
        result["Cooler"] = partAttributes
        
        return result as NSDictionary
    }
    
    var link: String { get { return _link! } set { _link = newValue } }
    var specs: String { get { return _specs! } set { _specs = newValue } }
    var `class`: String { get { return _class! } set { _class = newValue } }
    var price: String { get { return _price! } set { _price = newValue } }
    var image: String { get { return _image! } set { _image = newValue } }
    var model: String { get { return _model! } set { _model = newValue } }
    var manufacturer: String { get { return _manufacturer! } set { _manufacturer = newValue } }
    var isCustom: Bool { get { return _isCustom! } set { _isCustom = newValue } }
    
}

