//
//  DailyInfoView.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 17/11/22.
//

import UIKit

class DailyInfoView: UIView {
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(temperatureLabel)
        self.addSubview(weatherIcon)
        self.addSubview(hourLabel)
        
        temperatureLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 15)
        weatherIcon.anchor(temperatureLabel.bottomAnchor, left: self.centerXAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: -15, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        hourLabel.anchor(weatherIcon.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 12)
    }
    
    public func configure(viewModel: SecondaryViewViewModel) {
        self.temperatureLabel.text = "\(viewModel.temperature)\(viewModel.temperatureUnit)"
        self.weatherIcon.image = UIImage(named: viewModel.iconImage)?.withRenderingMode(.alwaysTemplate)
        self.hourLabel.text = viewModel.time
    }
}
