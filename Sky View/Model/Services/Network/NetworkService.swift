//
//  NetworkService.swift
//  Sky View
//
//  Created by Aser Eid on 18/05/2024.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchWeather(latitude : Double , longitude : Double ,complitionHandler : @escaping (WeatherResponse? , Error?) -> Void)
}

class NetworkService : NetworkServiceProtocol{
    
   
    func fetchWeather(latitude : Double , longitude : Double ,complitionHandler : @escaping (WeatherResponse? , Error?) -> Void){
        
        let url = "http://api.weatherapi.com/v1/forecast.json?key=948e6e3800e841a0a9f100252241805&q=\(latitude),\(longitude)&days=3&aqi=no&alerts=no"
        
        print(url)
        AF.request(url).responseDecodable(of : WeatherResponse.self){response in
            switch response.result {
            case .success(let data):
                complitionHandler(data , nil)
            case .failure(let error):
                print("\(error) in alamofire")
                complitionHandler(nil , error)
            }
            
        }
    }
}
