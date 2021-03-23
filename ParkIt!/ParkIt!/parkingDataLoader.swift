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
    var containData = [parkingData]()
    
    func loadData(filename: String){
        
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                containData = try plistdecoder.decode([parkingData].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }
    
    func getLocation() ->[String]{
        var locations = [String]()
        for parkingLocs in containData{
            locations.append(contentsOf: parkingLocs.location)
        }
        return locations
    }
    
    func getDate() ->[String]{
        var dates = [String]()
        for parkingDates in containData{
            dates.append(parkingDates.date)
        }
        return dates
    }
    
    func addData(pinCoords: Array<String>, dateAndtime: String){
        containData[containData.count].location.append(contentsOf: pinCoords)
        containData[containData.count].date.append(dateAndtime)
    }
    
    func deleteData(index: Int){
        containData.remove(at: index)
    }
}
