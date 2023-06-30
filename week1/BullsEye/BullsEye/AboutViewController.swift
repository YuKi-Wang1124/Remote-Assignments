//
//  AboutViewController.swift
//  BullsEye
//
//  Created by 王昱淇 on 2023/6/29.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://www.google.com/") {
            let request = URLRequest(url: url)
            webview.load(request)
        }
        
    }
          
    
    @IBAction func close(_ button: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
