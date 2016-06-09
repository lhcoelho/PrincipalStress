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
    
    @IBOutlet weak var tauLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tauLabel.attributedText = getStringWithSubscript("τmax")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func calculatePrincipalStresses() {
        var sigma = readInputData()
         verifyAndCorrectInvalidInputData(&sigma)
        let tension = Tension(x: Double(sigma[0])!, y: Double(sigma[1])!, z: Double(sigma[2])!, xy: Double(sigma[3])!, xz: Double(sigma[4])!, yz: Double(sigma[5])!)
        calculateAndDisplayResults(tension)
    }
    
    func readInputData() -> [String] {
        let sX = sigmaX.text
        let sY = sigmaY.text
        let sZ = sigmaZ.text
        let tXY = tauXY.text
        let tXZ = tauXZ.text
        let tYZ = tauYZ.text
        return [sX!, sY!, sZ!, tXY!, tXZ!, tYZ!]
    }
    
    func verifyAndCorrectInvalidInputData(inout sigma: [String]) {
        for index in 0..<sigma.count {
            if sigma[index] == "" || sigma[index] == "-" {
                sigma[index] = "0"
            }
        }
    }
    
    func calculateAndDisplayResults(tension: Tension) {
        let sigmaP = calculatePrincipalStresses(tension)
        let tMax = maxShearStress((sigma1: sigmaP[0], sigma3: sigmaP[2]))
        
        sigma1.text = getFormattedString(sigmaP[0])
        sigma2.text = getFormattedString(sigmaP[1])
        sigma3.text = getFormattedString(sigmaP[2])
        tauMax.text = getFormattedString(tMax)
    }
    
    func getFormattedString(value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    func getStringWithSubscript(string: String) -> NSAttributedString {
        let font = UIFont.systemFontOfSize(17)
        let fontSub = UIFont.systemFontOfSize(10)
        let attString = NSMutableAttributedString(string: string, attributes: [NSFontAttributeName: font])
        attString.setAttributes([NSFontAttributeName: fontSub, NSBaselineOffsetAttributeName: -3], range: NSRange(location: 1, length: string.characters.count-1))

        return attString
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

extension ViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldString = textField.text!
        let newRange = oldString.startIndex.advancedBy(range.location)..<oldString.startIndex.advancedBy(range.location + range.length)
        let resultString = oldString.stringByReplacingCharactersInRange(newRange, withString: string)
        if resultString == "" || resultString == "-" {
            return true
        }
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        return formatter.numberFromString(resultString) != nil
    }
}