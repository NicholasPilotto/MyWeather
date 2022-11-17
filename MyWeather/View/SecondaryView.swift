//
//  SecondaryView.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 17/11/22.
//

import UIKit

class SecondaryView: UIView {

    let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(todayLabel)
        self.addSubview(infoStack)
        
        todayLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 22, bottomConstant: 0, rightConstant: 22, widthConstant: 0, heightConstant: 25)
        infoStack.anchor(todayLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 22, bottomConstant: 0, rightConstant: 22, widthConstant: 0, heightConstant: 85)
        
        let a = DailyInfoView()
        let s = DailyInfoView()
        let d = DailyInfoView()
        let f = DailyInfoView()
        let g = DailyInfoView()
        
        infoStack.addArrangedSubview(a)
        infoStack.addArrangedSubview(s)
        infoStack.addArrangedSubview(d)
        infoStack.addArrangedSubview(f)
        infoStack.addArrangedSubview(g)
    }
    
}
