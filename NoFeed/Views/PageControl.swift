//
//  PageControl.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/12/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class PageControl: UIControl {
    
    var currentPage: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.1) {
                let newCenter = self.unselectedDots[self.currentPage].center
                self.selectedDot.center = newCenter
            }
        }
    }
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        (unselectedDots + [selectedDot]).forEach { addSubview($0) }
        
        setupLayout()
        setInitialLocation()
    }
    
    private func setInitialLocation() {
        let firstDot = unselectedDots[0]
        selectedDot.center = firstDot.center
    }
    
    private func setupLayout() {
        let leftDot = unselectedDots[0]
        let middleDot = unselectedDots[1]
        let rightDot = unselectedDots[2]
        
        var unselectedDotsConstraints: [NSLayoutConstraint] = []
        unselectedDots.forEach { view in
            unselectedDotsConstraints.append(view.heightAnchor.constraint(equalToConstant: unselectedDotDiameter))
            unselectedDotsConstraints.append(view.widthAnchor.constraint(equalToConstant: unselectedDotDiameter))
        }
        
        NSLayoutConstraint.activate([
            middleDot.centerXAnchor.constraint(equalTo: centerXAnchor),
            middleDot.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftDot.centerXAnchor.constraint(equalTo: middleDot.centerXAnchor, constant: -spacing),
            leftDot.centerYAnchor.constraint(equalTo: middleDot.centerYAnchor),
            rightDot.centerXAnchor.constraint(equalTo: middleDot.centerXAnchor, constant: spacing),
            rightDot.centerYAnchor.constraint(equalTo: middleDot.centerYAnchor),
            selectedDot.centerYAnchor.constraint(equalTo: rightDot.centerYAnchor),
            selectedDot.heightAnchor.constraint(equalToConstant: selectedDotDiameter),
            selectedDot.widthAnchor.constraint(equalToConstant: selectedDotDiameter)
            ] + unselectedDotsConstraints)
    }
    
    private func dotView(with diameter: CGFloat, backgroundColor: UIColor) -> UIView {
        let view = UIView(frame: .zero).viewForAutoLayout()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = diameter / 2
        return view
    }
}
