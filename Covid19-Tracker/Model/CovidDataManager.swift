//
//  CovidDataManager.swift
//  Covid19-Tracker
//
//  Created by Naidas on 4/27/20.
//  Copyright © 2020 Naidas. All rights reserved.
//

import Foundation
import Alamofire

protocol CovidDataManagerDelegate {
    
    func didUpdateCovidData(_ covidDataManager: CovidDataManager, covidStats: CovidDataModel)
    func didUpdateWorldCovidData(_ covidDataManager: CovidDataManager, worldCovidStats: WorldCovidDataModel)
    func didFailWithError(error: Error)
    
}

struct CovidDataManager {
    
    var delegate:  CovidDataManagerDelegate?
    
    let baseURL = "https://corona.lmao.ninja/v2/countries"
    
    let worldURL = "https://corona.lmao.ninja/v2/all"
    
    func fetchCovidData(countryName: String) {
        
        let countryNameWithSpace = countryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let urlString = "\(baseURL)/\(countryNameWithSpace ?? "")"
        
        getCountryData(urlString: urlString)
    }
    
    func fetchWorldData() {
        getWorldData(urlString: worldURL)
    }

    //MARK: - Get all country names request
    
    func getCountryData(urlString: String) {
        
        AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in
            guard let covidData = responseData.data else {return}
            
            if let covidStats = self.parseJSON(covidData) {
                self.delegate?.didUpdateCovidData(self, covidStats: covidStats)
            }
        }
    }
    
    func parseJSON(_ covidData: Data) -> CovidDataModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CovidData.self, from: covidData)
            
            let updated = decodedData.updated
            let country = decodedData.country
            let cases = decodedData.cases
            let todayCases = decodedData.todayCases
            let deaths = decodedData.deaths
            let todayDeaths = decodedData.todayDeaths
            let recovered = decodedData.recovered
            let tests = decodedData.tests
            
            let covidStats = CovidDataModel(dateTimeUpdated: updated, countryName: country, totalCases: cases, totalDeaths: deaths, casesToday: todayCases, deathsToday: todayDeaths, totalRecovered: recovered, totalTests: tests)
            
            print(covidStats)
            
            return covidStats
            
            
        } catch {
            print("Error decoding countries \(error)")
            return nil
        }
    }
    
    
    //MARK: - Get World Request
    
    func getWorldData(urlString: String) {
        
        AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in
            guard let worldCovidData = responseData.data else {return}
            
            if let worldCovidStats = self.parseJSONWorld(worldCovidData) {
                self.delegate?.didUpdateWorldCovidData(self, worldCovidStats: worldCovidStats)
            }
        }
    }
    
    func parseJSONWorld(_ worldCovidData: Data) -> WorldCovidDataModel? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(WorldCovidData.self, from: worldCovidData)
            
            let updated = decodedData.updated
            let cases = decodedData.cases
            let todayCases = decodedData.todayCases
            let deaths = decodedData.deaths
            let todayDeaths = decodedData.todayDeaths
            let recovered = decodedData.recovered
            let tests = decodedData.tests
            
            let worldCovidStats = WorldCovidDataModel(dateTimeUpdated: updated, totalCases: cases, totalDeaths: deaths, casesToday: todayCases, deathsToday: todayDeaths, totalRecovered: recovered, totalTests: tests)
            
            return worldCovidStats
        } catch {
            print("Error decoding world data \(error)")
            return nil
        }
    }
}
