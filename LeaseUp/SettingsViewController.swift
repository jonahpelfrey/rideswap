//
//  SettingsViewController.swift
//  RideSwap
//
//  Created by Jonah Pelfrey on 9/26/17.
//  Copyright © 2017 Jonah Pelfrey. All rights reserved.
//

import UIKit

@IBDesignable

class SettingsViewController: UIViewController {

    @IBOutlet weak var detailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        detailView.center.x -= view.bounds.width
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.75) {
            self.detailView.center.x += self.view.bounds.width
        }
    }

}
