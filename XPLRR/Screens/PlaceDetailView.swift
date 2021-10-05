//
//  PlaceDetailView.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import SwiftUI
import MapKit

struct PlaceDetailView: View {
    
    @ObservedObject var database: Database
    let placeID: Place.ID
    var place: VisitedPlace { database.visitedPlace(for: placeID)! }
    @State var showConfirmUnmark: Bool = false
    
    private var mapRegion: MKMapRect {
        return MKMapRectForCoordinateRegion(
            region: MKCoordinateRegion(
                center: place.place.location,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            ))
    }
    var body: some View {
        VStack(spacing: 30) {
            Map(mapRect: .constant(mapRegion), interactionModes: [], showsUserLocation: false, annotationItems: [place]) { place in
                MapMarker(coordinate: place.place.location)
            }
            .aspectRatio(1, contentMode: .fit)
            
            Button {
                place.place.mapItem.openInMaps(launchOptions: nil)
            } label: {
                Text("Open Directions")
            }
            .buttonStyle(RaisedButtonStyle(depth: 1))
            
            Spacer()
            
            if !place.hasVisited {
                Button("Mark Visited") {
                    database.markPlaceVisited(placeID)
                }
                .buttonStyle(RaisedButtonStyle(color: .blue))
            } else {
                Button("Unmark Visited") {
                    showConfirmUnmark = true
                }
                .buttonStyle(RaisedButtonStyle(color: .red))
            }

        }
        .padding()
        .navigationTitle(place.place.name)
        .alert(
            "Unmark Visits?",
            isPresented: $showConfirmUnmark,
            actions: {
                Button(role: .cancel, action: {}, label: {
                    Text("Cancel")
                })
                
                Button(role: .destructive) {
                    database.unmarkPlaceVisited(placeID)
                } label: {
                    Text("Unmark")
                }
            },
            message: {
                Text("This will clear all of your visits and can't be undone")
            }
        )
    }
    
}


struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let database = Database()
        
        NavigationView {
            PlaceDetailView(database: database, placeID: database.places.first!.id)
        }
    }
}

func MKMapRectForCoordinateRegion(region:MKCoordinateRegion) -> MKMapRect {
    let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
    let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))

    let a = MKMapPoint(topLeft)
    let b = MKMapPoint(bottomRight)

    return MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
}
