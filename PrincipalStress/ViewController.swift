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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func orderValues(arrayIn: [Double]) -> [Double] {
        var orderedArray = arrayIn
        if orderedArray[0] < orderedArray[1] {
            let aux = orderedArray[0]
            orderedArray[0] = orderedArray[1]
            orderedArray[1] = aux
        }
        
        if orderedArray[0] < orderedArray[2] {
            let aux = orderedArray[0]
            orderedArray[0] = orderedArray[2]
            orderedArray[2] = aux
        }
        
        if orderedArray[1] < orderedArray[2] {
            let aux = orderedArray[1]
            orderedArray[1] = orderedArray[2]
            orderedArray[2] = aux
        }
        
        return orderedArray
    }
    
    func calculatePrincipalStresses(tension: Tension) -> [Double] {
        return principalStressesCalculation(invariantsCalculation(tension))
    }

    func invariantsCalculation(tension: Tension) -> (I1: Double, I2: Double, I3: Double) {
        let I1 = tension.x + tension.y + tension.z
        let I2 = tension.x * tension.y + tension.x * tension.z + tension.y * tension.z - tension.xy * tension.xy - tension.xz * tension.xz - tension.yz * tension.yz
        let I3 = tension.x * tension.y * tension.z + 2 * tension.xy * tension.yz * tension.xz - tension.xz * tension.y * tension.xz - tension.x * tension.yz * tension.yz - tension.xy * tension.xy * tension.z
        return (I1, I2, I3)
    }
    
    func principalStressesCalculation(invariant: (I1: Double, I2: Double, I3: Double)) -> [Double] {
        if abs(invariant.I1 * invariant.I1 - 3 * invariant.I2) > 0.0001 {
            let R = (-9 * invariant.I1 * invariant.I2 + 27 * invariant.I3 + 2 * invariant.I1 * invariant.I1 * invariant.I1) / 54
            let Q = (invariant.I1 * invariant.I1 - 3 * invariant.I2) / 9
            let theta=acos(R/sqrt(Q*Q*Q))
            let sigmaP1 = invariant.I1 / 3 + 2 * cos(theta/3) * sqrt(Q)
            let sigmaP2 = invariant.I1 / 3 + 2*cos(theta/3 + 240*3.14159/180) * sqrt(Q)
            let sigmaP3 = invariant.I1 / 3 + 2*cos(theta/3 + 120*3.14159/180) * sqrt(Q)
            let sigmaPOut = orderValues([sigmaP1, sigmaP2, sigmaP3])
            return sigmaPOut
        } else {
            let sigmaPOut = [(invariant.I1)/3, (invariant.I1)/3, (invariant.I1)/3]
            return sigmaPOut
        }
    }
    
    func maxShearStress(sigma: (sigma1: Double, sigma3: Double)) -> (Double) {
        let tauMax = (sigma.sigma1 - sigma.sigma3)/2
        return (tauMax)
    }
}