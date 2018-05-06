//
//  ViewController.swift
//  BullsEye
//
//  Created by admin on 06/05/18.
//  Copyright © 2018 mohitsharmadl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var roundNumber = 0
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startOver()
        
        //Custom coded slider modifications added here b'coz Xcode doesn't provide ability to do it using GUI
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") //UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") //UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft") //UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight") //UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for:.normal)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(roundNumber)
    }
    
    func startNewRound() {
        roundNumber += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The value of the slider is now : \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        
        let points = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            score += 100
        }else if difference < 5 {
            title = "You almost had it"
            if difference == 1 {
                score += 50
            }
        }else if difference < 10 {
            title = "Pretty Good!!"
        }else {
            title = "Not even close... "
        }
        
        score += points
        
        let message = "You scored \(points) "
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })   //swift closure -- method without a name
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
     
    }
    
    @IBAction func startOver() {
        roundNumber = 0
        score = 0
        startNewRound()
    }
}

