//
//  InfoViewController.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 14.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class InfoViewController: UITableViewController {
    var infoPerson: Person?
    
    @IBOutlet private weak var nameCell: UITableViewCell!
    @IBOutlet private weak var heightCell: UITableViewCell!
    @IBOutlet private weak var massCell: UITableViewCell!
    @IBOutlet private weak var hairColorCell: UITableViewCell!
    @IBOutlet private weak var skinColorCell: UITableViewCell!
    @IBOutlet private weak var eyeColorCell: UITableViewCell!
    @IBOutlet private weak var birthYearCell: UITableViewCell!
    @IBOutlet private weak var genderCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = nil
        
        nameCell.detailTextLabel?.text = infoPerson?.name
        heightCell.detailTextLabel?.text = infoPerson?.height
        massCell.detailTextLabel?.text = infoPerson?.mass
        hairColorCell.detailTextLabel?.text = infoPerson?.hair
        skinColorCell.detailTextLabel?.text = infoPerson?.skin
        eyeColorCell.detailTextLabel?.text = infoPerson?.eye
        birthYearCell.detailTextLabel?.text = infoPerson?.birth
        genderCell.detailTextLabel?.text = infoPerson?.gender
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = infoPerson?.name
    }
}
