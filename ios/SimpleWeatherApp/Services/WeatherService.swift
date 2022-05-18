//
//  WeatherService.swift
//  SimpleWeatherApp
//
//  Created by Michael Nguyen on 5/16/22.
//

import Foundation
@objc public class WeatherService: NSObject {
    @objc public static let shared = WeatherService()
    var apiKey: String = ""

    var errorMessage: String? = ""

    private override init() {

    }

    let baseUri = "https://api.openweathermap.org/data/2.5"

    func initWithApiKey(_ key: String) {
        apiKey = key
    }

    private func getData(endpoint: String, completion: @escaping (Data?, URLResponse?, NSError?) -> Void) {
        let urlString = baseUri + endpoint + "&appid=\(apiKey)&units=imperial"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error as NSError?)

        }

        task.resume()
    }

    // MARK: - current weather requests

    func currentWeather(city: String, completion: @escaping (Bool, WeatherConditions?, Error?) ->Void) {
        guard let cityName = city.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { return }
        let endpoint = "/weather?q=\(cityName)"

        getData(endpoint: endpoint) { data, response, error in
            if let error = error {
                self.errorMessage = (self.errorMessage ?? "") + "DataTask error: " + error.localizedDescription + "\n"
                completion(false, nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200 ... 299).contains(response.statusCode)
            {
                do {
                    let decoder = JSONDecoder()
                    let jsonResults = try decoder.decode(WeatherConditions.self, from: data)
                    completion(true, jsonResults, nil)
                }
                catch let error {
                    print(error)
                    completion(false, nil, error)
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
                completion(false, nil, error)
            }
        }


    }

    func currentWeather(coordinates: Coord, completion: @escaping(Bool) -> Void) {

    }

    func currentWeather(cityId: String, completion: @escaping(Bool) -> Void) {

    }

    // MARK: - forecast requests
    @objc func forecastWeatherRN(city: String,numDays: Int, completion: @escaping (Bool, Data?) -> Void) {
        guard let cityName = city.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { return }
        let endpoint = "/forecast?q=\(cityName)&cnt=\(numDays)"

        getData(endpoint: endpoint) { data, response, error in
            if let error = error {
                self.errorMessage = "DataTask error: " + error.localizedDescription + "\n"
                completion(false, nil)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200 ... 299).contains(response.statusCode)
            {
                completion(true, data)
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
    }

    func forecastWeather(cityName: String, numDays: Int, completion: @escaping (Bool, Forecast?) -> Void) {
        forecastWeatherRN(city: cityName, numDays: numDays) { success, data in
            do {
                guard let data = data else {
                    return
                }
                let decoder = JSONDecoder()
                let jsonResults = try decoder.decode(Forecast.self, from: data)
                completion(success, jsonResults)
            }
            catch let error {
                print(error)
            }

        }

    }

    func forecastWeather(coordinates: Coord, numDays: Int, completion: @escaping (Bool, Forecast) -> Void) {

    }

    func forecastWeather(cityId: String, numDays: Int, completion: @escaping (Bool, Forecast?) -> Void) {
        let endpoint = "/forecast?id=\(cityId)&cnt=\(numDays)"

        getData(endpoint: endpoint) { data, response, error in
            if let error = error {
                self.errorMessage = "DataTask error: " + error.localizedDescription + "\n"
                completion(false, nil)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200 ... 299).contains(response.statusCode)
            {
                do {
                    let decoder = JSONDecoder()
                    let jsonResults = try decoder.decode(Forecast.self, from: data)
                    completion(true, jsonResults)
                }
                catch let error {
                    print(error)
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }

    }
}
