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
    
    static let DISTANCE = 1
    static let CUISINE = 0
    
    func update(selection : Int) {
        self.selectedOption = selection
    }
    
    init() {
        self.selectedOption = SearchView.DISTANCE
    }
}
