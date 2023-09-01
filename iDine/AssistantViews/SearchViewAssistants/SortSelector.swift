//
//  SortSelector.swift
//  iDine
//
//  Created by Nick Thacke on 9/1/23.
//

import Foundation
import SwiftUI

struct SortSelector : View {
    
    @ObservedObject var selectionCommunicator : SelectionCommunicator
    
    var body : some View {
        
            ScrollView(.horizontal) {
                HStack {
                    Button("Distance") {
                        selectionCommunicator.update(selection : SelectionCommunicator.DISTANCE)
                    }
                    Button("Cuisine") {
                        selectionCommunicator.update(selection: SelectionCommunicator.CUISINE)
                    }
                }
            }
    }
    init(selectionCommunicator : SelectionCommunicator) {
        self.selectionCommunicator = selectionCommunicator
    }
}

class SelectionCommunicator : ObservableObject {
    
    @Published var selectedOption : Int
    
    /**
     A selection indicating to sort restaurants by distance.
     */
    static let DISTANCE = 1
    /**
     A selection indicating to sort restaurants by cuisine.
     */
    static let CUISINE = 0
    /**
     A selection indicating to show the user the welcome page -- this is displayed prior to any restaurants are shown. One benfit of this is that many "under the hood" features can be loaded, in particular, the restaurant's distance.
     */
    static let WELCOME = -1
    
    func update(selection : Int) {
        self.selectedOption = selection
    }
    
    init() {
        self.selectedOption = SearchView.WELCOME
    }
}
