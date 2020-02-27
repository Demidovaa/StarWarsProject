//
//  InfoViewController.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 14.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class InfoViewController: UITableViewController {
    
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
        
        //Test
        nameCell.detailTextLabel?.text = "Darth Vader"
        heightCell.detailTextLabel?.text = "202"
        massCell.detailTextLabel?.text = "136"
        hairColorCell.detailTextLabel?.text = "none"
        skinColorCell.detailTextLabel?.text = "white"
        eyeColorCell.detailTextLabel?.text = "yellow"
        birthYearCell.detailTextLabel?.text = "41.9BBY"
        genderCell.detailTextLabel?.text = "male"
    }
}
