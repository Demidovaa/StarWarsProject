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
    private var selectedPerson: Person?
    private var tableHeader: String?
    private var displayData: [Person]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private enum Title {
        static let error = "Error"
        static let notFound = "Not Found"
        static let ok = "OK"
        static let nameApp = "Star Wars"
        static let result = "Result"
        static let history = "History"
    }
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchHandler = debounce(delay: .seconds(1)) { searchText in
            self.search(for: searchText)
        }
        
        showRecents()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = Title.nameApp
    }
    
    private func showRecents() {
        displayData = databaseService.getInfoPerson()
        tableHeader = Title.history
    }
    
    private func search(for text: String) {
        spinner.startAnimating()
        networkService.search(for: text) { result, count  in
            switch result {
            case .success(let results):
                self.tableHeader = Title.result
                self.displayData = results?.map{ Person(from: $0) }
                
                if count == 0 {
                    self.showAlert(with: Title.notFound)
                    self.showRecents()
                }
            case .failure:
                self.showAlert(with: Title.error)
                self.showRecents()
            }
            
            self.spinner.stopAnimating()
        }
    }
    
    private func showAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Title.ok, style: .cancel))
        self.present(alert, animated: true)
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
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchHandler?(searchText)
        } else {
            showRecents()
        }
    }
}

//MARK: TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableHeader
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
            }
        }
    }
}
