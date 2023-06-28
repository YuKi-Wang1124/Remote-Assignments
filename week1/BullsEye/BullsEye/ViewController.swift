//
//  ViewController.swift
//  BullsEye
//
//  Created by 王昱淇 on 2023/6/28.
//

import UIKit

class ViewController: UIViewController {
    
    var targetNumber = 0
    var currentValue = 0
    var score = 0
    var round = 0
    

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetScoreLebal: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let roundedVaule = slider.value.rounded()
        currentValue = Int(roundedVaule)
        startNewRound()
    }
    
    
    @IBAction func showAlert() {
        
        // abs()可將負數變為正數
        let difference = abs(currentValue - targetNumber)
        let points = 100 - difference
        score += points
        
        let title : String
        
        if difference == 0 {
            title = "Perfect!"
            score += 100
        } else if difference < 5 {
            title = "You almost hit it!"
            if difference == 1 {
                score += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not Even close..."
        }
        
//        if difference < 0 {
//            difference = difference * -1
//            difference *= -1
//            difference = -difference
//        }
        
        let message = "Your Score is \(points)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok!", style: .default, handler: {
            action in
            // 在按下ＯＫ後開始重新的一輪
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true)
                
       
    }

    
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        let roundedVaule = slider.value.rounded()
        currentValue = Int(roundedVaule)
        
    }
    
    
    func startNewRound() {
        
        round += 1
        targetNumber = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabel()

    }

    func updateLabel() {
        targetScoreLebal.text = String(targetNumber)
        ScoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
}

