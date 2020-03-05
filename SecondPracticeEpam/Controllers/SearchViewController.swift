//
//  SearchViewController.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 14.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    private var searchHandler: ((String) -> Void)?
    private var databaseService = DatabaseService()
    private var networkService = NetworkService()
    private var displayData: [Person]?
    private var selectedPerson: Person?
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        displayData = []
        searchHandler = debounce(delay: .seconds(1)) { searchText in
            self.search(for: searchText)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Star Wars"
        displayData = databaseService.getInfoPerson()
        tableView.reloadData()
    }
    
    private func search(for text: String) {
        spinner.startAnimating()
        networkService.search(for: text) { result in
            switch result {
            case .success(let results):
                self.displayData = results?.map{ Person(from: $0) }
            case .failure:
                self.displayData = nil
            }
            
            self.spinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

//MARK: SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.searchTextField.text = nil
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchHandler?(searchText)
        }
    }
}

//MARK: TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Result"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let item = displayData?[indexPath.row]
        cell.textLabel?.text = item?.name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let person = displayData?[indexPath.row] {
            databaseService.save(object: person)
            selectedPerson = person
        }
        
        performSegue(withIdentifier: "InfoViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoViewController" {
            if let person = segue.destination as? InfoViewController {
                person.infoPerson = selectedPerson
            }
        }
    }
    
    //MARK: Button "Delete"
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let item = displayData?[indexPath.row] {
                databaseService.remove(object: item)
                displayData?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
