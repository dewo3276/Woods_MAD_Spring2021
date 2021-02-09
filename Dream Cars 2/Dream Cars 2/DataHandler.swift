//
//  DataHandler.swift
//  Dream cars
//
//  Created by Dusty on 2/4/21.
//

import Foundation

struct carModels: Decodable {
    let make : String
    let model: [String]
}

class DataLoader {
    var allData = [carModels]()
    
    func loadData(filename: String){
        if let pathURL = Bundle.main.url(forResource: filename, withExtension:  "plist")
        {
            //initialize a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                allData = try plistdecoder.decode([carModels].self, from: data)
            } catch {
                //handle error
                print("Cannot load data")
            }
        }
    }
    
    func getMake() -> [String]{
        var cars = [String]()
        for car in allData{
            cars.append(car.make)
        }
        return cars
    }
    
    func getModel(index: Int) -> [String] {
        return allData[index].model
    }
}
