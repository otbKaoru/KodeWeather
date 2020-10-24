//
//  AttractionDetailPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation
import CoreData

final class AttractionDetailPresenter {

    // MARK: - Properties

    weak var view: AttractionDetailViewInput?

    private let attractionService: AttractionService = AttractionService()
}

extension AttractionDetailPresenter: AttractionDetailViewOutput {
    func viewLoaded() {
        let json = attractionService.loadJson(filename: "Attractions")

        CoreDataService.instance.clearData()

//        let context = CoreDataService.instance.getContext()
//
//        let attr = Attraction(context: context)
//        attr.desc = json?.desc
//        attr.descfull = json?.descfull
//        attr.images = json?.images
//        attr.name = json?.name

//        CoreDataService.instance.saveContext()

//        let fetchRequest = NSFetchRequest<Attraction>(entityName: "Attraction")
//
//        do {
//            let fetchResults = try context.fetch(fetchRequest)
//            for object in fetchResults { print("TEST")}
//        } catch {
//            print(error)
//        }
    }
}
