import Foundation

// MARK: - Weather
struct WeatherResponse: Codable {
    var location: Location?
    var current: Current?
    var forecast: Forecast?
}

// MARK: - Current
struct Current: Codable {
    var temp: Int?
    var condition: Condition?
    var pressure, humidity: Int?
    var feelslike: Double?
    var visibility: Int?

    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case condition
        case pressure = "pressure_mb"
        case humidity
        case feelslike = "feelslike_c"
        case visibility = "vis_km"
    }
}

// MARK: - Condition
struct Condition: Codable {
    var text, icon: String?
}

// MARK: - Forecast
struct Forecast: Codable {
    var forecastday: [ForecastDay]?
}

// MARK: - Forecastday
struct ForecastDay: Codable {
    var dateEpoch: TimeInterval?
    var day: Day?
    var hour: [Hour]?
    
    enum CodingKeys: String, CodingKey {
        case dateEpoch = "date_epoch"
        case day, hour
    }
}

// MARK: - Day
struct Day: Codable {
    var maxtemp, mintemp, avgtemp: Double?
    var condition: Condition?

    enum CodingKeys: String, CodingKey {
        case maxtemp = "maxtemp_c"
        case mintemp = "mintemp_c"
        case avgtemp = "avgtemp_c"
        case condition
    }
}

// MARK: - Hour
struct Hour: Codable {
    var epoch: TimeInterval?
    var time: String?
    var temp: Double?
    var condition: Condition?

    enum CodingKeys: String, CodingKey {
        case epoch = "time_epoch"
        case temp = "temp_c"
        case time, condition
    }
}

// MARK: - Location
struct Location: Codable {
    var name, country: String?
    var lat, lon: Double?
    var tzID, localtime: String?

    enum CodingKeys: String, CodingKey {
        case name, country, lat, lon
        case tzID = "tz_id"
        case localtime
    }
}
