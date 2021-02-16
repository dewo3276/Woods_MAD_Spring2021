//
//  collegeMajorLoader.swift
//  CU Majors
//
//  Created by Dusty on 2/16/21.
//

import Foundation

class collegeMajorLoader{
    var ContainData = [collegeData]()
    
    func loadData(filename: String){
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                ContainData = try plistdecoder.decode([collegeData].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }
    
    func getCollege() -> [String]{
        var colleges = [String]()
        var n = 0
        for _ in ContainData{
            colleges.append(String(ContainData[n].college[0]))
            n+=1
        }
        return colleges
    }
    
    func getURL(index: Int) -> String{
        return ContainData[index].college[0]
    }
    
    func getMajors(index:Int) -> [String] {
        return ContainData[index].majors
    }
    
    func deleteMajor(index: Int, majorIndex: Int){
        ContainData[index].majors.remove(at: majorIndex)
    }
    
    func addMajor(index:Int, newMajor:String, newIndex: Int){
        ContainData[index].majors.insert(newMajor, at: newIndex)
    }
}
