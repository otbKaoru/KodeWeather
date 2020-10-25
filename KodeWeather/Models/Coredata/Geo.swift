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
public class Geo: NSManagedObject, Decodable, Identifiable {
    enum CodingKeys: CodingKey {
        case lan, lon, name
    }

    @NSManaged public var lan: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?

    required convenience public init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context,
              let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { throw DecodeError.contextError }
        guard let entity = NSEntityDescription.entity(forEntityName: "Geo", in: context) else { throw DecodeError.databaseError }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.lan = try container.decode(Double.self, forKey: .lan)
        self.lon = try container.decode(Double.self, forKey: .lon)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

extension Geo {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Geo> {
        return NSFetchRequest<Geo>(entityName: "Geo")
    }

}
