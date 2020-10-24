//
//  Geo+CoreDataClass.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//
//

import Foundation
import CoreData

@objc(Geo)
public class Geo: NSManagedObject {
}

extension Geo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Geo> {
        return NSFetchRequest<Geo>(entityName: "Geo")
    }

    @NSManaged public var lan: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?
}

extension Geo : Identifiable {

}
