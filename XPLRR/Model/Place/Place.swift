//
//  Place.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import Foundation
import CoreLocation
import MapKit

struct Place: Identifiable {
    var id: String { "\(name) \(location.latitude) \(location.longitude)" }
    var name: String { mapItem.name ?? "NO NAME" }
    var location: CLLocationCoordinate2D { mapItem.placemark.location?.coordinate ?? .init(latitude: 0, longitude: 0) }
    let mapItem: MKMapItem
}
