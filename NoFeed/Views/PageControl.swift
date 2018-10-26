//
//  PageControl.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/12/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class PageControl: UIControl {
    
    private let spacing: CGFloat = 22.0
    private let unselectedDotDiameter: CGFloat = 6.0
    private let selectedDotDiameter: CGFloat = 10.0
    
    private let unselectedDotColor: UIColor = UIColor(netHex: 0xD8D8D8)
    private let selectedDotColor: UIColor = UIColor.AppColors.lightPink
    
    private lazy var unselectedDots: [UIView] = {
        return [dotView(with: unselectedDotDiameter, backgroundColor: unselectedDotColor),
                dotView(with: unselectedDotDiameter, backgroundColor: unselectedDotColor),
                dotView(with: unselectedDotDiameter, backgroundColor: unselectedDotColor)]
    }()
    private lazy var selectedDot: UIView = {
        return dotView(with: selectedDotDiameter, backgroundColor: selectedDotColor)
    }()
    
    var currentPage: Int = 0 {
        didSet {
//            selectedDot.frame = CGRect(origin: <#T##CGPoint#>, size: <#T##CGSize#>)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        selectedDot.isHidden = true
        
        addSubview(selectedDot)
        unselectedDots.forEach { addSubview($0) }
        setupLayout()
    }
    
    private func setupLayout() {
        let leftDot = unselectedDots[0]
        let middleDot = unselectedDots[1]
        let rightDot = unselectedDots[2]
        
        NSLayoutConstraint.activate([
            middleDot.centerXAnchor.constraint(equalTo: centerXAnchor),
            middleDot.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftDot.centerXAnchor.constraint(equalTo: middleDot.centerXAnchor, constant: -spacing),
            leftDot.centerYAnchor.constraint(equalTo: middleDot.centerYAnchor),
            rightDot.centerXAnchor.constraint(equalTo: middleDot.centerXAnchor, constant: spacing),
            rightDot.centerYAnchor.constraint(equalTo: rightDot.centerYAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dotView(with diameter: CGFloat, backgroundColor: UIColor) -> UIView {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter)).viewForAutoLayout()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = diameter / 2
        return view
    }
}
