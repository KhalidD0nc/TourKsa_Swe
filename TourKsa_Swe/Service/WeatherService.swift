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
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }
                
                do {
                    print("Received data: \(String(data: data, encoding: .utf8) ?? "unable to stringify")")
                    let response = try JSONDecoder().decode(WeatherModel.WeatherResponse.self, from: data)
                    let weather = WeatherModel(
                        temperature: response.main.temp,
                        description: response.weather.first?.description ?? "Unknown",
                        cityName: response.name
                    )
                    completion(weather)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}
