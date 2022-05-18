//
//  Common.swift
//  SimpleWeatherApp
//
//  Created by Michael Nguyen on 5/16/22.
//

import Foundation

// MARK: - Main
struct Main: Codable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Int
    var humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

// MARK: Main convenience initializers and mutators

extension Main {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Main.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        temp: Double? = nil,
        feelsLike: Double? = nil,
        tempMin: Double? = nil,
        tempMax: Double? = nil,
        pressure: Int? = nil,
        humidity: Int? = nil
    ) -> Main {
        return Main(
            temp: temp ?? self.temp,
            feelsLike: feelsLike ?? self.feelsLike,
            tempMin: tempMin ?? self.tempMin,
            tempMax: tempMax ?? self.tempMax,
            pressure: pressure ?? self.pressure,
            humidity: humidity ?? self.humidity
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


// MARK: - Coord
struct Coord: Codable {
    var lon: Double
    var lat: Double

    enum CodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
    }
}

// MARK: Coord convenience initializers and mutators

extension Coord {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Coord.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        lon: Double? = nil,
        lat: Double? = nil
    ) -> Coord {
        return Coord(
            lon: lon ?? self.lon,
            lat: lat ?? self.lat
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Sys
struct Sys: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

// MARK: Sys convenience initializers and mutators

extension Sys {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sys.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: Int? = nil,
        id: Int? = nil,
        country: String? = nil,
        sunrise: Int? = nil,
        sunset: Int? = nil
    ) -> Sys {
        return Sys(
            type: type ?? self.type,
            id: id ?? self.id,
            country: country ?? self.country,
            sunrise: sunrise ?? self.sunrise,
            sunset: sunset ?? self.sunset
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


// MARK: - Clouds
struct Clouds: Codable {
    var all: Int

    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

// MARK: Clouds convenience initializers and mutators

extension Clouds {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Clouds.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        all: Int? = nil
    ) -> Clouds {
        return Clouds(
            all: all ?? self.all
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int
    var main: String
    var weatherDescription: String
    var icon: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
}

// MARK: Weather convenience initializers and mutators

extension Weather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weather.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        main: String? = nil,
        weatherDescription: String? = nil,
        icon: String? = nil
    ) -> Weather {
        return Weather(
            id: id ?? self.id,
            main: main ?? self.main,
            weatherDescription: weatherDescription ?? self.weatherDescription,
            icon: icon ?? self.icon
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double
    var deg: Int

    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}

// MARK: Wind convenience initializers and mutators

extension Wind {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Wind.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        speed: Double? = nil,
        deg: Int? = nil
    ) -> Wind {
        return Wind(
            speed: speed ?? self.speed,
            deg: deg ?? self.deg
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
