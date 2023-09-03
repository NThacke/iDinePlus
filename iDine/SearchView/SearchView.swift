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
    
    @State private var selectedOption = -1
    
    @ObservedObject var selectionCommunicator : SelectionCommunicator
    
    @State var refresh = false
    
    @EnvironmentObject var current : AppState
    
    
    var restaurantPartitions: [String: [RestaurantAccount]] {
            Dictionary(grouping: restaurants, by: { $0.restaurantType })
        }
    
    var body : some View {
        VStack {
            header()
            switch(selectionCommunicator.selectedOption) {
            case .DISTANCE : distanceView()
            case .CUISINE : cuisineView()
            case .ITALIAN : specialityView(restaurantType: RestaurantAccount.ITALIAN)
            case .MEXICAN :specialityView(restaurantType: RestaurantAccount.MEXICAN)
            case .JAPANESE : specialityView(restaurantType: RestaurantAccount.JAPANESE)
            case .WELCOME : welcomeView()
            }
        }
    }
    init() {
        self.selectionCommunicator = SelectionCommunicator()
    }
    
    /**
        The Header View. This contains information that is persistent independent of the selected option (of which is used to sort restaurants by).
     
        This header information is unique to the SearchView, and as such, this method is private within the overvall SearchView View.
     */
    private func header() -> some View {
        VStack {
            HStack {
                Text("Restaurants").bold()
                Spacer()
            }.padding()
            SortSelector().environmentObject(selectionCommunicator)
        }
    }
    
    /**
        The Distance View. This is the view that is displayed to the user whenever they have selected the "DISTANCE" button to sort restaurants by.
        
        Similar to other function-views (in the sense of functions which return an object conforming to the View protocol), this method is private within the Search View, as it is unique to the Search View.
     */
    private func distanceView() -> some View {
        List(restaurants.sorted(by : {$0.distance ?? 0 < $1.distance ?? 0})) {item in
            RestaurantView(restaurant: item)
        }
        .refreshable {
            Manager.loadRestaurantAccounts {
                refresh.toggle()
            }
        }
    }
    /**
        The Cuisine View. This is the view that is displayed to the user whenever they have selected the "CUISINE" button to sort restaurants by.
        
        Similar to other function-views (in the sense of functions which return an object conforming to the View protocol), this method is private within the Search View, as it is unique to the Search View.
     */
    private func cuisineView() -> some View {
        List {
            ForEach(restaurantPartitions.keys.sorted(), id: \.self) {category in
                Section(category.description) {
                    ForEach(restaurantPartitions[category]!, id: \.restaurantName) { account in
                        RestaurantView(restaurant: account)
                    }
                }
            }
        }
    }
    /**
     A SpecialityView which is used to display only a particular type of cuisine to the user.
     
     The cuisine that will be displayed is dependent upon the given field, (restaurantType)
     */
    private func specialityView(restaurantType : String) -> some View {
        VStack {
            let category = restaurantType
            HStack {
                Text(category).italic()
                Spacer()
            }.padding()
            if let restaurants = restaurantPartitions[category] {
                List{
                    ForEach(restaurants) { account in
                        RestaurantView(restaurant: account)
                    }
                }
            }
            else {
                Spacer()
                Text("It's quiet in here...").bold()
                Text("There doesn't seem to be any \(category) restaurants.").italic().foregroundColor(Color.gray)
                Spacer()
            }
        }
    }
    private func welcomeView() -> some View {
        VStack {
            Spacer()
            Text("Welcome to our app!").bold()
            Text("Choose an option above to sort restaurants by.").italic().foregroundColor(Color.gray)
            Spacer()
        }
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
            VStack(alignment : .center) {
                Spacer()
                HStack {
                    Spacer()
                    Text(restaurant.restaurantName)
                    Spacer()
                }
                Rectangle().frame(width: .infinity, height: 1).foregroundColor(Color.red)
                Text(restaurant.restaurantType)
                Spacer()
                if(distance == 0.0) {VStack{}}
                Text("\(String(format : "%.1f", distance)) mi.").padding().background(RoundedRectangle(cornerRadius:50).fill(Color.red.opacity(0.75))).foregroundColor(Color.white)
                
//                    if let address = restaurant.address {
//                        Text("\(address.description)")
//                    }
//                    else {
//                        Text("Invalid Address")
//                    }
                
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
