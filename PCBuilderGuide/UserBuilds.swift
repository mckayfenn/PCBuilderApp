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
        let docDirectory: URL = getDesktop().appendingPathComponent("Library.json")
        //try! jsonData.write(to: docDirectory)
        try! jsonData.write(to: URL.init(fileURLWithPath: "/Users/Authenticated User/Desktop/Library.json"))
        print("finsih save")
    }
    
    
    
    
    
    
    public func loadBuilds() {
        var buildDictionaries: [NSDictionary] = []
        
        let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/Authenticated User/Desktop/Library.json"))
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
    
    public func addPart(part: MyParts) {
        _listOfUsersParts.append(part)
    }
    
    public func getAllParts() -> [MyParts] {
        return _listOfUsersParts
    }
    
    public var dictionaryRepresentation: NSDictionary {
//        var result: [String : [String : [String : String]]] = [:]
//        
//        var strings: [String : [String : String]] = [:]
//        var attributes: [String: String] = [:]
//        var items: String = ""
//        for part: MyParts in _listOfUsersParts {
//            if (part is CPU) {
//                items = part._model
//                attributes["Model"] = items
//                
//                strings["CPU"] = attributes
//            }
//        }
//        
//        
//        
//        result["Parts"] = strings
        //result["Title"] = [String(_buildTitle)]
        
        var result: [String : [String : String]] = [:]
        var partType: [String : String] = [:]

        
        for part: MyParts in _listOfUsersParts {
            if (part is CPU) {
                partType["Manufacturer"] = part._manufacturer
                partType["Model"] = part._model
                partType["Socket"] = part._socket
                partType["Description"] = part._description
                partType["Specs"] = part._specs
                partType["Link"] = part._link
                partType["Family"] = part._family
                partType["Generation"] = part._generation
                partType["Price"] = part._price
                partType["Image"] = part._image
                
                result["CPU"] = partType
            }
        }
        
        var title: [String : String] = [:]
        title["Title"] = _buildTitle
        
        result["Title"] = title
        
        return result as NSDictionary
    }
}
