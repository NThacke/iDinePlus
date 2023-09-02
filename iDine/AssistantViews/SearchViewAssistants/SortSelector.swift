//
//  SortSelector.swift
//  iDine
//
//  Created by Nick Thacke on 9/1/23.
//

import Foundation
import SwiftUI

struct SortSelector : View {
    
    @EnvironmentObject var selectionCommunicator : SelectionCommunicator
    
    var body : some View {
        ScrollView(.horizontal) {
            HStack {
                SelectionButton(selection : .DISTANCE)
                SelectionButton(selection : .CUISINE)
                SelectionButton(selection : .MEXICAN)
                SelectionButton(selection: .ITALIAN)
                SelectionButton(selection: .JAPANESE)
                SelectionButton(selection: .WELCOME)
            }.padding()
        }.scrollIndicators(ScrollIndicatorVisibility.hidden)
    }
}

private struct SelectionButton : View {
    @EnvironmentObject var selectionCommunicator : SelectionCommunicator
    var selection : Selection
    
    var body : some View {
        
        if(selectionCommunicator.selectedOption == selection) {
            Text(selection.description)
                .padding(10)  // Add padding to the text
                .background(
                    RoundedRectangle(cornerRadius: 50)
                    .fill(Color.blue) // Set the background color
                )
                .foregroundColor(.white) // Set the text color
        }
        else {
            Button(selection.description) {
                selectionCommunicator.selectedOption = selection
            }.padding(10)
        }
    }
    
    init(selection: Selection) {
        self.selection = selection
    }
}

class SelectionCommunicator : ObservableObject {
    
    @Published var selectedOption : Selection
    
    func update(selection : Selection) {
        self.selectedOption = selection
    }
    
    init() {
        self.selectedOption = .WELCOME
    }
}

enum Selection : CustomStringConvertible {
    case DISTANCE
    case CUISINE
    case WELCOME
    case ITALIAN
    case MEXICAN
    case JAPANESE
    
    var description: String {
        switch self {
        case .CUISINE : return "Cuisine"
        case .DISTANCE : return "Distance"
        case .WELCOME : return "Welcome"
        case .ITALIAN : return "Italian"
        case .MEXICAN : return "Mexican"
        case .JAPANESE : return "Japanese"
        }
    }
}
