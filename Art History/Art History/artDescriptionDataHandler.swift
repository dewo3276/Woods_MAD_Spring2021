//
//  artDescriptionDataHandler.swift
//  Art History
//
//  Created by Dusty on 3/16/21.
//

import Foundation


struct artList: Decodable {
    let era : String
    let description: String
}

class artDescriptionDataHandler {
    var containsData = [artList]()
    func loadData(filename: String){
        if let pathURL=Bundle.main.url(forResource: filename, withExtension: "plist"){
            let plisthandler = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL)
                containsData = try plisthandler.decode([artList].self, from: data)
            } catch{
                print(error)
            }
        }
    }


func getEra() -> [String]{
    var eras = [String]()
    for era in containsData{
        eras.append(era.era)
    }
    return eras
}

    func getDescription(index: Int) -> String{
        return containsData[index].description
    }
}
