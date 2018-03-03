//
//  JsonReader.swift
//  Individual
//
//  Created by Quincy on 2018-02-08.
//  Copyright © 2018 Quincy Lam. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_Synchronous
import TraceLog
import SwiftyJSON

class JsonController
{
    //Class variables
    var baseUrl: String = ""
    var jsonObject: JSON = JSON()
    
    //Initialize this object to read with the url to read from then load it
    init(urlTarget: String) {
        if(urlTarget != "") {
            self.baseUrl = urlTarget
            //self.load()
        }
    }
    
    //Goes to the URL with Alamofire to get the json object and do something
    func loadAsAsync(tableView: MasterViewController) {
        Alamofire.request(self.baseUrl).responseJSON(completionHandler: {
                    response in
                    if let value = response.result.value {
                        //Using SwiftyJson, wrap response value
                        self.jsonObject = JSON(value)
                        
                        //Do your functions
                        var arrayItems = [String]()
                        

                        
                        
                        //Prints the json object
                        self.printJson()
                        
                        //Print single item in the JSON file.
                        
                        //Print the upper most category with key "Type"
                        print(self.jsonObject["type"].stringValue)
                        
                        //"Features" is an array, that has a key called "Properties" and "Name" nested inside it.
                        print(self.jsonObject["features"][0]["properties"]["Name"].stringValue)
                        
                        //Add your custom array
                        arrayItems = self.extractColumn(topCategory: "features", innerCategory: "properties", innerInnerCategory: "Name")
                        
                        //With your own method, use helper method to insert array
                        tableView.insertArray(Data: arrayItems)
                    }
                })
    }
    
    //Goes to the URL with Alamofire_Synchronous to get the json object
    func loadAsSync() {
        
        //Using this syntax of alamofire will make it run as synchronous and cause main thread to wait for response
        let response = Alamofire.request(self.baseUrl).responseJSON()
        
        //If successful, save to classwide variable for later use.
        if let json = response.result.value {
            self.jsonObject = JSON(json)
        } else {
            print("Error")
        }
    }
    
    //reload the JSON controller with a new URL with read from
    func reloadSync(urlTarget: String) {
        self.baseUrl = urlTarget
        //Using this syntax of alamofire will make it run as synchronous and cause main thread to wait for response
        let response = Alamofire.request(self.baseUrl).responseJSON()
        
        //If successful, save to classwide variable for later use.
        if let json = response.result.value {
            self.jsonObject = JSON(json)
        } else {
            print("Error")
        }
    }
    
    //Return the stored JSON
    func getJson() -> JSON {
        return self.jsonObject
    }
    
    //Prints the JSON
    func printJson() {
        print(self.jsonObject)
    }
    
    //Extracts a column that has inner values, change arguments and array extraction depending on how your json looks
    //Returns as array
    func extractColumn(topCategory: String, innerCategory: String, innerInnerCategory: String) -> [String]{
        let columnArray = self.jsonObject[topCategory].arrayValue.map({$0[innerCategory][innerInnerCategory].stringValue})
        return columnArray
    }
}
