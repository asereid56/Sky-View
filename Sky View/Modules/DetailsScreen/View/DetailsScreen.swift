//
//  DetailsScreen.swift
//  Sky View
//
//  Created by Aser Eid on 18/05/2024.
//

import SwiftUI

struct DetailsScreen: View {
    
    var day : ForecastDay
    var color : Color
    var backgroundImage  :String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack{
            Image(backgroundImage)
                .resizable()
                .ignoresSafeArea(.all)
            
            List(subHoursArray(from: day.hour ?? []) , id: \.time){ item in
                HourlyCustomCell(hour: item, day: day)
                    .listRowBackground(Color.clear)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(color) , alignment: .top)
            }
            .foregroundStyle(color)
            .listRowBackground(Color.clear)
            .background(Color.clear)
            .scrollContentBackground(.hidden)
        }
        .navigationBarBackButtonHidden(true)
               .navigationBarItems(leading:
                   Button(action: {
                       presentationMode.wrappedValue.dismiss()
                   }) {
                       Image(systemName: "chevron.left")
                           .foregroundColor(color) 
                   }
               )
        
    }
    func filteredAndFormattedHours() -> [Hour] {
        let currentHour = Calendar.current.component(.hour, from: Date())
        var filteredHours = day.hour?.filter { hour in
            if let hourInt = Int(hour.time?.prefix(2) ?? "") {
                return hourInt >= currentHour
            }
            return false
        }
        
        if !(filteredHours?.isEmpty ?? false) {
            filteredHours?[0].time = "Now"
        }
        
        return filteredHours ?? []
    }
    
    func getCurrentHour() -> Int {
        let currentHour = Calendar.current.component(.hour, from: Date())
        return currentHour
    }
    
    func subHoursArray(from hours: [Hour]) -> [Hour] {
        let currentHour = getCurrentHour()
        
        guard currentHour >= 0 && currentHour < 24 else {
            
            return []
        }
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: Date())
        
        let forecastDay = calendar.component(.day, from: Date(timeIntervalSince1970: TimeInterval(day.dateEpoch ?? 0)))
        
        
        if currentDay == forecastDay {
            return Array(hours[currentHour..<24])
            
        }else{
            return hours
        }

    }
    
    
}


//#Preview {
//    DetailsScreen(day: ForecastDay(dateEpoch: 12, day: Day(maxtemp: 0.0, mintemp: 0.0, avgtemp: 0.0, condition: Condition(text: "", icon: "")), hour: []) , )
//}
