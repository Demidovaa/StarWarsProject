//
//  SearchViewController.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 14.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var databaseService = DatabaseService()
    private var networkService = NetworkManager()
    
    private var displayData = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData = []
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        //
        //        let person = Person()
        //        person.name = "Test"
        //        databaseService.save(object: person)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //displayData = databaseService.get()
        tableView.reloadData()
    }
    
    private func search(for text: String?) {
        //networkManager.search(for: text)
    }
}

//MARK: SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        //activityIndicator.stopAnimating()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.searchTextField.text = nil
        displayData = []
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkService.search(for: searchText, completion: { results in
            guard let items = results else {
                return
            }
            
            self.displayData = items.map({ Person(from: $0) })
            self.tableView.reloadData()
        })
    }
}

//MARK: TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Result"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let item = displayData[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let person = displayData[indexPath.row]
        //person.name = "Name" + " \(indexPath.row)"
        //databaseService.save(object: person)
        
        performSegue(withIdentifier: "InfoViewController", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let item = displayData[indexPath.row]
            //databaseService.remove(object: item)
            displayData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
