//
//  PlaceSearchView.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import SwiftUI

struct PlaceTypesList: View {
    let completion: ClosureIn<PlaceType>
    
    var body: some View {
        NavigationView {
            List(PlaceType.allCases) { category in
                Button {
                    completion(category)
                } label: {
                    HStack {
                        Text(category.title)
                        Spacer()
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .navigationTitle("Select Category")
            }
        }
    }
}



struct PlaceSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceTypesList(completion: { _ in })
    }
}
