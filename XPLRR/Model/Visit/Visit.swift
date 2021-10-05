//
//  Visit.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import Foundation

struct Visit {
    var id: String { "\(place.description) \(date.description)" }
    let place: Place.ID
    let date: Date
}
