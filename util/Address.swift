//
//  Address.swift
//  iDine
//
//  Created by Nick Thacke on 8/4/23.
//

import Foundation

class Address : Codable {
    
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
    
    
    init(line : String, administrativeArea : String, locality : String, postalCode : String, region : String) {
        self.line = line
        self.administrativeArea = administrativeArea
        self.locality = locality
        self.postalCode = postalCode
        self.region = region
    }
    
    static func example() -> Address {
        return Address(line : "14 Birch Lane", administrativeArea: "Eatontown", locality: "NJ", postalCode: "07724", region: "US")
    }
}
