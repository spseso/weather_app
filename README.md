# Weather App
The Weather App is a simple iOS application that allows users to get the weather forecast for their current location or search for the weather forecast in a specific city. The app is built using SwiftUI and Interface Builder, and uses the OpenWeatherMap API to fetch weather data.

## Getting Started
To use the Weather App, you will need an iOS device running iOS 14 or later.
- Clone the repository or download the project as a ZIP file.
- Open the project in Xcode.
- Build and run the app on your iOS device or simulator.

## Features
The Weather App has the following features:

- [x] Get weather forecast for your current location: The app uses Core Location to determine your current location and fetches the weather forecast from the OpenWeatherMap API.
- [x] Search for weather forecast in a specific city: The app allows you to search for the weather forecast in any city in the world by entering the city name.
- [x] Display weather forecast details: The app displays the current temperature, weather condition, humidity, wind speed, and precipitation for the selected location.
- [x] Caches previously downloaded weather data for faster retrieval and improved performance. This means that if you have already searched for the weather forecast in a specific city, the app will retrieve the data from the cache before making a new API request to get new weather data.
- [x] Delete previously added cities to your shortlist by swiping left.

## Credits

* Alamofire - Used for networking. [Link](https://github.com/Alamofire/Alamofire)
