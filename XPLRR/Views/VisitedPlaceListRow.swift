//
//  VisitedPlaceListRow.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import SwiftUI

struct VisitedPlaceListRow: View {
    let list: VisitedPlaceList
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(list.title)
            
            let totalCount = list.places.count
            let visitedCount = list.visitedPlaces.count
            let remainingCount = totalCount - visitedCount
            let ratio = Double(visitedCount) / Double(totalCount)
            
            let subitle: String = {
                if ratio == 1 {
                    return "All \(totalCount) places visited"
                } else if ratio < 0.5 {
                    return "\(visitedCount) of \(totalCount) places visited"
                } else {
                    return "\(remainingCount) places of \(totalCount) left to visit"
                }
            }()
            
            Text(subitle)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct VisitedPlaceListRow_Previews: PreviewProvider {
    static var previews: some View {
        VisitedPlaceListRow(list: VisitedPlaceList(id: .init(), title: "List", places: []))
    }
}
