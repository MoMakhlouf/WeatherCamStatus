//
//  Networking.swift
//  WeatherCamStatus
//
//  Created by Mohamed Makhlouf Ahmed on 14/11/2022.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: NetworkManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


class NetworkManager {
    
    var delegate: WeatherManagerDelegate?
    
    func weatherNetwork(latitude: CLLocationDegrees, longitude: CLLocationDegrees ) {
       
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=334517bdec593fc4b642dfe50d948f93&units=metric"
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, request, error in
                if let data = data {
                    if let weather = self.parseJSon(data){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSon(_ weatherData : Data) -> WeatherModel? {
        
        if let decodedData = try?JSONDecoder().decode(WeatherData.self, from: weatherData){
            let id = decodedData.weather[0].id
            let desc = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let weather  = WeatherModel(conditionId: id, desc: desc, cityName: cityName, temperature: temp)
            return weather
            
        }
        return nil
    }
}
