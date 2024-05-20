//
//  DetailsCustomCell.swift
//  Sky View
//
//  Created by Aser Eid on 19/05/2024.
//

import SwiftUI
import Kingfisher

struct HourlyCustomCell: View {
    
    var hour : Hour
    var day : ForecastDay
    
    var body: some View {
        HStack{
            Text(formatHour(hour.time ?? "", day: day))
                .font(.system(size: 22))
            
            Spacer()
            
            KFImage(URL(string: "https:\(hour.condition?.icon ?? "")"))
                .resizable()
                .frame(width: 45 ,height: 45 )
            
            Spacer()
            Text("\(formatTemperature(hour.tempC ?? 0)) °C")
                .font(.system(size: 22))
        }
        .shadow(radius: 2)
        .padding(.top, 10)
        .background(Color.clear)
        
        
    }
    
    func formatHour(_ time: String, day: ForecastDay) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = dateFormatter.date(from: time) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            
            let currentHour = calendar.component(.hour, from: Date())
            
            let currentDayEpoch = Date(timeIntervalSince1970: TimeInterval(day.dateEpoch ?? 0))
            let hourDayEpoch = Date(timeIntervalSince1970: TimeInterval(day.dateEpoch ?? 0))
            
            if calendar.isDate(currentDayEpoch, inSameDayAs: Date()) {
                if hour == currentHour {
                    return "Now"
                }
            }
            
            dateFormatter.dateFormat = "h a"
            return dateFormatter.string(from: date)
        }
        
        return time
    }


    
    func formatTemperature(_ temp: Double) -> String {
            return String(format: "%.1f", temp)
        }
  
}

//#Preview {
//    DetailsCustomCell(hour: Hour()
//}
