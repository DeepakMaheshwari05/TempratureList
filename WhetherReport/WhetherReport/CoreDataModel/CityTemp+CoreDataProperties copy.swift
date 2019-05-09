//
//  CityTemp+CoreDataProperties.swift
//  
//
//  Created by Deepak.Maheshwari on 08/05/19.
//
//

import Foundation
import CoreData


extension CityTemp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityTemp> {
        return NSFetchRequest<CityTemp>(entityName: "CityTemp")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var cityTemprature: Float
    @NSManaged public var humidity: Int16
    @NSManaged public var minTemp: Float
    @NSManaged public var maxTemp: Float
    @NSManaged public var country: String?

}
