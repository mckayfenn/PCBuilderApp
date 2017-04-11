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

    public func loadParts() {
        
        
        //var paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        //var path = paths[0]
        var partsDictionaries: NSDictionary = [:]
//        let path: String = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)[0] as String
//        let url = NSURL(fileURLWithPath: path)
//        let filePath: String? = url.appendingPathComponent("Library.json")?.path
//        let fileManager: FileManager = FileManager.default
//        if fileManager.fileExists(atPath: filePath!) {
//            let docDirectory: URL = getDesktop().appendingPathComponent("Library.json")
//            let jsonData: Data = try! Data(contentsOf: docDirectory)
//            partsDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
//        }
        
        // ------- Finally just hardcoded the desktop path ------ s
        let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: "/Users/Authenticated User/Desktop/PCBuilderApp/Library.json"))
        //let jsonData: Data = try! Data(contentsOf: URL(string: "https://www.reddit.com/r/buildapc.json")!)
        partsDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
        
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
        

        let part: Parts = Parts(dictionary: partsDictionaries)
        
        
        
        NSLog("finish load")
        
        
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
