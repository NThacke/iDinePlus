//
//  MenuView.swift
//  iDine
//
//  Created by Nick Thacke on 7/24/23.
//

import Foundation
import SwiftUI


//**
// Manager field which is created before the struct. The struct then referenced this objet as an @ObservedObject field.
//
// This field is a global field because the menus need to reference a manager instance, and you cannot create an instance at top-level and use it in the same top-level code as references in calls.
// */


struct MenuView: View {
    
    @EnvironmentObject private var current : AppState
    
    /**
     The manager which is used to pass information from view to view. Specifically, the manager is used as a way to add items to your cart and to view your cart.
     */
    
    @EnvironmentObject private var manager : Manager
    /**
        A state to denote which 'section' of menus the user is in. This field is either .breakfast, .lunch, .dinner, or .unselected
     */
    @State private var buttonState : ButtonState = .unselected
    
    /**
            The Breakfast Menu View. This is referenced as its own Object for the sake of code readability.
     */
    let breakfastMenu = BreakfastMenu()
    
    /**
            The Lunch Menu View. This is referenced as its own Object for the sake of code readability.
     */
    let lunchMenu = LunchMenu()
    
    /**
            The Dinner Menu View. This is referenced as its own Object for the sake of code readability.
     */
    let dinnerMenu = DinnerMenu()
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        HStack {
                            Image(systemName : "chevron.backward").bold()
                            Text("Back")
                        }.foregroundColor(Color.blue)
                            .onTapGesture {
                                current.state = AppState.searchView
                            }
                        Spacer()
                        Spacer()
                        NavigationLink(destination: CartView()) {
                            Image(systemName: "cart.circle")
                                .resizable()
                                .frame(width: 25, height:25)
                        }
                    }.padding()
                    
                    Text(AppState.account?.restaurantName ?? RestaurantAccount.example().restaurantName).bold()
                    logo()
                    
                    Spacer()
                    HStack {
                        breakfast()
                        Rectangle().frame(width: 0, height: 30)
                        lunch()
                        Rectangle().frame(width: 0, height: 30)
                        dinner()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.blue, lineWidth:1)).animation(.linear)
                    
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
            .popover(isPresented : manager.itemInQueueBinding) {
                CustomizeItem(item : manager.getItemInQueue()!)
            }
        }
    }
    
    func dinner() -> some View {
        HStack {
            if(buttonState == .dinner) {
                ZStack {
                    RoundedRectangle(cornerRadius: 100).foregroundColor(Color.blue).frame(width:60, height:30).overlay(Text("Dinner")).foregroundColor(Color.white)
                }
            }
            else {
                Text("Dinner").foregroundColor(Color.blue)
                Rectangle().frame(width:1, height:30).foregroundColor(Color.clear) //This makes the text in sync with the rounded rectangel surroundeing the Breakfast,lunch,dinner selection
            }
        }.onTapGesture {
            buttonState = .dinner
        }
    }
    
    /**
     This method is used to return a view which displays a button.
     Using this instead of directly inserting the view into the callee location enables modular use as well as encourages code readability.
     */
    func lunch() -> some View {
        HStack {
            if(buttonState == .lunch) {
                ZStack {
                    RoundedRectangle(cornerRadius: 100).foregroundColor(Color.blue).frame(width:60, height:30).overlay(Text("Lunch")).foregroundColor(Color.white)
                }
            }
            else {
                Rectangle().frame(width:0.5, height:30).foregroundColor(Color.clear) //This keeps the text in sync with the rounded rectangles
                Text("Lunch").foregroundColor(Color.blue)
                Rectangle().frame(width:0.5, height:30).foregroundColor(Color.clear)//This keeps the text in sync with the rounded rectangles
            }
        }.onTapGesture {
            buttonState = .lunch
        }
    }
    /**
     This method is used to return a view which displays a button.
     Using this instead of directly inserting the view into the callee location enables modular use as well as encourages code readability.
     */
    func breakfast() -> some View {
        HStack {
            if(buttonState == .breakfast) {
                ZStack {
                    RoundedRectangle(cornerRadius: 100).foregroundColor(Color.blue).frame(width:80, height:30).overlay(Text("Breakfast")).foregroundColor(Color.white)
                }
            }
            else {
                Rectangle().frame(width:1, height:30).foregroundColor(Color.clear)//This makes the text in sync with the rounded rectangel surroundeing the Breakfast,lunch,dinner selection
                Text("Breakfast").foregroundColor(Color.blue)
            }
        }.onTapGesture {
            buttonState = .breakfast
        }.overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.clear, lineWidth:1))
    }
    /**
     This method is used to return a view which displays the logo..
     Using this instead of directly inserting the view into the callee location enables modular use as well as encourages code readability.
     */
    func logo() -> some View {
        Image(uiImage: (AppState.account?.image() ?? RestaurantAccount.example().image()! ))
            .resizable()
            .frame(width:100, height:100).cornerRadius(100)
            .padding()
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(Manager())
    }
}
