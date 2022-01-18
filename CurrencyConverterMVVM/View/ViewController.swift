//
//  ViewController.swift
//  CurrencyConverterMVVM
//
//  Created by egemen denizeri on 18.01.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var currencyDataViewModel: CurrencyDataViewModel!
    private var currencyListViewModel: CurrencyListViewModel!
    private var filteredCurrencyListViewModel: CurrencyListViewModel!

    private var isSearching = false
    private var searchQuery = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        getData()
    }
  
    private func getData() {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=9af535570b695f344b7ed8477ee6e5f5")!
        
        WebService().downloadCurrencies(url: url) { currencyData in
            if let currencyData = currencyData {
                print(currencyData)
                self.currencyDataViewModel = CurrencyDataViewModel(currencyData: currencyData)
                self.currencyListViewModel = self.currencyDataViewModel.getCurrencyList()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return self.filteredCurrencyListViewModel == nil ? 0 : self.filteredCurrencyListViewModel.numberOfRowsInSection()
        } else {
            return self.currencyListViewModel == nil ? 0 : self.currencyListViewModel.numberOfRowsInSection()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        var currencyViewModel : CurrencyViewModel?
        if isSearching{
            currencyViewModel = self.filteredCurrencyListViewModel.currencyAtIndex(indexPath.row)
        } else {
            currencyViewModel = self.currencyListViewModel.currencyAtIndex(indexPath.row)
        }
        
        if let currencyViewModel = currencyViewModel {
            cell.currencyLabel.text = currencyViewModel.name
            cell.priceLabel.text = String(currencyViewModel.price)
        }
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchQuery = searchText.lowercased()
        self.filteredCurrencyListViewModel = self.currencyListViewModel.filter(searchQuery)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }

    

    
}

