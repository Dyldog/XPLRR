//
//  VisitedPlace.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import Foundation

struct VisitedPlace: Identifiable {
    var id: Place.ID { place.id }
    let place: Place
    let visits: [Date]
    
    var hasVisited: Bool { !visits.isEmpty }
}
