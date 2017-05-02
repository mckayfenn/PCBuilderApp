//
//  PartsList.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/10/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import Foundation

class PartsList {
    
    public static let Instance: PartsList = PartsList()
    
    private init() {
        
    }
    
    private var _listOfParts: Parts? = nil
    public var listOfAllParts: Parts {
        get { return _listOfParts! }
    }

    public func loadParts() {
        
        var partsDictionaries: NSDictionary = [:]
        

        let libraryPath = Bundle.main.path(forResource: "Library", ofType: "json")
        let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: libraryPath!))
        partsDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary

        _listOfParts = Parts(dictionary: partsDictionaries)
        
    }
    
    
    
    // for pastelist save load custom parts
    public func saveCustomParts() {
        
        var finalResult: [String: [NSDictionary]] = [:]
        
        var partsDictionaries: [NSDictionary] = []
        
        // save custom processors
        for cpu in (_listOfParts?.processors)! {
            if (cpu._isCustom)! {
                partsDictionaries.append(cpu.dictionaryRepresentation)
            }
        }
        // if there were any custom, put them in the dictionary
        // then remove everything so partsDictionaries can be reused.
        if (partsDictionaries.count > 0) {
            finalResult["CPU"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        // save motherboards
        for mobo in (_listOfParts?.motherboards)! {
            if (mobo._isCustom)! {
                partsDictionaries.append(mobo.dictionaryRepresentation)
            }
        }
        if (partsDictionaries.count > 0) {
            finalResult["Motherboard"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        // save RAM
        for ram in (_listOfParts?.rams)! {
            if (ram._isCustom)! {
                partsDictionaries.append(ram.dictionaryRepresentation)
            }
        }
        if (partsDictionaries.count > 0) {
            finalResult["RAM"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        // save gpus
        for gpu in (_listOfParts?.gpus)! {
            if (gpu._isCustom)! {
                partsDictionaries.append(gpu.dictionaryRepresentation)
            }
        }
        if (partsDictionaries.count > 0) {
            finalResult["GPU"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        // save cases
        for tower in (_listOfParts?.cases)! {
            if (tower._isCustom)! {
                partsDictionaries.append(tower.dictionaryRepresentation)
            }
        }
        if (partsDictionaries.count > 0) {
            finalResult["Case"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        // save psus
        for psu in (_listOfParts?.psus)! {
            if (psu._isCustom)! {
                partsDictionaries.append(psu.dictionaryRepresentation)
            }
        }
        if (partsDictionaries.count > 0) {
            finalResult["PSU"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        
        // save coolers
        for cooler in (_listOfParts?.coolers)! {
            if (cooler._isCustom)! {
                partsDictionaries.append(cooler.dictionaryRepresentation)
            }
        }
        if (partsDictionaries.count > 0) {
            finalResult["Cooler"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        
        // save storage drives
        for drive in (_listOfParts?.storages)! {
            if (drive._isCustom)! {
                partsDictionaries.append(drive.dictionaryRepresentation)
            }
        }
        if (partsDictionaries.count > 0) {
            finalResult["Storage"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        
        // save optical drives
        for drive in (_listOfParts?.opticalDrives)! {
            if (drive._isCustom)! {
                partsDictionaries.append(drive.dictionaryRepresentation)
            }
        }
        if (partsDictionaries.count > 0) {
            finalResult["Optical Drive"] = partsDictionaries
            partsDictionaries.removeAll()
        }
        
        
        
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: finalResult, options: .prettyPrinted)
        let docDirectory: URL = getDocumentsDirectory().appendingPathComponent("CustomParts.json")
        
        try! jsonData.write(to: docDirectory)
    }
    
    public func loadCustomParts() {
        var customPartsDictionaries: NSDictionary = [:]
        
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath: String? = url.appendingPathComponent("CustomParts.json")?.path
        let fileManager: FileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
            let docDirectory: URL = getDocumentsDirectory().appendingPathComponent("CustomParts.json")
            let jsonData: Data = try! Data(contentsOf: docDirectory)
            customPartsDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
        }
        
        
        for parts in customPartsDictionaries {
            let key = parts.key
            let keyString: String = key as! String
            
            
            let dicts: [NSDictionary] = parts.value as! [NSDictionary]
            
            switch keyString {
            case "CPU":
                for partDict in dicts {
                    let cpu = CPU(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: cpu)
                }
                break
            case "Motherboard":
                for partDict in dicts {
                    let mobo = Motherboard(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: mobo)
                }
                break
            case "RAM":
                for partDict in dicts {
                    let ram = RAM(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: ram)
                }
                break
            case "GPU":
                for partDict in dicts {
                    let gpu = GPU(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: gpu)
                }
                break
            case "Case":
                for partDict in dicts {
                    let tower = Case(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: tower)
                }
                break
            case "PSU":
                for partDict in dicts {
                    let psu = PSU(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: psu)
                }
                break
            case "Cooler":
                for partDict in dicts {
                    let cooler = Cooler(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: cooler)
                }
                break
            case "Storage":
                for partDict in dicts {
                    let drive = Storage(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: drive)
                }
                break
            case "Optical Drive":
                for partDict in dicts {
                    let drive = OpticalDrive(dictionary: partDict)
                    _listOfParts?.addCustomPart(part: drive)
                }
                break
            default:
                break
            }
        }
    }

    
    
    public func isPartCompatibleTo(currentParts: [MyParts], thisPart: MyParts) -> Bool {
        return (_listOfParts?.isPartCompatibleTo(currentParts: currentParts, thisPart: thisPart))!
    }
    
    public func getAllPartsFirstLevel(type: String) -> [MyParts] {
        return (_listOfParts?.getAllPartsFirstLevel(type: type))!
    }
    
    public func getAllPartsSecondLevel(type: String, firstLevelSelection: String) -> [MyParts] {
        return (_listOfParts?.getAllPartsSecondLevel(type: type, firstLevelSelection: firstLevelSelection))!
    }
    
    public func getPartsForCategory(type: String, firstLevelSelection: String, secondLevelSelection: String) -> [MyParts] {
        return (_listOfParts?.getPartsForCategory(type: type, firstLevelSelection: firstLevelSelection, secondLevelSelection: secondLevelSelection))!
    }
    
    public func getFirstLevelParts(partType: String) -> [String] {
        return (_listOfParts?.getFirstLevelParts(partType: partType))!
    }
    
    public func getSecondLevelParts(type: String, firstLevelSelection: String) -> [String] {
        return (_listOfParts?.getSecondLevelParts(type: type, firstLevelSelection: firstLevelSelection))!
    }
    
    
    public func addCustomPart(part: MyParts) {
        _listOfParts?.addCustomPart(part: part)
    }
    
    public func sortByPrice(listOfParts: [MyParts], order: String) -> [MyParts] {
        return (_listOfParts?.sortByPrice(listOfParts: listOfParts, highLow: order))!
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func getDesktop() -> URL {
        let paths = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)
        let desktopDirectory = paths[0]
        return desktopDirectory
    }
}
