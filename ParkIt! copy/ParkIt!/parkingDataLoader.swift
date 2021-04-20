//
//  dataLoader.swift
//  ParkIt!
//
//  Created by Dusty on 2/22/21.
//

import Foundation

struct parkingData: Codable{
    var location : [String]
    var date : String
}

class parkingDataLoader{
    var locations = [String]()
    var dates = [String]()
    func loadData(){
        
        if(UserDefaults.standard.value(forKey: "testStruct")==nil)
        {
            print("nothing")
            return
        }
        
        let data = UserDefaults.standard.value(forKey: "testStruct") as! Data
        let obj1 = try? PropertyListDecoder().decode(parkingData.self, from: data)
        
        for parkingLocs in 0...(obj1?.location.count)!-1
        {
            locations.append(String((obj1?.location[parkingLocs])!))
        }
        for date in 0...(obj1?.date.count)!-1
        {
            dates.append(String((obj1?.date)!))
        }
    }
    
    func getDate()->[String]{
        return dates
    }
    
    func getLocation()->[String]{
        return locations
    }
    
    func addData(pinCoords: Array<String>, dateAndtime: String){
        let obj = try? PropertyListEncoder().encode(parkingData(location: [pinCoords[0],pinCoords[1]], date: dateAndtime))
        UserDefaults.standard.setValue(obj, forKey: "testStruct")
    }
    
    func deleteData(index: Int){
        UserDefaults.standard.removeObject(forKey: "testStruct")
    }
}
