// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecast = try Forecast(json)

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    var coord: Coord
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int

    enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}

// MARK: Forecast convenience initializers and mutators

extension Forecast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Forecast.self, from: data)
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
        coord: Coord? = nil,
        weather: [Weather]? = nil,
        base: String? = nil,
        main: Main? = nil,
        visibility: Int? = nil,
        wind: Wind? = nil,
        clouds: Clouds? = nil,
        dt: Int? = nil,
        sys: Sys? = nil,
        timezone: Int? = nil,
        id: Int? = nil,
        name: String? = nil,
        cod: Int? = nil
    ) -> Forecast {
        return Forecast(
            coord: coord ?? self.coord,
            weather: weather ?? self.weather,
            base: base ?? self.base,
            main: main ?? self.main,
            visibility: visibility ?? self.visibility,
            wind: wind ?? self.wind,
            clouds: clouds ?? self.clouds,
            dt: dt ?? self.dt,
            sys: sys ?? self.sys,
            timezone: timezone ?? self.timezone,
            id: id ?? self.id,
            name: name ?? self.name,
            cod: cod ?? self.cod
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
