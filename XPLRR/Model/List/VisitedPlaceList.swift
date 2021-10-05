//
//  VisitedPlaceList.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import Foundation

struct VisitedPlaceList: Identifiable {
    /// Same as the ID of the place list
    let id: UUID
    let title: String
    let places: [VisitedPlace]
    
    var visitedPlaces: [VisitedPlace] { return places.filter { $0.hasVisited }}
    var isComplete: Bool { return places.allSatisfy { $0.hasVisited } }
}
