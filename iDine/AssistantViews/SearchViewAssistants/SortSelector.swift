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
            
        VStack {
            Text("Sort")
            ScrollView(.horizontal) {
                HStack {
                    DistanceButton(selectionCommunicator : selectionCommunicator)
                    CuisineButton(selectionCommunicator : selectionCommunicator)
                }
            }
        }
    }
    init(selectionCommunicator : SelectionCommunicator) {
        self.selectionCommunicator = selectionCommunicator
    }
}

struct DistanceButton : View {
    @ObservedObject var selectionCommunicator : SelectionCommunicator
    
    var body : some View {
        
        if(selectionCommunicator.selectedOption == SelectionCommunicator.DISTANCE) {
            Text("Distance")
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                    .fill(Color.blue) // Set the background color
                )
                .foregroundColor(.white) // Set the text color
        }
        else {
            Button("Distance") {
                selectionCommunicator.selectedOption = SelectionCommunicator.DISTANCE
            }.padding(10)
        }
    }
    init(selectionCommunicator : SelectionCommunicator) {
        self.selectionCommunicator = selectionCommunicator
    }
}

struct CuisineButton : View {
    @ObservedObject var selectionCommunicator : SelectionCommunicator
    
    var body : some View {
        
        if(selectionCommunicator.selectedOption == SelectionCommunicator.CUISINE) {
            Text("Cuisine")
                .padding(10)  // Add padding to the text
                .background(
                    RoundedRectangle(cornerRadius: 50)
                    .fill(Color.blue) // Set the background color
                )
                .foregroundColor(.white) // Set the text color
        }
        else {
            Button("Cuisine") {
                selectionCommunicator.selectedOption = SelectionCommunicator.CUISINE
            }.padding(10)
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
        self.selectedOption = SelectionCommunicator.WELCOME
    }
}
