//
//  Attraction+CoreDataProperties.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//
//

import Foundation
import CoreData


extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

enum DecodeError: Error {
    case databaseError
    case contextError
}



class Attraction: NSManagedObject, Decodable, Identifiable {

    enum CodingKeys: String, CodingKey {
        case name, images, desc, descfull
    }

    @NSManaged public var desc: String?
    @NSManaged public var descfull: String?
    @NSManaged public var images: [String]?
    @NSManaged public var name: String?
    @NSManaged public var geo: Geo?

    required convenience init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context,
              let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { throw DecodeError.contextError }

        guard let entity = NSEntityDescription.entity(forEntityName: "Attraction", in: context) else { throw DecodeError.databaseError }

        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.descfull = try container.decodeIfPresent(String.self, forKey: .descfull)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.images = try container.decodeIfPresent([String].self, forKey: .images)
    }

}

extension Attraction {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attraction> {
        return NSFetchRequest<Attraction>(entityName: "Attraction")
    }

}



