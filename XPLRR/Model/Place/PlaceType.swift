//
//  PlaceType.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import Foundation
import MapKit

struct PlaceType: Identifiable {
    var id: String { mkType.rawValue }
    var title: String {
        let raw = mkType.rawValue
        return raw
            .replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression, range: (raw.startIndex..<raw.endIndex))
            .replacingOccurrences(of: "MKPOICategory", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    let mkType: MKPointOfInterestCategory
    
    private static var mkTypes: [MKPointOfInterestCategory] = { [
        .airport,
        .amusementPark,
        .aquarium,
        .atm,
        .bakery,
        .bank,
        .beach,
        .brewery,
        .cafe,
        .campground,
        .carRental,
        .evCharger,
        .fireStation,
        .fitnessCenter,
        .foodMarket,
        .gasStation,
        .hospital,
        .hotel,
        .laundry,
        .library,
        .marina,
        .movieTheater,
        .museum,
        .nationalPark,
        .nightlife,
        .park,
        .parking,
        .pharmacy,
        .police,
        .postOffice,
        .publicTransport,
        .restaurant,
        .restroom,
        .school,
        .stadium,
        .store,
        .theater,
        .university,
        .winery,
        .zoo
    ]}()
    
    static var allCases: [PlaceType] = {
        mkTypes.map { .init(mkType: $0) }
    }()
}
