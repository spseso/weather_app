//
//  CityRowView.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import SwiftUI

struct CityRowView: View {
    let city: City
    var isCurrent: Bool
    
    // initializer to set the city and whether it's the current location
    init(city: City, isCurrent: Bool = false) {
        self.city = city
        self.isCurrent = isCurrent
    }
    
    var body: some View {
        VStack() {
            // city name and padding
            HStack() {
                Text(city.name)
                    .padding([.leading, .trailing], 10)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.1),
                            radius: 2,
                            x: -2,
                            y: -2)
                Spacer()
            }
            // if it's the current location, show "Current Location" text and padding
            if isCurrent {
                HStack() {
                    Text(Strings.currentLocation)
                        .padding([.leading, .trailing], 10)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.1),
                                radius: 2,
                                x: -2,
                                y: -2)
                    Spacer()
                }
            }
        }
        // set height of the row and add background gradient and corner radius
        .frame(height: 80)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: isCurrent ? Colors.gradientAPP : Colors.gradient),
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
        )
        // add top and left shadow
        .shadow(color: Color.white.opacity(0.1),
                radius: 2,
                x: -2,
                y: -2)
        // add bottom and right shadow
        .shadow(color: Color.black.opacity(0.2),
                radius: 2,
                x: 2,
                y: 2)
    }
}

struct CityRowView_Previews: PreviewProvider {
    static var previews: some View {
        CityRowView(city: City.mockCity)
    }
}
