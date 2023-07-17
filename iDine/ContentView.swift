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

public var cart = Cart()

struct ContentView: View {
    @State private var buttonState : ButtonState = .unselected
    
    private var breakfastMenu = BreakfastMenu()
    
    private var lunchMenu = LunchMenu()
    
    private var dinnerMenu = DinnerMenu()
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    cartButton()
                }
                logo()
                
                Spacer()
                HStack {
                    breakfast()
                    lunch()
                    dinner()
                }
                
                NavigationView {
                    
                    if buttonState == .breakfast {
                        breakfastMenu
                    }
                    else if buttonState == .lunch {
                        lunchMenu
                    }
                    else if buttonState == .dinner {
                        dinnerMenu
                    }
                }
            }
        }
    }
    
    func dinner() -> some View {
        Button("Dinner", action : {
            buttonState = .dinner
        })
        .foregroundColor(buttonState == .dinner ? Color.black : Color.blue)
    }
    
    /**
     This method is used to return a view which displays a button.
     Using this instead of directly inserting the view into the callee location enables modular use as well as encourages code readability.
     */
    func lunch() -> some View {
        Button("Lunch", action : {
            buttonState = .lunch
        })
        .foregroundColor(buttonState == .lunch ? Color.black : Color.blue)
    }
    /**
     This method is used to return a view which displays a button.
     Using this instead of directly inserting the view into the callee location enables modular use as well as encourages code readability.
     */
    func breakfast() -> some View {
        Button("Breakfast", action : {
            buttonState = .breakfast
        })
        .foregroundColor(buttonState == .breakfast ? Color.black : Color.blue)
    }
    /**
     This method is used to return a view which displays the logo..
     Using this instead of directly inserting the view into the callee location enables modular use as well as encourages code readability.
     */
    func logo() -> some View {
        Image(systemName: "fork.knife.circle")
            .resizable()
            .padding()
            .frame(width:100, height:100)
    }
    /**
     This method is used to return a view which displays a button.
     Using this instead of directly inserting the view into the callee location enables modular use as well as encourages code readability.
     */
    func cartButton() -> some View {
        Button(action : {
            
        }) {
            Image(systemName: "cart.circle")
                .resizable()
                .frame(width: 25, height:25)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
