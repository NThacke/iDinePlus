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

/**
 Manager field which is created before the struct. The struct then referenced this objet as an @ObservedObject field.
 
 This field is a global field because the menus need to reference a manager instance, and you cannot create an instance at top-level and use it in the same top-level code as references in calls.
 */
var manager = Manager()


struct ContentView: View {
    /**
        A state to denote which 'section' of menus the user is in. This field is either .breakfast, .lunch, .dinner, or .unselected
     */
    @State private var buttonState : ButtonState = .unselected
    
    /**
     The manager which is used to pass information from view to view. Specifically, the manager is used as a way to add items to your cart and to view your cart.
     */
    @ObservedObject var observedManager = manager
    
    /**
            The Breakfast Menu View. This is referenced as its own Object for the sake of code readability.
     */
    let breakfastMenu = BreakfastMenu(manager : manager)
    
    /**
            The Lunch Menu View. This is referenced as its own Object for the sake of code readability.
     */
    let lunchMenu = LunchMenu(manager: manager)
    
    /**
            The Dinner Menu View. This is referenced as its own Object for the sake of code readability.
     */
    let dinnerMenu = DinnerMenu(manager: manager)
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Spacer()
                        NavigationLink(destination: CartView(manager : manager)) {
                            Image(systemName: "cart.circle")
                                .resizable()
                                .frame(width: 25, height:25).padding()
                        }
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
            .popover(isPresented : observedManager.itemInQueueBinding) {
                CustomizeItem(manager : manager, item : manager.getItemInQueue()!)
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
