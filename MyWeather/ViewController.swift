//
//  ViewController.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 24/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var weatherView: MainWeatherView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(rgb: 0x000A17)
        let weatherView = MainWeatherView(frame: CGRect(x: 20, y: self.view.safeAreaInsets.top + 75, width: self.view.frame.width - 40, height: self.view.frame.height * 2/3))
        self.view.addSubview(weatherView)
    }
}

