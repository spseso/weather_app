//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import SwiftUI

struct WeatherView: View {
    // Use @StateObject to create a new instance of WeatherViewModel and keep it alive
    // for the life of the view. Also mark it as private.
    @StateObject var weatherViewModel: WeatherViewModel
    // Use @Environment(\.dismiss) to get the dismiss action provided by the
    // presentation mode of the parent view.
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 5) {
            // Use ImageConstants to get the weather icon based on the icon name provided
            // by the WeatherViewModel.
            ImageConstants.getWeatherIconFor(icon: weatherViewModel.iconName)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90, alignment: .center)
            HStack(spacing: 10) {
                VStack(alignment: .center) {
                    // Display the temperature in Celsius.
                    Text("\(weatherViewModel.temperature)°C")
                        .font(.system(size: 45))
                    // Display the weather description.
                    Text(weatherViewModel.city.weatherResponse?.weather.first?.main ?? "")
                        .font(.system(size: 30))
                    // Display the "Feels Like" temperature.
                    Text("Feels Like: \(weatherViewModel.feelsLike)°C")
                        .font(.system(size: 15))
                }
            }
            HStack {
                Spacer()
                // Use the WidgetView to display the wind speed.
                WidgetView(image: ImageConstants.wind,
                           text: Strings.windSpeed,
                           title: "\(weatherViewModel.windSpeed) m/s")
                Spacer()
                // Use the WidgetView to display the humidity.
                WidgetView(image: ImageConstants.humidity,
                           text: Strings.humidity,
                           title: "\(weatherViewModel.humidity)")
                Spacer()
            }
            Spacer()
        }
        .padding()
        // Use onAppear to fetch the weather data when the view appears.
        .onAppear(perform: weatherViewModel.fetchWeatherData)
        // Set the title of the navigation bar to the city name.
        .navigationBarTitle("\(weatherViewModel.city.name)", displayMode: .large)
        .foregroundStyle(.white)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: Colors.gradient),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    )
                ).ignoresSafeArea()
        )
        // Add shadows to the view.
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
        // Use an alert to display any errors that occur during the fetchWeatherData method.
        .alert(weatherViewModel.error?.getErrorMessage() ?? "", isPresented: $weatherViewModel.hasError) {
            Button(Strings.okButtonTitle, role: .cancel) {
                dismiss()
            }
        }
        // Hide the back button in the navigation bar and add a custom "back" button
        // that dismisses the view.
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            })
        )
    }
    
    private func WidgetView(image: String,
                            text: String,
                            title: String) -> some View {
        VStack {
            Text(text)
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 30,
                       height: 30,
                       alignment: .center)
            Text(title)
        }
        .font(.system(size: 10))
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherViewModel: WeatherViewModel(city: City.mockCity))
    }
}
