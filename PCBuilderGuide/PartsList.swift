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
        
        
        
        //var paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        //var path = paths[0]
        
//        let path: String = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)[0] as String
//        let url = NSURL(fileURLWithPath: path)
//        let filePath: String? = url.appendingPathComponent("Library.json")?.path
//        let fileManager: FileManager = FileManager.default
//        if fileManager.fileExists(atPath: filePath!) {
//            let docDirectory: URL = getDesktop().appendingPathComponent("Library.json")
//            let jsonData: Data = try! Data(contentsOf: docDirectory)
//            partsDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
//        }
        
        
        
//        if let path = Bundle.main.path(forResource: "Library", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//                let jsonObj = try! JSONSerialization.jsonObject(with: data, options: [])
//                if jsonObj != nil {
//                    print("jsonData: \(jsonObj)")
//                }
//                else {
//                    print("Could not get data")
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        else {
//            print("Invalid filename/path")
//        }
        
        
        
        
        
        
        // ------- Finally just hardcoded the desktop path ------ s
        let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/Authenticated User/Desktop/PCBuilderApp/Library.json"))
        //let jsonData: Data = try! Data(contentsOf: URL(string: "https://www.reddit.com/r/buildapc.json")!)
        partsDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary

        _listOfParts = Parts(dictionary: partsDictionaries)
        
//        var data = _listOfParts?.getListOfPartsByName(partType: "Motherboard")
//        
//        var cpu = _listOfParts?.processors.last
//        
//        var compatibleMobos = _listOfParts?.getCompatiblePartsTo(partType: "Motherboard", compatibleTo: cpu!)
        
        NSLog("finish load")
        
        
    }
    
    
    
    // for pastelist save load custom parts
    public func saveCustomParts() {
        
        var partsDictionaries: [NSDictionary] = []
        
        for cpu in (_listOfParts?.processors)! {
            if (cpu.isCustom) {
                partsDictionaries.append(cpu.dictionaryRepresentation)
            }
        }
        
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: partsDictionaries, options: .prettyPrinted)
        let docDirectory: URL = getDesktop().appendingPathComponent("CustomParts.json")
        
        try! jsonData.write(to: URL.init(fileURLWithPath: "/Users/Authenticated User/Desktop/CustomParts.json"))
        print("finish saving custom parts")
    }
    
    public func loadCustomParts() {
        var customPartsDictionaries: [NSDictionary] = []
        
        let jsonData: Data = try! Data(contentsOf: URL.init(fileURLWithPath: "/Users/Authenticated User/Desktop/CustomParts.json"))
        customPartsDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [NSDictionary]
        
        
        for parts in customPartsDictionaries {
            let keys = parts.allKeys
            print(keys)
            for key in keys {
                let keyString: String = (key as AnyObject).description
                print(keyString)
                let dict = parts.value(forKey: key as! String)

                switch keyString {
                case "CPU":
                    let cpu = CPU(dictionary: dict as! NSDictionary)
                    _listOfParts?.addCustomPart(part: cpu)
                    break
                default:
                    break
                }
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
