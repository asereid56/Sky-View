//
//  ByList.swift
//  Sky View
//
//  Created by Aser Eid on 18/05/2024.
//

import SwiftUI
import Kingfisher
import CoreLocation

struct HomeScreen: View  {
    
    @State private var backgroundImage = "Day"
    
    private var textcolor : Color {
        return backgroundImage == "Night" ? .white : .black
    }
    
    @ObservedObject var viewModel : HomeScreenViewModel
    
    
    var body: some View {
        NavigationView{
            
            ZStack {
                if let currrent = viewModel.getCurrentWeather(){
                    Image(backgroundImage)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                   // ScrollView{
                        
                        VStack {
                            
                            Spacer()
                            
                            VStack(spacing: 5) {
                                
                                if viewModel.getLocation() != nil{
                                    Text(viewModel.getLocation()?.name ?? "")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                }
                                
                                Text("\(formatTemperature(Double(currrent.temp ?? 0))) °C")
                                    .font(.system(size: 60))
                                    .fontWeight(.light)
                                
                                Text(currrent.condition?.text ?? "")
                                    .font(.title2)
                                
                                if let forecast = viewModel.getForecast()?.forecastday?.first?.day{
                                    
                                    HStack{
                                        
                                        Spacer()
                                        Spacer()
                                        Text("L:\(formatTemperature(forecast.mintemp ?? 0))°C")
                                            .font(.subheadline)
                                        Spacer()
                                        Text("H: \(formatTemperature(forecast.maxtemp ?? 0))°C ")
                                            .font(.subheadline)
                                        Spacer()
                                        Spacer()
                                        
                                    }.foregroundColor(textcolor)
                                    
                                    KFImage(URL(string: "https:\(currrent.condition?.icon ?? "")"))
                                        .font(.largeTitle)
                                        .shadow(radius: 75)
                                    
                                }
                            }.padding(.top,30)
                            
                            
                            Spacer()
                            
                            
                            if let forecast = viewModel.getForecast() {
                                ForecastList(forecastDays: forecast, color: textcolor , backgroundImage: backgroundImage)
                            }
                            
                            Spacer()
                            
                            Grid(alignment: .center, horizontalSpacing: 100, verticalSpacing: 60) {
                                GridRow {
                                    VStack {
                                        Text("VISIBILITY")
                                            .font(.system(size: 18))
                                        Text("\(currrent.visibility ?? 0) Km")
                                            .font(.title)
                                    }
                                    VStack {
                                        Text("HUMIDITY")
                                            .font(.system(size: 18))
                                        Text("\(currrent.humidity ?? 0) %")
                                            .font(.title)
                                    }
                                }
                                GridRow {
                                    VStack {
                                        Text("FEELS LIKE")
                                            .font(.system(size: 18))
                                        Text("\(formatTemperature(currrent.feelslike ?? 0)) °C")
                                            .font(.title)
                                    }
                                    VStack {
                                        Text("PRESSURE")
                                            .font(.system(size: 18))
                                        Text("\(currrent.pressure ?? 0)")
                                            .font(.title)
                                    }
                                }
                            }
                            .padding()
                            .foregroundColor(textcolor)
                            
                            
                            Spacer()
                            
                        }.foregroundColor(textcolor)
//                    }.refreshable {
//                        backgroundImage = viewModel.setBackgroundImage()
//                        viewModel.loadWeatherResponse()
//                    }
                }
            }.onAppear {
                backgroundImage = viewModel.setBackgroundImage()
                viewModel.loadWeatherResponse()
                
            }
            
        }
    }
    func formatTemperature(_ temp: Double) -> String {
        return String(format: "%.1f", temp)
    }
    
}

#Preview {
    HomeScreen(viewModel: HomeScreenViewModel(network: NetworkService(), locationManager: LocationManager()))
}


