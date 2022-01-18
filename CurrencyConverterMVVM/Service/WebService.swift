//
//  webService.swift
//  CurrencyConverterMVVM
//
//  Created by egemen denizeri on 18.01.2022.
//

import Foundation


class WebService {
    
    func downloadCurrencies(url: URL, completion: @escaping (CurrencyData?) -> ()) {
        print("burdayıım")
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let curencyData = try? JSONDecoder().decode(CurrencyData.self, from: data)
                
                if let curencyData = curencyData {
                    completion(curencyData)
                }
                
            }
            
        }.resume()
        
    }
    
}
