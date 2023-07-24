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


class AppState : ObservableObject{
    
    static let loading : Int = 0;
    static let searchView : Int = 1;
    static let menuView : Int = 2;
    
    @Published var state : Int
    
    
    func load() {
        print(self.state)
        DispatchQueue.main.async {
            Manager.loadRestaurantAccounts {
                self.state = AppState.menuView
                print("Done loading restaurant accounts")
                print(self.state)
            }
        }
    }
    
    init() {
        print("Inside init of AppState")
        self.state = AppState.loading
        print("Current state is \(state)")
        load()
    }
}

/**
 Manager field which is created before the struct. The struct then referenced this objet as an @ObservedObject field.
 
 This field is a global field because the menus need to reference a manager instance, and you cannot create an instance at top-level and use it in the same top-level code as references in calls.
 */
var manager = Manager()


struct ContentView: View {
    
    @EnvironmentObject private var current : AppState
    
    var body : some View {
        VStack {
            
            if(current.state == 0) {} //Causes the app to refresh when current.state changes
            
            switch(current.state) {
            case AppState.menuView : MenuView()
                
                
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
    
    static let current : AppState = AppState()
    
    static var previews: some View {
        ContentView().environmentObject(current)
    }
}
