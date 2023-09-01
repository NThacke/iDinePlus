//
//  SearchView.swift
//  iDine
//
//  Created by Nick Thacke on 7/24/23.
//

import Foundation
import SwiftUI

/**
 This View is the SearchView in which all restaurants can be searched from.
 
 
 */

struct SearchView : View {
    
    @State var restaurants = Manager.restaurants ?? Manager.exampleRestaurants()
    
    let options = ["Cuisine", "Distance"]
    
    @State private var selectedOption = -1
    
    @ObservedObject var selectionCommunicator : SelectionCommunicator
    
    @State var refresh = false
    
    @EnvironmentObject var current : AppState
    
    
    var restaurantPartitions: [String: [RestaurantAccount]] {
            Dictionary(grouping: restaurants, by: { $0.restaurantType })
        }
    
    var body : some View {
        VStack {
            HStack {
                Text("Restaurants").bold()
                SortSelector(selectionCommunicator: self.selectionCommunicator).padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth : 1)).frame(width:100, height : .infinity)
            }
            .padding()
            if(selectionCommunicator.selectedOption == SelectionCommunicator.DISTANCE) {
                List(restaurants.sorted(by : {$0.distance ?? 0 < $1.distance ?? 0})) {item in
                    RestaurantView(restaurant: item)
                }
                .refreshable {
                    Manager.loadRestaurantAccounts {
                        refresh.toggle()
                    }
                }
            }
            else if(selectionCommunicator.selectedOption == SelectionCommunicator.CUISINE) {
                VStack {
                    ForEach(restaurantPartitions.keys.sorted(), id: \.self) { category in
                        Section(header: Text(category)) {
                            ForEach(restaurantPartitions[category]!, id: \.restaurantName) { account in
                                Text(account.restaurantName)
                            }
                        }
                    }
                }
            }
            else if(selectionCommunicator.selectedOption == SelectionCommunicator.WELCOME) {
                Welcome()
            }
            Text("\(selectionCommunicator.selectedOption)")
            
        }
    }
    init() {
        self.selectionCommunicator = SelectionCommunicator()
    }
}

struct RestaurantView : View {
    
    @EnvironmentObject var current : AppState
    
    var restaurant : RestaurantAccount
    
    @State var distance : Double
    
    var body : some View {
        
        HStack {
            VStack {
                Image(uiImage : restaurant.image() ?? RestaurantAccount.example().image()!).resizable().frame(width: 50, height : 50).cornerRadius(100)
            }
            VStack {
                Spacer()
                Text(restaurant.restaurantName)
                Text(restaurant.restaurantType)
                Spacer()
                if(distance == 0.0) {VStack{}}
                Text("\(String(format : "%.1f", distance)) mi.")
                
                    if let address = restaurant.address {
                        Text("\(address.description)")
                    }
                    else {
                        Text("Invalid Address")
                    }
                
                if let lat = restaurant.address?.latitude {
                    Text("\(lat)")
                }
                else {
                    Text("Invalid lat")
                }
                if let long = restaurant.address?.longitude {
                    Text("\(long)")
                }
                else {
                    Text("Invalid longitutede")
                }
                
                Spacer()
            }
        }
        .onTapGesture {
            current.state = AppState.menuView
            AppState.account = restaurant
        }
        .onAppear {
            print("The Distance is \(distance)")
        }
    }
    
    
    init(restaurant : RestaurantAccount) {
        self.restaurant = restaurant
        self.distance = restaurant.calculuateDistance()
    }
}

class RestaurantInfo : ObservableObject {
    
    @State var distance : Double?
    
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
