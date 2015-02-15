//
//  ViewController.swift
//  LemonadeStand
//
//  Created by JIAN WANG on 2/15/15.
//  Copyright (c) 2015 JACY WANG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moneyInSupplyLabel: UILabel!
    @IBOutlet weak var numberOfLemonsInSupplyLabel: UILabel!
    @IBOutlet weak var numberOfIceInSupplyLabel: UILabel!
    
    @IBOutlet weak var numberOfLemonsPurchasedLabel: UILabel!
    @IBOutlet weak var numberOfIceCubesPurchasedLabel: UILabel!
    
    
    @IBOutlet weak var numberOfLemonsMixedLabel: UILabel!
    @IBOutlet weak var numberOfIceMixedLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var moneyInSupply: Int = 10
    var numberOfLemonsInSupply: Int = 1
    var numberOfIcesInSupply: Int = 1
    
    let lemonsPurchasePrice: Int = 2
    let icePurchasePrice: Int = 1
    
    var lemonsPurchased = 0
    var iceCubesPurchased = 0
    
    var lemonsMixed = 0
    var iceCubesMixed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func purchaseLemonsPlusButtonPressed(sender: UIButton) {
        if moneyInSupply >= 2 {
            lemonsPurchased += 1
            moneyInSupply -= 2
            numberOfLemonsInSupply += 1
        } else {
            showAlertWithMessage(header: "Not Enough Money!", message: "Please adjust your purchase or start to make your lemonade.")
        }
        
        
        numberOfLemonsPurchasedLabel.text = "\(lemonsPurchased)"
        numberOfLemonsInSupplyLabel.text = "\(numberOfLemonsInSupply)"
        moneyInSupplyLabel.text = "\(moneyInSupply)"
    }

    @IBAction func purchaseLemonsMinusButtonPressed(sender: UIButton) {
        if lemonsPurchased >= 1 {
            lemonsPurchased -= 1
            moneyInSupply += 2
            numberOfLemonsInSupply -= 1
        } else {
            showAlertWithMessage(message: "No more Lemons in your purchase.")
        }
        
        
        numberOfLemonsPurchasedLabel.text = "\(lemonsPurchased)"
        numberOfLemonsInSupplyLabel.text = "\(numberOfLemonsInSupply)"
        moneyInSupplyLabel.text = "\(moneyInSupply)"
    }

    @IBAction func purchaseIcePlusButtonPressed(sender: UIButton) {
        if moneyInSupply >= 1 {
            numberOfIcesInSupply += 1
            iceCubesPurchased += 1
            moneyInSupply -= 1
        } else {
            showAlertWithMessage(header: "Not Enought Money", message: "Adjust your purchase or start to make your lemonade.")
        }
        
        numberOfIceCubesPurchasedLabel.text = "\(iceCubesPurchased)"
        numberOfIceInSupplyLabel.text = "\(numberOfIcesInSupply)"
        moneyInSupplyLabel.text = "\(moneyInSupply)"
    }
    
    @IBAction func purchaseIceMinusButtonPressed(sender: UIButton) {
        if iceCubesPurchased > 0 {
            numberOfIcesInSupply -= 1
            iceCubesPurchased -= 1
            moneyInSupply += 1
        } else {
            showAlertWithMessage(message: "No more ice cubes in your purchase.")
        }
        
        numberOfIceCubesPurchasedLabel.text = "\(iceCubesPurchased)"
        numberOfIceInSupplyLabel.text = "\(numberOfIcesInSupply)"
        moneyInSupplyLabel.text = "\(moneyInSupply)"
    }
    
    @IBAction func MixLemonsPlusButtonPressed(sender: UIButton) {
        if numberOfLemonsInSupply > 0 {
            lemonsMixed += 1
            numberOfLemonsInSupply -= 1
        } else {
            showAlertWithMessage(header: "No more lemons in your supply", message: "Buy more lemons or start to add ice.")
        }
        
        numberOfLemonsMixedLabel.text = "\(lemonsMixed)"
        numberOfLemonsInSupplyLabel.text = "\(numberOfLemonsInSupply)"
    }
    
    @IBAction func MixLemonsMinusButtonPressed(sender: UIButton) {
        if lemonsMixed > 0 {
            lemonsMixed -= 1
            numberOfLemonsInSupply += 1
        } else {
            showAlertWithMessage(message: "No lemons?! That's not lemonade!")
        }
        
        numberOfLemonsMixedLabel.text = "\(lemonsMixed)"
        numberOfLemonsInSupplyLabel.text = "\(numberOfLemonsInSupply)"
    }
    
    @IBAction func MixIcePlusButtonPressed(sender: UIButton) {
        if numberOfIcesInSupply > 0 {
            iceCubesMixed += 1
            numberOfIcesInSupply -= 1
        } else {
            showAlertWithMessage(header: "No more ice in your supply", message: "Buy more ice or start the day!")
        }
        
        numberOfIceInSupplyLabel.text = "\(numberOfIcesInSupply)"
        numberOfIceMixedLabel.text = "\(iceCubesMixed)"
    }
    
    @IBAction func MixIceMinusButtonPressed(sender: UIButton) {
        if iceCubesMixed > 0 {
            iceCubesMixed -= 1
            numberOfIcesInSupply += 1
        } else {
            showAlertWithMessage(message: "No Ice?! OK.")
        }
        
        numberOfIceInSupplyLabel.text = "\(numberOfIcesInSupply)"
        numberOfIceMixedLabel.text = "\(iceCubesMixed)"
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        
        var lemonadeRatio = Double(lemonsMixed) / Double(iceCubesMixed)
        var lemonadeType: String
        
        if lemonadeRatio > 1 {
            lemonadeType = "Acidic Lemonade"
        } else if lemonadeRatio == 1 {
            lemonadeType = "Equal Portioned Lemonade"
        } else {
            lemonadeType = "Diluted Lemonade"
        }
        
        var weatherToday = showWeatherToday()
        var numberOfCustomers = Int(arc4random_uniform(UInt32(10))) + 1
        if weatherToday == 0 {
            if numberOfCustomers > 3 {
                numberOfCustomers -= 3
            } else {
                numberOfCustomers = 0
            }
        } else if weatherToday == 2 {
            numberOfCustomers += 4
        }
        
        if numberOfCustomers >= 1 {
            for var index = 1; index <= numberOfCustomers; index++ {
                var customerPreferrenceRate = Double(Int(arc4random_uniform(UInt32(11))))/10.0
                var customerPreferrence: String
                if customerPreferrenceRate >= 0 && customerPreferrenceRate <= 0.4 {
                    customerPreferrence = "Acidic Lemonade"
                } else if customerPreferrenceRate > 0.4 && customerPreferrenceRate < 0.6 {
                    customerPreferrence = "Equal Portioned Lemonade"
                } else {
                    customerPreferrence = "Diluted Lemonade"
                }
                println("\(customerPreferrence) - \(customerPreferrenceRate)")
                
                if lemonadeType == customerPreferrence {
                    moneyInSupply += 1
                    moneyInSupplyLabel.text = "\(moneyInSupply)"
                    println("Paid")
                } else {
                    println("No match. No Revenue.")
                }
            }
        } else {
            println("It's too cold! No customers today!")
        }
        

        
        lemonsMixed = 0
        iceCubesMixed = 0
        lemonsPurchased = 0
        iceCubesPurchased = 0
        
        numberOfLemonsMixedLabel.text = "\(lemonsMixed)"
        numberOfIceMixedLabel.text = "\(iceCubesMixed)"
        numberOfLemonsPurchasedLabel.text = "\(lemonsPurchased)"
        numberOfIceCubesPurchasedLabel.text = "\(iceCubesPurchased)"
    }
    
    func showAlertWithMessage(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showWeatherToday() -> Int {
        weatherImageView.hidden = false
        let randomnNumber = Int(arc4random_uniform(UInt32(3)))
        switch randomnNumber {
        case 0:
            weatherImageView.image = UIImage(named: "Cold")
            return 0
        case 1:
            weatherImageView.image = UIImage(named: "Mild")
            return 1
        default:
            weatherImageView.image = UIImage(named: "Warm")
            return 2
        }
    }
    
}

