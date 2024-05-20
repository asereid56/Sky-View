//
//  HomeScreenViewModel.swift
//  Sky View
//
//  Created by Aser Eid on 18/05/2024.
//

import Foundation
import SwiftUI
import CoreLocation
import Reachability

class HomeScreenViewModel : NSObject, ObservableObject , CLLocationManagerDelegate{
    
    private let network : NetworkServiceProtocol
    var locationManager : LocationManager
    var reachability : Reachability?
    
    @Published private var currentWeather : Current?
    @Published private var location : Location?
    @Published private var forecastThreeDays : Forecast?
    @Published var lat : Double = 0
    @Published var long : Double = 0
    @Published var isConnected : Bool = true
   


    init(network: NetworkServiceProtocol , locationManager : LocationManager) {
        self.network = network
        self.locationManager = locationManager
    }
    func setUpReachability(){
        do{
            reachability = try Reachability()
            reachability?.whenReachable = { [weak self] reachability in
                DispatchQueue.main.async {
                    self?.isConnected = true
                    self?.loadWeatherResponse()
                }
            }
            
            reachability?.whenUnreachable = { [weak self] _ in
                DispatchQueue.main.async {
                    self?.isConnected = false
                }
            }
            
            try reachability?.startNotifier()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func checkReachability() {
          if reachability?.connection == .unavailable {
              isConnected = false
          } else {
              isConnected = true
          }
      }
    
    func loadWeatherResponse () {
        if isConnected{
            if let location = locationManager.location {
                lat = location.coordinate.latitude
                long = location.coordinate.longitude
                
            }else{
                lat = 0
                long = 0
            }
            network.fetchWeather(latitude : lat , longitude : long){ [weak self] response, error  in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let weatherResponse = response else{
                    print("Failed to get weather response")
                    return
                }
                
                DispatchQueue.main.async{
                    self?.currentWeather = weatherResponse.current
                    self?.location = weatherResponse.location
                    self?.forecastThreeDays = weatherResponse.forecast
                }
                print(weatherResponse)
            }
        }else {
            print("There is no internet connection!")
        }
    }
    
    
    
    func setBackgroundImage() -> String {
        
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        
        return (5...16).contains(hour) ? "Day" : "Night"
    }
    
    
    func getColorText () -> Color{
        @State var background = setBackgroundImage()
        return background == "Night" ? .white : .black
    }
    
    func getCurrentWeather () -> Current? {
        return currentWeather
    }
    
    func getLocation () -> Location? {
        return location
    }
    
    func getForecast () -> Forecast? {
        return forecastThreeDays
    }
    
    deinit {
            reachability?.stopNotifier()
        }
        
}
