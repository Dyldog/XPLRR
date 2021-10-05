//
//  Database.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import SwiftUI
import MapKit

class Database: NSObject, ObservableObject {
    @Published private(set) var places: [Place] = []
    @Published private(set) var lists: [PlaceList] = []
    @Published private(set) var visits: [Visit] = []
    
    var visitedLists: [VisitedPlaceList] {
        return lists.compactMap { visitedList(for: $0.id) }
    }
    
    override init() {
        super.init()
        let item = MKMapItem()
        item.name = "Item"
        places = [.init(mapItem: item)]
        lists = [.init(
            id: .init(),
            title: "Things",
            places: [places.first!.id]
        )]
    }
    
    func addList(category: PlaceType, places: [Place]) {
        self.places.append(contentsOf: places)
        self.lists.append(PlaceList(id: .init(), title: category.title, places: places.map(\.id)))
    }
    
    private func list(for id: UUID) -> PlaceList? {
        lists.first(with: id)
    }
    
    func visitedList(for id: UUID) -> VisitedPlaceList? {
        guard let list = list(for: id) else { return nil }
        return VisitedPlaceList(id: id, title: list.title, places: visitedPlaces(for: list.places))
    }
    
    private func visitedPlaces(for placeIDs: [Place.ID]) -> [VisitedPlace] {
        placeIDs.compactMap { placeID in
            visitedPlace(for: placeID)
        }
    }
    
    private func visits(for place: Place.ID) -> [Visit] {
        return visits.filter { $0.place == place }
    }
    
    private func place(for id: Place.ID) -> Place? {
        places.first(with: id)
    }
    
    func visitedPlace(for id: Place.ID) -> VisitedPlace? {
        guard let place = place(for: id) else { return nil }
        return VisitedPlace(
            place: place,
            visits: visits(for: id).map(\.date)
        )
    }
    
    func markPlaceVisited(_ placeID: Place.ID) {
        visits.append(Visit(place: placeID, date: .now))
    }
    
    func unmarkPlaceVisited( _ placeID: Place.ID) {
        visits.removeAll(where: { $0.place == placeID })
    }
}

extension Array where Element: Identifiable {
    func first(with id: Element.ID) -> Element? {
        return first(where: { $0.id == id })
    }
}
