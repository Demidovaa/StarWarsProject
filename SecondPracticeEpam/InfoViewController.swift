//
//  InfoViewController.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 14.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class InfoViewController: UITableViewController {
    
    var infoPerson = Person()
    
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var heightCell: UITableViewCell!
    @IBOutlet weak var massCell: UITableViewCell!
    @IBOutlet weak var hairColorCell: UITableViewCell!
    @IBOutlet weak var skinColorCell: UITableViewCell!
    @IBOutlet weak var eyeColorCell: UITableViewCell!
    @IBOutlet weak var birthYearCell: UITableViewCell!
    @IBOutlet weak var genderCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
       
        nameCell.detailTextLabel?.text = infoPerson.name
        heightCell.detailTextLabel?.text = infoPerson.height
        massCell.detailTextLabel?.text = infoPerson.mass
        hairColorCell.detailTextLabel?.text = infoPerson.hair
        skinColorCell.detailTextLabel?.text = infoPerson.skin
        eyeColorCell.detailTextLabel?.text = infoPerson.eye
        birthYearCell.detailTextLabel?.text = infoPerson.birth
        genderCell.detailTextLabel?.text = infoPerson.gender
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = infoPerson.name
    }
}
