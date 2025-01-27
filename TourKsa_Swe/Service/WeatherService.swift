//
//  WeatherService.swift
//  SWE_Project
//
//  Created by Khalid R on 20/03/1446 AH.
//
import Foundation

class WeatherService {
    private let apiKey = "bb531faa9bdf75eaf96dcb71914a91de"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchWeather(for city: String, completion: @escaping (WeatherModel?) -> Void) {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        session.dataTask(with: url) { data, response, error in  // Use session instead of URLSession.shared
            // ... rest of the code remains the same
        }.resume()
    }
}
