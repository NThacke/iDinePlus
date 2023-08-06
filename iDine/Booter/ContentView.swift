//
//  ContentView.swift
//  iDine
//
//  Created by Nick Thacke on 7/8/23.
//
import SwiftUI
import Combine

enum ButtonState {
    case breakfast
    case lunch
    case dinner
    case unselected
}

/**
 The AppState class is used to keep track of the app's state. On bootup, the state is set to AppState.loading, and the initalizer for the AppState class handles loading on object creation.
 
 The AppState is passed as an EnvironmentObject on bootup of the App, hence, it ensures that the app loads before any other state occurs. In other words, the first method invoked inside this app would be the initalizer of the AppState Object.
 
 As such, the AppState Object loads on iinitalization, and only modifies the state once loading has finished. In the loading state, the ContentView displays a loading symbol.
 */

public class AppState : ObservableObject{
    
    public static let loading : Int = 0;
    public static let searchView : Int = 1;
    public static let menuView : Int = 2;
    
    
    /**
            The current state of the App.
     */
    @Published var state : Int
    
    /**
            The current restaurant account that the user is observing.
     */
    static var account : RestaurantAccount?
    
    
    private func load() {
        DispatchQueue.main.async {
            Manager.loadRestaurantAccounts {
                self.state = AppState.searchView
                print("Finished loading")
            }
        }
    }
    
    init() {
        self.state = AppState.loading
        load()
    }
}

/**
 Manager field which is created before the struct. The struct then referenced this objet as an @ObservedObject field.
 
 This field is a global field because the menus need to reference a manager instance, and you cannot create an instance at top-level and use it in the same top-level code as references in calls.
 */


/**
 
 The ContentView is used as a View of which all other Views are invoked. This View is constatnly keeping track of the AppState's "state" variable, and when it changes, it displays the appropriate view (depending upon the state).
 
 For example, on bootup, the AppState is invoked as the first object in the entire app. Then, it gets passed to the ContentView as an EnvironmentObject. The ContentView is constatly looking at the "state" variable, and whenevr it is modified, it immediately recognizes the change and displays the appropriate view.
 
 The ContentView is able to immediately revognize a change in the AppState' as the AppState Object conforms to ObservableObject. This is SwiftUI's way of denoting that the Object is Observable, and therefore can have its variables reflect changes to Views which are observing it.
 
 Once an object is Observable, internal fields that should be kept track of are denoted using the "@Published" modified. This is like saying that the variable is published, and can be seen externally, and any changes made to it are immediately recognized externally as well.
 
 So, in essence, we have an AppState which conforms to ObservableObject, which enables us to recognize changes made within it. The fields which we want to know updates for are denoted using the "@Published" keyword. that is, our AppState has a "state" variable that is "@Published", and any changes made to it are immediately recognized in the ContentView.
 */

struct ContentView: View {
    
    @EnvironmentObject private var current : AppState
    
    @EnvironmentObject private var manager : Manager
    
    @StateObject var deviceLocationService = DeviceLocationService.shared
    
    @State var tokens : Set<AnyCancellable> = []
    @State var coordinates : (lat : Double, lon : Double) = (0,0)
    
    
    
    var body : some View {
        VStack { //VStack ensures that we send back a View containing all of our info, rather than just the first View seen
            
            switch(current.state) {
                case AppState.menuView : MenuView()
                case AppState.searchView : SearchView()


            default : LoadingView()
            }
            
            if(current.state == 1) {
                VStack {
                }.onAppear() {
                    observeCoordinateUpdates()
                    observeCoordinateUpdates()
                    deviceLocationService.requestLocationUpdates()
                }
            } //Causes the app to refresh when current.state changes
        }
    }
    
    func observeCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure (let error) = completion {
                    print(error)
                }
            } receiveValue: { coords in
                self.coordinates = (coords.latitude, coords.longitude)
                Manager.coordinates = (coords.latitude, coords.longitude)
                print("User coords are \(coordinates)")
            }
            .store(in: &tokens)
    }
    
    func observeLocationAccessDenied() {
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Did not receive location")
            }
            .store(in: &tokens)
    }
}

/**
 
 This is a simple LoadingVIew. Whenever we are loading data, and the AppState's state variable is set to AppState.loading, then this View is shown in the ContentView. It simply shows a logo with a loading icon below it.
 */

struct LoadingView : View {
    
    @EnvironmentObject private var current : AppState
    
    var body : some View {
        VStack {
            Spacer()
            Image(systemName : "globe").foregroundColor(Color.blue)
            ProgressView().progressViewStyle(CircularProgressViewStyle())
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView().environmentObject(AppState()).environmentObject(Manager())
    }
}
