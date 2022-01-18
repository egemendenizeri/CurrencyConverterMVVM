//
//  CurrencyViewModel.swift
//  CurrencyConverterMVVM
//
//  Created by egemen denizeri on 18.01.2022.
//

import Foundation

struct CurrencyDataViewModel {
    let currencyData : CurrencyData
}

extension CurrencyDataViewModel {
    func getCurrencyList() -> CurrencyListViewModel{
        var currencyList = [Currency]()
        for currency in self.currencyData.rates {
            currencyList.append(Currency(name: currency.key, price: currency.value))
        }
        return CurrencyListViewModel(currencyList: currencyList)
    }
}
