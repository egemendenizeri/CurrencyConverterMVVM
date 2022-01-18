//
//  CurrencyViewModel.swift
//  CurrencyConverterMVVM
//
//  Created by egemen denizeri on 18.01.2022.
//

import Foundation


struct CurrencyListViewModel {
    let currencyList : [Currency]
    
    func numberOfRowsInSection() -> Int {
         return self.currencyList.count
     }
     
     func currencyAtIndex(_ index: Int) -> CurrencyViewModel {
         let currency = self.currencyList[index]
         return CurrencyViewModel(currency: currency)
     }
    
    func filter(_ query: String) -> CurrencyListViewModel {
        var filteredCurrencyList = [Currency]()
        if query != ""{
            for currency in currencyList {
                if currency.name.lowercased().contains(query) {
                    filteredCurrencyList.append(currency)
                }
            }
            return CurrencyListViewModel(currencyList: filteredCurrencyList)
        } else {
            return CurrencyListViewModel(currencyList: currencyList)
        }
    }
}

struct CurrencyViewModel {
    let currency : Currency

    var name: String {
        return self.currency.name
    }
    
    var price: Double {
        return self.currency.price
    }
}
