//
//  ContentView.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import SwiftUI
import MapKit

struct PlaceListsView: View {
    @ObservedObject var database: Database
    
    @State var showLoading: Bool = false
    @State var showAddList: Bool = false
    
    var lists: [VisitedPlaceList] { database.visitedLists }
    var incompleteLists: [VisitedPlaceList] { lists.filter { !$0.isComplete } }
    var completedLists: [VisitedPlaceList] { lists.filter { $0.isComplete } }
    
    var body: some View {
        LoadingView(isShowing: $showLoading) {
            NavigationView {
                List {
                    Section {
                        ForEach(incompleteLists) { list in
                            NavigationLink {
                                ListDetailView(database: database, listID: list.id)
                            } label: {
                                VisitedPlaceListRow(list: list)
                            }

                        }
                    }
                    
                    Section("Completed") {
                        ForEach(completedLists) { list in
                            NavigationLink {
                                ListDetailView(database: database, listID: list.id)
                            } label: {
                                VisitedPlaceListRow(list: list)
                            }

                        }
                    }
                    
                    Section {
                        Button {
                            showAddList = true
                        } label: {
                            Text("Add List")
                        }
                        .buttonStyle(RaisedButtonStyle(depth: 1))
                        .listRowBackground(EmptyView())

                    }
                }
                .navigationTitle("XPLRR")
                .popover(isPresented: $showAddList) {
                    PlaceTypesList { category in
                        showAddList = false
                        showLoading = true
                        addPlacesList(category) {
                            showLoading = false
                        }
                    }
                }
            }
        }
    }
    
    private func addPlacesList(_ category: PlaceType, completion: @escaping Completion) {
        PlaceAPI.getSearchRegion { region in
            PlaceAPI.getPlaces(in: region, category.mkType) { places in
                guard let places = places else {
                    completion()
                    return
                }
                
                database.addList(category: category, places: places)
                completion()
            }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListsView(database: Database())
    }
}
