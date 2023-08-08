//
//  SearchView.swift
//  iDine
//
//  Created by Nick Thacke on 7/24/23.
//

import Foundation
import SwiftUI

struct SearchView : View {
    
    @State var restaurants = Manager.restaurants ?? Manager.exampleRestaurants()
    
    let options = ["Cuisine", "Distance"]
    
    private static let DISTANCE = 1
    private static let CUISINE = 0
    
    @State private var selectedOption = -1
    
    @State var refresh = false
    
    
    var restaurantPartitions: [String: [RestaurantAccount]] {
            Dictionary(grouping: restaurants, by: { $0.restaurantType })
        }
    
    var body : some View {
        VStack {
            HStack {
                Text("Restaurants").bold()
                Spacer()
                
                HStack {
                    Text("Sort by :")
                    Picker("Select", selection : $selectedOption) {
                        ForEach(0..<options.count) {index in
                            Text(self.options[index]).tag(index);
                        }
                    }
                    Text(selectedOption.description)
                }.padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth : 1))
            }
            .padding()
            if(selectedOption == SearchView.DISTANCE) {
                List(restaurants.sorted(by : {$0.distance ?? 0 < $1.distance ?? 0})) {item in
                    RestaurantView(restaurant: item)
                }
                .refreshable {
                    Manager.loadRestaurantAccounts {
                        refresh.toggle()
                    }
                }
            }
            else if(selectedOption == SearchView.CUISINE) {
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
            
        }
    }
}

struct RestaurantView : View {
    
    @EnvironmentObject var current : AppState
    
    var restaurant : RestaurantAccount
    
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
                if let distance = restaurant.distance {
                    let formatted = String(format : "%.1f", distance)
                    Text("\(formatted) mi.")
                }
                else {
                    Text("-1 mi.")
                }
                Spacer()
            }
        }
        .onTapGesture {
            current.state = AppState.menuView
            AppState.account = restaurant
        }
    }
    
    
    init(restaurant : RestaurantAccount) {
        self.restaurant = restaurant
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
