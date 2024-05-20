//
//  ForecastList.swift
//  Sky View
//
//  Created by Aser Eid on 18/05/2024.
//

import SwiftUI

struct ForecastList: View {
    
    var forecastDays : Forecast
    var color : Color
    var backgroundImage : String
    
    var body: some View {
        List{
            Section(header: Text("3-DAY FORECAST")
                .font(.headline)
                .foregroundColor(color)) {
                    ForEach(forecastDays.forecastday ?? [] , id: \.dateEpoch) { forecastDay in
                        NavigationLink(destination: DetailsScreen(day: forecastDay, color: color, backgroundImage: backgroundImage)) {
                            CustomCell(forecastDay : forecastDay, color: color )
                                .listRowBackground(Color.clear)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(color), alignment: .top)
                        }
                    }
                }
                .listRowBackground(Color.clear)
        }
        .foregroundStyle(color)
        .background(Color.clear)
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
        .padding(.bottom, 5)
        
    }
    
    
}

#Preview {
    ForecastList (forecastDays: Forecast(forecastday: []), color: .black, backgroundImage: "Day")
}
