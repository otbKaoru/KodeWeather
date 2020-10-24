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

//    enum CodingKeys: String, CodingKey {
//        case name, images, desc, descfull
//    }

    @NSManaged public var desc: String?
    @NSManaged public var descfull: String?
    @NSManaged public var images: String?
    @NSManaged public var name: String?

//    // MARK: - Decodable
//    required convenience init(from decoder: Decoder) throws {
//        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
//            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
//            let entity = NSEntityDescription.entity(forEntityName: "Attraction", in: managedObjectContext) else {
//            fatalError("Failed to decode User")
//        }
//
//        self.init(entity: entity, insertInto: managedObjectContext)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decodeIfPresent(String.self, forKey: .name)
//        self.descfull = try container.decodeIfPresent(String.self, forKey: .descfull)
//        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
//        self.images = try container.decodeIfPresent(String.self, forKey: .images)
//    }

}


extension Attraction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attraction> {
        return NSFetchRequest<Attraction>(entityName: "Attraction")
    }

}

extension Attraction : Identifiable {

}
