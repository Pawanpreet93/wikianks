//
//  LevelsViewController.swift
//  Wikianks
//
//  Created by Pawan on 18/08/17.
//  Copyright © 2017 Pawan. All rights reserved.
//

import UIKit

class LevelsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func easy(_ sender: CustomBGButton) {
        
        switch sender.tag{
        case 101:
            selectedLevel = .easy
        case 102:
            selectedLevel = .medium
        default:
            selectedLevel = .hard
        }
        
        performSegue(withIdentifier: "segueFromLevelToFillUp", sender: nil)
    }
    
}
