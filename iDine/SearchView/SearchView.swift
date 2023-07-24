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
    
    @State var refresh = false
    
    var body : some View {
        VStack {
            List {
                ForEach(restaurants) { restaurant in
                    RestaurantView(restaurant: restaurant)
                }
            }
        }
    }
}

struct RestaurantView : View {
    
    @EnvironmentObject var current : AppState
    
    var restaurant : RestaurantAccount
    
    var body : some View {
        
        VStack {
            HStack {
                
                Image(uiImage : restaurant.image() ?? RestaurantAccount.example().image()!)
                
                Text(restaurant.restaurantName)
            }.onTapGesture {
                current.state = AppState.menuView
                AppState.account = restaurant.id
            }
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
