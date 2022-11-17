//
//  ViewController.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 24/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var weatherView: MainWeatherView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(rgb: 0x000A17)
        let weatherView = MainWeatherView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: self.view.frame.height * 2/3))
        let dailyView = SecondaryView()
        self.view.addSubview(weatherView)
        self.view.addSubview(dailyView)
        
        weatherView.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: self.view.frame.height * 2/3)
        dailyView.anchor(weatherView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

