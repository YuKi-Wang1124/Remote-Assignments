//
//  ViewController.swift
//  URLSession
//
//  Created by 王昱淇 on 2023/7/22.
//

import UIKit

struct StationInfo: Codable {
    let stationID: String
    let stationName: String
    let stationAddress: String
}

class ViewController: UIViewController {
    var stationIDLabel = UILabel()
    var stationNameLabel = UILabel()
    var addressLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        getData()
        setLabelUI()
    }

    func getData() {
        DispatchQueue.global(qos: .userInteractive).async {
            if let url = URL(string: "https://remote-assignment.s3.ap-northeast-1.amazonaws.com/station") {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                let session = URLSession.shared
                let task = session.dataTask(with: request) { [self]
                    data, response, error in
                    do {
                        if let error = error { print(error) }
                        if let data = data {
                            let decoder = JSONDecoder()
                            let stationInfo = try decoder.decode(StationInfo.self, from: data)
                            Task {
                                @MainActor in
                                self.stationIDLabel.text = stationInfo.stationID
                                self.stationNameLabel.text = stationInfo.stationName
                                self.addressLabel.text = stationInfo.stationAddress
                            }
                        } else {
                            print("decode fail")
                        }
                    } catch { print(error) }
                }
                task.resume()
            } else {
                print("URL is fail.")
            }
        }
//        if let endPointURL = components.url {
//            Task {
//                do {
//                    let (data, _) = try await URLSession.shared.data(from: endPointURL)
//                    let decoder = JSONDecoder()
//                    let stationInfo = try decoder.decode(StationInfo.self, from: data)
//                    stationIDLabel.text = stationInfo.stationID
//                    stationNameLabel.text = stationInfo.stationName
//                    addressLabel.text = stationInfo.stationAddress
//                } catch {
//                    print(error)
//                }
//            }
//        }
    }
    
    func setLabelUI() {
        let labels = [stationIDLabel, stationNameLabel, addressLabel]
        labels.forEach {
            $0.textColor = UIColor.white
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        stationIDLabel.font = .systemFont(ofSize: 30)
        stationNameLabel.font = .systemFont(ofSize: 80)
        addressLabel.font = .systemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            stationNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stationNameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            stationIDLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stationIDLabel.bottomAnchor.constraint(equalTo: stationNameLabel.topAnchor, constant: -35),
            addressLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addressLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
        ])
    }
}

