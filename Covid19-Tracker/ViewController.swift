//
//  ViewController.swift
//  Covid19-Tracker
//
//  Created by Naidas on 4/27/20.
//  Copyright © 2020 Naidas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchFieldText: UITextField!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    
    @IBOutlet weak var currentCasesLabel: UILabel!
    @IBOutlet weak var currentDeathsLabel: UILabel!
    
    @IBOutlet weak var newCasesLabel: UILabel!
    @IBOutlet weak var newRecoveriesLabel: UILabel!
    @IBOutlet weak var newDeathsLabel: UILabel!
    @IBOutlet weak var totalTestsLabel: UIStackView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func searchedPressed(_ sender: UITextField) {
    }
    
    @IBAction func searchFieldPressed(_ sender: UITextField) {
    }
    @IBAction func globeButtonPressed(_ sender: UIButton) {
    }
    
    
}

