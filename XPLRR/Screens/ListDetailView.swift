//
//  ListDetailView.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import SwiftUI

struct ListDetailView: View {
    @ObservedObject var database: Database
    let listID: UUID
    var list: VisitedPlaceList { database.visitedList(for: listID)! }
    var visitedPlaces: [VisitedPlace] { list.places.filter { $0.hasVisited }}
    var unvisitedPlaces: [VisitedPlace] { list.places.filter { !$0.hasVisited }}
    
    var body: some View {
        List {
            makeSection(unvisitedPlaces, title: "Unvisited", emptyText: "None")
            makeSection(visitedPlaces, title: "Visited", emptyText: "None... yet")
        }
        .navigationTitle(list.title)
    }
    
    @ViewBuilder
    private func makeSection(_ places: [VisitedPlace], title: String, emptyText: String) -> some View {
        Section(title) {
            if !places.isEmpty {
                ForEach(places) { place in
                    NavigationLink {
                        PlaceDetailView(database: database, placeID: place.id)
                    } label: {
                        Text(place.place.name)
                            .lineLimit(2)
                    }
                }
            } else {
                Text(emptyText)
                    .foregroundColor(.secondary)
            }
        }
    }
}
