//
//  PlaceList.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import Foundation

struct PlaceList: Identifiable {
    let id: UUID
    let title: String
    let places: [Place.ID]
}
