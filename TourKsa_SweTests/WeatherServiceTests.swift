//
//  WeatherServiceTests.swift
//  TourKsa_SweTests
//
//  Created by Khalid R on 27/07/1446 AH.
//

import XCTest
@testable import TourKsa_Swe

class WeatherServiceTests: XCTestCase {
    
    // Mock URLProtocol for intercepting network requests
    class MockURLProtocol: URLProtocol {
        static var mockResponseData: Data?
        static var mockError: Error?
        
        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            if let error = MockURLProtocol.mockError {
                self.client?.urlProtocol(self, didFailWithError: error)
            } else if let data = MockURLProtocol.mockResponseData {
                self.client?.urlProtocol(self, didLoad: data)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {}
    }
    
    func testFetchWeather_Success() {
        // Mock response data
        let mockResponse = """
        {
            "main": {
                "temp": 25.0
            },
            "weather": [
                {
                    "description": "clear sky"
                }
            ],
            "name": "Riyadh"
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.mockResponseData = mockResponse
        MockURLProtocol.mockError = nil
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        let weatherService = WeatherService(session: session)  // Inject the mock session
        
        let expectation = XCTestExpectation(description: "Fetch weather success")
        
        weatherService.fetchWeather(for: "Riyadh") { weather in
            XCTAssertNotNil(weather, "Weather should not be nil")
            XCTAssertEqual(weather?.temperature, 25.0, "Temperature should be 25.0")
            XCTAssertEqual(weather?.description, "clear sky", "Description should be 'clear sky'")
            XCTAssertEqual(weather?.cityName, "Riyadh", "City name should be 'Riyadh'")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchWeather_Failure() {
        func testFetchWeather_Failure() {
            MockURLProtocol.mockResponseData = nil
            MockURLProtocol.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
            
            let config = URLSessionConfiguration.default
            config.protocolClasses = [MockURLProtocol.self]
            let session = URLSession(configuration: config)
            
            let weatherService = WeatherService(session: session)  // Inject the mock session
            
            
            
            let expectation = XCTestExpectation(description: "Fetch weather failure")
            
            weatherService.fetchWeather(for: "Riyadh") { weather in
                XCTAssertNil(weather, "Weather should be nil on failure")
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 5.0)
        }
    }
}
