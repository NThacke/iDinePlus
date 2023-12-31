//
//  RestaurantAccount.swift
//  iDine
//
//  Created by Nick Thacke on 7/24/23.
//

import Foundation
import SwiftUI
import MapKit

class RestaurantAccount : Codable, Identifiable {
    
    static let visible : String = "true"
    static let invisible : String = "false"
    
    //The ID of this account
    var id : String
    
    //The restaurant name associated with this account
    var restaurantName : String
    
    var address : Address?
    
    //The email associated with this account
    var email : String
    
    //The restaurant image associated with this account that is used throughout the app (client)
    private var restaurantImage : String
    
    //The layout style of this restaurant's menu
    var layoutStyle : String
    
    var visible : String
    
    var restaurantType : String
    
    
    /**
            The distance from this restaurant to the current user. This is what we can use to compare elements and sort based off distance.
     */
    var distance : Double?
    
    static let MEXICAN = "Mexican"
    static let ITALIAN = "Italian"
    static let JAPANESE = "Japanese"
    
    
    init(id : String, restaurantName : String, email : String, restaurantImage : String, layoutStyle : String, visible : String, restaurantType : String) {
        print("Inside initalizaiton of RestaurantAccount")
        self.id = id
        self.restaurantName = restaurantName
        self.email = email
        self.restaurantImage = restaurantImage
        self.layoutStyle = layoutStyle
        self.visible = visible
        self.restaurantType = restaurantType
        APIHelper.getAddress(restaurantID: id) {address in
            self.address = address
            self.calculuateDistance()
        }
    }
    
    /**
        Calculates the distance between this restaurant's address and the current user's location and stores it in the internal property self.distance
     */
    func calculuateDistance() -> Double {
        print("Inside calculatDistance()")
        if(Manager.coordinates.lat != 0 && Manager.coordinates.lon != 0) {
            if let lat = address!.latitude {
                if let lon = address!.longitude {
                    let restaurantLocation = CLLocation(latitude : lat, longitude: lon)
                    let userLocation = CLLocation(latitude: Manager.coordinates.lat, longitude: Manager.coordinates.lon)
                    self.distance = (restaurantLocation.distance(from: userLocation) * 0.000621371)
                    print("RestaurantAccount Distance is \(self.distance ?? -1)")
                    return self.distance ?? -1
                }
            }
        }
        return -1
    }
    
    static func example() -> RestaurantAccount {
        return RestaurantAccount(
            id : "EA878AD2-F77F-4096-878E-30489CE43D98",
            restaurantName : "Jose Tejas",
            email : "example@gmail.com",
            restaurantImage : exampleImage(),
            layoutStyle : "1",
            visible: "false",
            restaurantType : "Mexican"
            );
    }
    
    func image() -> UIImage? {
        return restoreImageFromBase64String(string: restaurantImage)
    }
    
    func setImage(image : UIImage) {
        restaurantImage = RestaurantAccount.imageToString(image : image)!
    }
    
    static func imageToString(image: UIImage) -> String? {
        print("Inside imageToString")
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            return imageData.base64EncodedString()
        }
        return nil
    }
    
    /**
     This functon resized the given image into the given scaled size and returns the resized image back.
     */
    static func reiszeImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    private func restoreImageFromBase64String(string : String) -> UIImage? {
        if let imageData = Data(base64Encoded: string) {
            let image = UIImage(data: imageData)
            return image
        }
        return nil
    }
    
    private static func exampleImage() -> String {
        let image = UIImage(systemName : "fork.knife.circle")!
        return imageToString(image : image)!
    }
    
    func visibility() -> Bool {
        if(visible == "true") {
            return true
        }
        return false
    }
}
