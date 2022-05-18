//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by Michael Nguyen on 5/16/22.
//

import UIKit
import React

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let textField = UITextField()
        textField.placeholder = "Please Enter a City Name"
        textField.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(textField)

        let searchButton = UIButton()
        searchButton.titleLabel?.textColor = .white
        searchButton.setTitle("Weather", for: .normal)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        let action = UIAction(title: "LOOKUP", image: nil, identifier: .none, attributes: [.destructive], state: .on) { action in
            guard let text = textField.text else { return }
            WeatherService.shared.currentWeather(city: text) { success, conditions, error in
                // do something with the conditions
                if let conditions = conditions, success {
                    do {
                        guard let encodedData = try? JSONEncoder().encode(conditions),
                              let json = String(data: encodedData, encoding: .utf8) else { return }
                        self.sendEvent("onReceiveWeatherConditions", body: ["response": json])
                    }
                }
                else {
                    print ("Error: \(error!.localizedDescription)")
                }
            }
        }
        searchButton.addAction(action, for: .touchUpInside)
        searchButton.backgroundColor = .blue
        searchButton.layer.cornerRadius = 10
        self.view.addSubview(searchButton)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            searchButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 20)
        ])
    }

    override func loadView() {
        loadReactNativeView()
    }

    func loadReactNativeView() {
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")!

        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "YourApp",
            initialProperties: nil,
            launchOptions: nil
        )
        self.view = rootView
    }

    func sendEvent(_ name: String, body: [String : Any]) {
        RNEventEmitter.emitter.sendEvent(withName: name, body: body)
    }
}

