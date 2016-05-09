//
//  ViewController.swift
//  PrincipalStress
//
//  Created by Luiz Herkenhoff Coelho on 09/05/16.
//  Copyright © 2016 Luiz Herkenhoff Coelho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sigmaX: UITextField!
    @IBOutlet weak var sigmaY: UITextField!
    @IBOutlet weak var sigmaZ: UITextField!
    
    @IBOutlet weak var tauXY: UITextField!
    @IBOutlet weak var tauXZ: UITextField!
    @IBOutlet weak var tauYZ: UITextField!
    
    @IBOutlet weak var sigma1: UILabel!
    @IBOutlet weak var sigma2: UILabel!
    @IBOutlet weak var sigma3: UILabel!
    @IBOutlet weak var tauMax: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

