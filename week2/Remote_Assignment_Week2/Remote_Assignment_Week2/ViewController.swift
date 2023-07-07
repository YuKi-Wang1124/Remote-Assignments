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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartView()
        changeContent()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    func setStartView() {
        view.addSubview(topLabel)
        view.addSubview(middleLabel)
        view.addSubview(button)
        
        topLabel.font = UIFont.systemFont(ofSize: 16)
        topLabel.textColor = UIColor.white
        topLabel.text = "Did you Know?"
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        middleLabel.font = UIFont.systemFont(ofSize: 16)
        middleLabel.textColor = UIColor.white
        middleLabel.lineBreakMode = .byWordWrapping
        middleLabel.numberOfLines = 0
        middleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.setTitle("Show Another Fun Fact", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
              topLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
              
              middleLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 100),
              middleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
              middleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
              
              button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
              button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
              button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
            ]
        )
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

