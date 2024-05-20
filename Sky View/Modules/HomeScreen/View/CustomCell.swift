//
//  CustomCell.swift
//  Sky View
//
//  Created by Aser Eid on 18/05/2024.
//

import SwiftUI
import Kingfisher

struct CustomCell: View {
    var forecastDay: ForecastDay
    var color : Color
    
    var body: some View {
        
        HStack {
            Text(formatDay(forecastDay.dateEpoch ?? 0))
                .foregroundColor(color)
                .font(.system(size: 22))
                
            Spacer()
            
            KFImage(URL(string: "https:\(forecastDay.day?.condition?.icon ?? "")"))
                .resizable()
                .frame(width: 35, height: 35)
    
            Spacer()
            Text("\(formatTemperature(forecastDay.day?.mintemp ?? 0)) - \(formatTemperature(forecastDay.day?.maxtemp ?? 0))°C")
                .font(.system(size: 20))
                .foregroundColor(color)
        }
        .shadow(radius: 2)
        .padding(.top, 10)
        .background(Color.clear)
        
        
    }
    func formatTemperature(_ temp: Double) -> String {
            return String(format: "%.1f", temp)
        }
    
    func formatDay(_ dateEpoch: TimeInterval) -> String {
           let calendar = Calendar.current
           let currentDay = calendar.component(.day, from: Date())
           let forecastDay = calendar.component(.day, from: Date(timeIntervalSince1970: dateEpoch))
           
           if currentDay == forecastDay {
               return "Today"
           } else {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "EEEE"
               return dateFormatter.string(from: Date(timeIntervalSince1970: dateEpoch))
           }
       }
}


