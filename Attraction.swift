//
//  Attraction+CoreDataProperties.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//
//

import Foundation
import CoreData

public class Attraction: NSManagedObject {

}


extension Attraction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attraction> {
        return NSFetchRequest<Attraction>(entityName: "Attraction")
    }

    @NSManaged public var desc: String?
    @NSManaged public var descfull: String?
    @NSManaged public var images: NSObject?
    @NSManaged public var name: String?

}

extension Attraction : Identifiable {

}
