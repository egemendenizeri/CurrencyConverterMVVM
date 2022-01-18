//
//  Currency.swift
//  CurrencyConverterMVVM
//
//  Created by egemen denizeri on 18.01.2022.
//

import Foundation

struct CurrencyData : Decodable {
    let success : Bool
    let timestamp : Int
    let base : String
    let date : String
    let rates : [String: Double]
}

