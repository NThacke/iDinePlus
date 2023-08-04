//
//  Address.swift
//  iDine
//
//  Created by Nick Thacke on 8/4/23.
//

import Foundation
import MapKit

class Address : Codable, CustomStringConvertible {
    
    /**
        The address line associated with this address. An example would be "14 Birch Lane" for the address of "14 Birch Lane, Eatontown, NJ, 07724, US"
     */
    var line : String
    /**
            The administrative area assocaited with an address. An example would be "Eatontown" in the address of "14 Birch Lane, Eatontown, NJ, 07724, US". Essenttially, this is the town of the address (if region is US)
     */
    
    var administrativeArea : String
    
    /**
            The locality associated with this address. An example would be "NJ" in the address of "14 Birch Lane, Eatontown, NJ, 07724, US" Essentailly, this is the state associated with an address (if region is US)
     */
    
    var locality : String
    
    /**
            The postal code / zip code of an address. An example would be "07724" for the address of "14 Birch Lane, Eatontown, NJ, 07724, US"
     */
    
    var postalCode : String
    
    /**
            The region assocaited with an address. The region is the country. For example, the region of "14 Birch Lane, Eatontown, NJ, 07724, US" is "US".
     */
    
    var region : String
    
    var longitude : Double?
    
    var latitude : Double?
    
    /**
     The description of an Address Object. This property must be defined to conform to the "CustomStringConvertible" protocol.
     
        By conforming to this protocol, we are allowing ourselves to invoke an Address Object inside a print statement  and have the String representation be displayed.
     
     For example, we could invoke :
     
        print(Address.example())
     
     And the print statement would print "14 Birch Lane, Eatontown, NJ, 07724, US"
     */
    
    var description: String {
        return "\(line), \(administrativeArea), \(locality), \(postalCode), \(region)"
    }
    
    var lat_long : String {
        return "(\(latitude ?? -1), \(longitude ?? -1))"
    }
    
    
    init(line : String, administrativeArea : String, locality : String, postalCode : String, region : String) {
        
        self.line = line
        self.administrativeArea = administrativeArea
        self.locality = locality
        self.postalCode = postalCode
        self.region = region
        
        geocode() {}
    }
    
    func geocode(completion : @escaping () -> Void) {
        print("Inside geocode")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("\(description)") {(placemarks, error) in
            if let error = error {
                print("Geocoding error : \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                if let location = placemark.location {
                    let coord = location.coordinate
                    self.latitude = coord.latitude
                    self.longitude = coord.longitude
                    
                    print("(\(coord.latitude), \(coord.longitude))")
                    completion()
                }
            }
                      
        }
    }
    
    static func example() -> Address {
        return Address(line : "14 Birch Lane", administrativeArea: "Eatontown", locality: "NJ", postalCode: "07724", region: "US")
    }
}
