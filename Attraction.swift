//
//  Attraction+CoreDataProperties.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//
//

import Foundation
import CoreData

class Attraction: NSManagedObject {
    @NSManaged public var desc: String?
    @NSManaged public var descfull: String?
    @NSManaged public var images: String?
    @NSManaged public var name: String?
}


extension Attraction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attraction> {
        return NSFetchRequest<Attraction>(entityName: "Attraction")
    }

}

extension Attraction : Identifiable {

}
