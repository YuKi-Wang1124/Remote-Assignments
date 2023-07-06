//
//  ViewController.swift
//  Remote_Assignment_Week2
//
//  Created by 王昱淇 on 2023/7/6.
//

import UIKit

class ViewController: UIViewController {
    
    var topLabel = UILabel()
    var middleLabel = UILabel()
    var button = UIButton()
    
    let colorPairs: [colorPair] = [
        colorPair(color: UIColor(red: 1, green: 0.68, blue: 0.74, alpha: 1), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempus."),
        colorPair(color: UIColor(red: 1.00, green: 0.64, blue: 0.52, alpha: 1.00), text: "Contrary to popular belief, Lorem Ipsum is not simply random text."),
        colorPair(color: UIColor(red: 0.84, green: 0.68, blue: 0.38, alpha: 1.00), text: "Richard McClintock, a Latin professor at Hampden-Sydney College in "),
        colorPair(color: UIColor(red: 0.35, green: 0.60, blue: 0.10, alpha: 1.00), text: "looked up one of the more obscure Latin words, consectetur"),
        colorPair(color: UIColor(red: 0.49, green: 0.78, blue: 0.89, alpha: 1.00), text: "from a Lorem Ipsum passage, and going through the cities of the word"),
        colorPair(color: UIColor(red: 0.08, green: 0.36, blue: 0.63, alpha: 1.00), text: "This book is a treatise on the theory of ethics, very popular during the."),
        colorPair(color: UIColor(red: 0.66, green: 0.53, blue: 0.63, alpha: 1.00), text: "The first line of Lorem Ipsum, Lorem ipsum dolor sit amet..")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.frame = CGRect(x: 40, y: 100, width: 100, height: 100)
        middleLabel.frame = CGRect(x: 40, y: 200, width: 100, height: 100)
        button.frame = CGRect(x: 100, y: 500, width: 250, height: 100)

        changeContent()
        setStartView()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

    }

    func setStartView() {
        topLabel.font = UIFont.systemFont(ofSize: 16)
        topLabel.textColor = UIColor.white
        topLabel.text = "Did yoy Know?"
                
        middleLabel.font = UIFont.systemFont(ofSize: 16)
        middleLabel.textColor = UIColor.white
        
        button.setTitle("Show Another Fun Fact", for: .normal)
        button.backgroundColor = .white
        
//        NSLayoutConstraint.activate([
//
//
//
//        ])
        
     
//        topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive
//        topLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive
        
        
        
       // button.font = UIFont.systemFont(ofSize: 16)

        
        view.addSubview(topLabel)
        view.addSubview(middleLabel)
        view.addSubview(button)
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        changeContent()
    }
    
    func changeContent() {
        let randomColorPair = colorPairs.randomElement()
        button.setTitleColor(randomColorPair?.color, for: .normal)
        view.backgroundColor = randomColorPair?.color
        middleLabel.text = randomColorPair?.text
    }

}

