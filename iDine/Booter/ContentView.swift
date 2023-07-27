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



struct ContentView: View {
    
    @EnvironmentObject private var current : AppState
    
    @EnvironmentObject private var manager : Manager
    
    var body : some View {
        VStack { //VStack ensures that we send back a View containing all of our info, rather than just the first View seen
            
            if(current.state == 0) {} //Causes the app to refresh when current.state changes
            
            switch(current.state) {
                case AppState.menuView : MenuView()
                case AppState.searchView : SearchView()
                
                
            default : LoadingView()
            }
        }
    }
}

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
