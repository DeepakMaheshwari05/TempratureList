
import CoreData

import UIKit

class CoreDataOperationClass: NSObject {
  
    //////// Setting vlue in core data
    class  func setValueOnCoreData(_ data : [String:Any])
    {
        var temp : Float = 0.0
        var tempMin : Float = 0.0
        var tempMax : Float = 0.0
        let name = data["name"] as! String
        var humidity = 0
        
        let country = (data["sys"] as! [String:Any])["country"] as! String
        if let n = (data["main"] as! [String:Any])["temp"] as? NSNumber {
            temp = n.floatValue
        }
        if let n = (data["main"] as! [String:Any])["temp_min"] as? NSNumber {
            tempMin = n.floatValue
        }
        if let n = (data["main"] as! [String:Any])["temp_max"] as? NSNumber {
            tempMax = n.floatValue
        }
        if let n = (data["main"] as! [String:Any])["humidity"] as? NSNumber {
            humidity = n.intValue
        }
        if findValueOnCoreData(name,with: temp) == true {
            return
        }
        let entity = NSEntityDescription.entity(forEntityName: "CityTemp", in:appDel.context)
        
        let newObj = CityTemp(entity:entity!, insertInto:appDel.context)

       newObj.cityName = name
        newObj.cityTemprature = temp
        newObj.maxTemp = tempMax
        newObj.minTemp = tempMin
        newObj.humidity = Int16(humidity)
        newObj.country = country
        do{
            try appDel.context.save()
        } catch _ {
        }
        
    }
    
    ////// Finding value in core data
    class func findValueOnCoreData(_  name:String,with temp:Float) -> Bool?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityTemp")
        fetchRequest.predicate = NSPredicate(format:"cityName == %@ ",name)
        do {
            // Execute Fetch Request
            let records = try appDel.context.fetch(fetchRequest)
            if let records = records as? [NSManagedObject] {
                if records.count > 0 {
                    updateTemp(name, With: temp)
                    return true
                } else {
                    return false
                }
            }
        } catch {
        }
        return false
    }
    ////// Updating temprature in DB
    class func updateTemp(_  name:String,With temp:Float)  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityTemp")
        fetchRequest.predicate = NSPredicate(format:"cityName == %@ ",name)
        do {
            // Execute Fetch Request
            let records = try appDel.context.fetch(fetchRequest)
            if let records = records as? [NSManagedObject] {
                if records.count > 0 {
                    if   let resultObj = records[0] as? CityTemp {
                        resultObj.cityTemprature = temp
                        do{
                            try appDel.context.save()
                        } catch _ {
                        }
                    }
                }
            }
        } catch {
        }
    }

}
