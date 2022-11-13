//
//  MainWeatherView.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 13/11/22.
//

import UIKit

class MainWeatherView: UIView {
    
    private var gradientLayer = CAGradientLayer()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.tintColor = .white
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 55, weight: .heavy)
        label.tintColor = .white
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.tintColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.tintColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackgroundColorGradient() {
        let colorTop = UIColor(rgb: 0x15C1F4).cgColor
        let colorBottom = UIColor(rgb: 0x1182FA).cgColor
        
        self.gradientLayer.colors = [colorTop, colorBottom]
        self.gradientLayer.locations = [0.0, 1.0]
        self.gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 30
        setBackgroundColorGradient()
    }
}
