//
//  UserBuilds.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/23/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import Foundation

class UserBuilds {
    private var _listOfBuilds: [UserBuild] = []
    
    public static let Instance: UserBuilds = UserBuilds()
    
    private init() {
        // init
    }
    
    public func createBuild() {
        let newBuild: UserBuild = UserBuild()
        _listOfBuilds.append(newBuild)
    }
    
    public func deleteBuild(index: Int) {
        _listOfBuilds.remove(at: index)
    }
    
    public func getBuildAt(index: Int) -> UserBuild {
        return _listOfBuilds[index]
    }
    
    public func getPartsOfBuild(buildIndex: Int) -> [MyParts] {
        return _listOfBuilds[buildIndex].getAllParts()
    }
    
    public func getTitleOfBuild(buildIndex: Int) -> String {
        return _listOfBuilds[buildIndex].buildTitle
    }
    
    public func getNumberOfBuilds() -> Int {
        return _listOfBuilds.count
    }
    
    public func addPartToBuild(part: MyParts, buildIndex: Int) {
        _listOfBuilds[buildIndex].addPart(part: part)
    }
    
    
    
    
    public func saveBuilds() {
        var buildDictionaries: [NSDictionary] = []
        
        for build: UserBuild in _listOfBuilds {
            buildDictionaries.append(build.dictionaryRepresentation)
        }
        
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: buildDictionaries, options: .prettyPrinted)
        let docDirectory: URL = getDesktop().appendingPathComponent("UserBuilds.json")
        //try! jsonData.write(to: docDirectory)
        try! jsonData.write(to: URL.init(fileURLWithPath: "/Users/Authenticated User/Desktop/UserBuilds.json"))
        print("finsih save")
    }
    
    
    
    
    
    
    public func loadBuilds() {
        var buildDictionaries: [NSDictionary] = []
        
        let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/Authenticated User/Desktop/UserBuilds.json"))
        buildDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [NSDictionary]
        
        for build: NSDictionary in buildDictionaries {
            let keys = build.allKeys
            
            createBuild()
            
            
            for key in keys {
                let keyString: String = (key as AnyObject).description
                
                switch keyString {
                case "Title":
                    let title: NSDictionary = build.value(forKey: "Title") as! NSDictionary
                    _listOfBuilds[_listOfBuilds.count - 1].buildTitle = title.value(forKey: "Title") as! String
                    break
                case "CPU":
                    let processors: NSDictionary = build.value(forKey: "CPU") as! NSDictionary
                    let cpuPart = CPU(dictionary: processors)
                    _listOfBuilds[_listOfBuilds.count - 1].addPart(part: cpuPart)
                    break
                default:
                    break
                }
            }
        }
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


class UserBuild {
    private var _listOfUsersParts: [MyParts] = []
    private var _buildTitle: String = ""
    
    public init () {
        // nothing
    }
    
    public var buildTitle: String { get { return _buildTitle } set { _buildTitle = newValue } }
    
    
    
    
    /**
    * Add a part to the user build
    * check if there is already one of these parts and remove it to replace it
    **/
    public func addPart(part: MyParts) {
        
//        if (type(of: part) == CPU.self) {
//            for i: Int in 0..<_listOfUsersParts.count {
//                let thisPart = _listOfUsersParts[i]
//                if (type(of: thisPart) == CPU.self) {
//                    _listOfUsersParts.remove(at: i)
//                    break
//                }
//            }
//        }
//        else if (type(of: part) == Motherboard.self) {
//            // same thing but remove motherboard
//        }
        

        
        // This is a much better way to do it add part
        for i: Int in 0..<_listOfUsersParts.count {
            let thisPart = _listOfUsersParts[i]
            if (type(of: thisPart).self == type(of: part).self) {
                _listOfUsersParts.remove(at: i)
            }
        }
        
        
        // add the new one
        _listOfUsersParts.append(part)
    }
    
    
    
    
    public func getAllParts() -> [MyParts] {
        return _listOfUsersParts
    }
    
    public var dictionaryRepresentation: NSDictionary {
        
        var result: [String : [String : String]] = [:]

        
        for part: MyParts in _listOfUsersParts {
            if (part is CPU) {
                let cpu: CPU = part as! CPU
                result["CPU"] = cpu.dictionaryRepresentation as? [String : String]
            }
            else if (part is Motherboard) {
                let mobo: Motherboard = part as! Motherboard
                result["Motherboard"] = mobo.dictionaryRepresentation as? [String : String]
            }
            else if (part is RAM) {
                let ram: RAM = part as! RAM
                result["RAM"] = ram.dictionaryRepresentation as? [String : String]
            }
            else if (part is GPU) {
                let gpu: GPU = part as! GPU
                result["GPU"] = gpu.dictionaryRepresentation as? [String : String]
            }
            else if (part is Case) {
                let tower: Case = part as! Case
                result["Case"] = tower.dictionaryRepresentation as? [String : String]
            }
            else if (part is PSU) {
                let psu: PSU = part as! PSU
                result["PSU"] = psu.dictionaryRepresentation as? [String : String]
            }
            else if (part is Cooler) {
                let cooler: Cooler = part as! Cooler
                result["Cooler"] = cooler.dictionaryRepresentation as? [String : String]
            }
            else if (part is Storage) {
                let drive: Storage = part as! Storage
                result["Storage"] = drive.dictionaryRepresentation as? [String : String]
            }
            else if (part is OpticalDrive) {
                let drive: OpticalDrive = part as! OpticalDrive
                result["Optical Drive"] = drive.dictionaryRepresentation as? [String : String]
            }
        }
        
        var title: [String : String] = [:]
        title["Title"] = _buildTitle
        
        result["Title"] = title
        
        return result as NSDictionary
    }
}
