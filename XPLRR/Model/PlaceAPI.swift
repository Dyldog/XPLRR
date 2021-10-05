//
//  PlaceAPI.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import Foundation
import MapKit

class PlaceAPI {
    static func getPlaces(in region: MKCoordinateRegion, _ category: MKPointOfInterestCategory, completion: @escaping ClosureIn<[Place]?>) {
        let request = MKLocalPointsOfInterestRequest(coordinateRegion: region)
        request.pointOfInterestFilter = .init(including: [category])
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            if let error = error {
                // Fail
                print("Error getting places: \(error.localizedDescription)")
                completion(nil)
            } else if let response = response {
                let places = response.mapItems.map { item in
                    return Place(mapItem: item)
                }
                
                completion(places)
            } else {
                print("Error getting places: No response or error returned")
                completion(nil)
            }
        }
    }
    static func getSearchRegion(completion: @escaping ClosureIn<MKCoordinateRegion>) {
        getSearchLocation { coordinate in
            completion(.init(center: coordinate, span: .init(latitudeDelta: 1, longitudeDelta: 5)))
        }
    }
        
    static func getSearchLocation(completion: @escaping ClosureIn<CLLocationCoordinate2D>) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("28 Webb Street, Coburg VIC 3058, Australia") { placemarks, error in
            if let error = error {
                // Fail
                print("Error geocoding: \(error.localizedDescription)")
            } else if let placemarks = placemarks, let placemark = placemarks.first?.location {
                completion(placemark.coordinate)
            } else {
                print("Error geocoding: No response or error returned")
            }
        }
    }
}

typealias ClosureIn<T> = (T) -> Void
typealias ClosureOut<T> = () -> T
typealias ClosureInOut<T,U> = (T) -> U
typealias Completion = () -> Void
