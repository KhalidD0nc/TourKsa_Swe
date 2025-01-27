//
//  PlaceServicePerformanceTests.swift
//  TourKsa_SweTests
//
//  Created by Khalid R on 27/07/1446 AH.
//

import XCTest
@testable import TourKsa_Swe

class PlaceServicePerformanceTests: XCTestCase {
    func testPlaceLoadingPerformance() {
        let placeService = PlaceService()
        
        // Using measure block to test performance
        measure(metrics: [
            XCTClockMetric(),       // Measures wall clock time
            XCTMemoryMetric(),      // Measures memory usage
            XCTCPUMetric()          // Measures CPU usage
        ]) {
            // Loading local data
            placeService.loadLocalData()
            
            // Verify data was actually loaded
            XCTAssertFalse(placeService.allPlaces.isEmpty, "Places should be loaded")
            
            // Test accessing different aspects of the loaded data
            for place in placeService.allPlaces {
                _ = place.name
                _ = place.description
                _ = place.images
                _ = place.location
            }
        }
        
        // Add baseline assertions
        XCTAssertLessThan(
            Double(placeService.allPlaces.count), 1000,
            "Data set size should remain manageable"
        )
    }
}
