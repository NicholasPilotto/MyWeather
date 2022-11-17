//
//  DailyInfoView.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 17/11/22.
//

import UIKit

class DailyInfoView: UIView {
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let weatherIcon: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        return image
    }()
    
    let hourLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(temperatureLabel)
        self.addSubview(weatherIcon)
        self.addSubview(hourLabel)
        
        temperatureLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 15)
        weatherIcon.anchor(temperatureLabel.bottomAnchor, left: self.centerXAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: -15, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        hourLabel.anchor(weatherIcon.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 12)
    }

}
