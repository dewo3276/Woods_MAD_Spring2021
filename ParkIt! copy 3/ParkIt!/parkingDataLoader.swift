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
    func loadData(){
        
        if(UserDefaults.standard.value(forKey: "parked")==nil)
        {
            print("nothing")
            return
        }
        
        let data = UserDefaults.standard.value(forKey: "parked") as! Data
        let obj1 = try? PropertyListDecoder().decode(parkingData.self, from: data)
        
        for parkingLocs in 0...(obj1?.location.count)!-1
        {
            Varriables.selectedCoords[parkingLocs] = String((obj1?.location[parkingLocs])!)
        }
        Varriables.selectedDate = String((obj1?.date)!)
    }
    
    func addData(pinCoords: Array<String>, dateAndtime: String){
        let obj = try? PropertyListEncoder().encode(parkingData(location: [pinCoords[0],pinCoords[1]], date: dateAndtime))
        UserDefaults.standard.setValue(obj, forKey: "parked")
    }
    
    func deleteData(){
        UserDefaults.resetStandardUserDefaults()
    }
}
