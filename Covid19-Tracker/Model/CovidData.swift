//
//  CovidData.swift
//  Covid19-Tracker
//
//  Created by Naidas on 4/27/20.
//  Copyright © 2020 Naidas. All rights reserved.
//

import Foundation


struct CovidData: Codable {
    
    let updated: Double
    let country: String
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
    let tests: Int

}

struct WorldCovidData: Codable {
    
    var updated: Double
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
    let tests: Int
}
