//
//  PlaceServiceTests.swift
//  TourKsa_SweTests
//
//  Created by Khalid R on 27/07/1446 AH.
//

import XCTest
@testable import TourKsa_Swe

final class PlaceServiceTests: XCTestCase {
    func testLoadLocalData() {
        let placeService = PlaceService()
        placeService.loadLocalData()
        
        // Ensure the places are loaded correctly
        XCTAssertFalse(placeService.allPlaces.isEmpty, "Places should not be empty after loading local data.")
        print("DEBUG: Loaded places count: \(placeService.allPlaces.count)")
    }
    
}
