//
//  XPLRRApp.swift
//  XPLRR
//
//  Created by Dylan Elliott on 5/10/21.
//

import SwiftUI

@main
struct XPLRRApp: App {
    var body: some Scene {
        WindowGroup {
            PlaceListsView(database: Database())
        }
    }
}
