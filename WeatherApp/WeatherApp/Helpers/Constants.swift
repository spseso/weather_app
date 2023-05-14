//
//  Constants.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import SwiftUI

struct Constants {
    static let openWeatherMapApiKey = "c6c9c6d0a0691bf5606772dd7d8a84d8"
}

struct Colors {
    static let appPrimaryColor = SwiftUI.Color(red: 180 / 255, green: 214 / 255, blue: 238 / 255)
    static let appSecondColor = SwiftUI.Color(red: 121 / 255, green: 231 / 255, blue: 209 / 255)
    static let lightBlueColor = SwiftUI.Color(red: 87 / 255, green: 209 / 255, blue: 240 / 255)
    static let meduimBlueColor = SwiftUI.Color(red: 59 / 255, green: 164 / 255, blue: 237 / 255)
    static let darkBlueColor = SwiftUI.Color(red: 17 / 255, green: 74 / 255, blue: 170 / 255)
    static let gradient = [lightBlueColor.opacity(0.8), darkBlueColor.opacity(0.8)]
    static let gradientAPP = [appPrimaryColor, appSecondColor]
}

struct Strings {
    static let windSpeed = "Wind speed"
    static let humidity = "Humidity"
    static let okButtonTitle = "Ok"
    static let currentLocation = "Current Location"
}

struct ErrorStrings {
    static let notFoundCityError = "City with this name not found"
    static let somethingWrongError = "Something Went Wrong"
}

struct ApiKeysConstants {
    static let acceptableStatusCodes = Range(200...299)
    static let apiKey = "x-api-key"
    static let versionKey = "x-version"
    static let deviceTypeKey = "type"
    static let contentType = "application/json"
}

struct ImageConstants {
    static let humidity = "humidity"
    static let wind = "wind"
    static let umbrella = "umbrella"
    static let cold = "cold"
    static let warm = "warm"
    
    static func getWeatherIconFor(icon: String) -> Image {
        switch icon {
            case "01d":
                return Image("sun")
            case "01n":
                return Image("moon")
            case "02d":
                return Image("cloudSun")
            case "02n":
                return Image("cloudMoon")
            case "03d":
                return Image("cloud")
            case "03n":
                return Image("cloudMoon")
            case "04d":
                return Image("cloudMax")
            case "04n":
                return Image("cloudMoon")
            case "09d":
                return Image("rainy")
            case "09n":
                return Image("rainy")
            case "10d":
                return Image("rainySun")
            case "10n":
                return Image("rainyMoon")
            case "11d":
                return Image("thunderstormSun")
            case "11n":
                return Image("thunderstormMoon")
            case "13d":
                return Image("snowy")
            case "13n":
                return Image("snowy-2")
            case "50d":
                return Image("tornado")
            case "50n":
                return Image("tornado")
            default:
                return Image("sun")
        }
    }
}

struct CitiesConstants {
    static let cities: [City] = [City(name: "Amsterdam", longitude: 4.9041, latitude: 52.3676),
                                 City(name: "Moscow", longitude: 37.6173, latitude: 55.7558),
                                 City(name: "Yerevan", longitude: 44.5152, latitude: 40.1872),]
}
