//
//  ContentView.swift
//  iDine
//
//  Created by Nick Thacke on 7/8/23.
//

import SwiftUI

enum ButtonState {
    case breakfast
    case lunch
    case dinner
    case unselected
}
struct ContentView: View {
    @State private var buttonState : ButtonState = .unselected
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    Button(action : {
                        
                    }) {
                        Image(systemName: "cart.circle")
                            .resizable()
                            .frame(width: 25, height:25)
                    }
                    .padding()
                }
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .padding()
                    .frame(width:100, height:100)
                Spacer()
                HStack {
                    Button("Breakfast", action : {
                        buttonState = .breakfast
                    })
                    .foregroundColor(buttonState == .breakfast ? Color.red : Color.blue)
                    Button("Lunch", action : {
                        buttonState = .lunch
                    })
                    .foregroundColor(buttonState == .lunch ? Color.gray : Color.blue)
                    Button("Dinner", action : {
                        buttonState = .dinner
                    })
                    .foregroundColor(buttonState == .dinner ? Color.black : Color.blue)
                }
                
                NavigationStack {
                    
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
