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
            HStack {
                Text("Restaurants").bold()
                Spacer()
                Text("(\(Manager.coordinates.lat), \(Manager.coordinates.lon))")
            }
            .padding()
            List(restaurants.sorted(by : {$0.distance ?? 0 < $1.distance ?? 0})) {item in
                RestaurantView(restaurant: item)
            }
            .refreshable {
                Manager.loadRestaurantAccounts {
                    refresh.toggle()
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
