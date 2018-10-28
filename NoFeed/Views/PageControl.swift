//
//  PageControl.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/12/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class PageControl: UIControl {
    
    var numberOfPages: Int = 0
    
    var spacing: CGFloat = 22.0
    var indicatorDiameter: CGFloat = 6.0
    var currentIndicatorDiameter: CGFloat = 10.0
    
    var pageIndicatorTintColor: UIColor = UIColor(netHex: 0xD8D8D8)
    var currentPageIndicatorTintColor: UIColor = UIColor.AppColors.lightPink
    
    
    var currentPage: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.1) { [weak self] in
                guard let self = self else { return }
                let newCenter = self.pageIndicators[self.currentPage].center
                self.currentPageIndicator.center = newCenter
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: private methods
    
    private lazy var pageIndicators: [UIView] = {
        return [
            pageIndicator(with: indicatorDiameter, backgroundColor: pageIndicatorTintColor),
            pageIndicator(with: indicatorDiameter, backgroundColor: pageIndicatorTintColor),
            pageIndicator(with: indicatorDiameter, backgroundColor: pageIndicatorTintColor)
        ]
        //        return [0..<numberOfPages].map { _ in
        //            pageIndicator(with: indicatorDiameter, backgroundColor: pageIndicatorTintColor)
        //        }
    }()
    private lazy var currentPageIndicator: UIView = {
        return pageIndicator(with: currentIndicatorDiameter, backgroundColor: currentPageIndicatorTintColor)
    }()
    
    private func pageIndicator(with diameter: CGFloat, backgroundColor: UIColor?) -> UIView {
        let view = UIView(frame: .zero).viewForAutoLayout()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = diameter / 2
        return view
    }
    
    private func setupViews() {
        (pageIndicators + [currentPageIndicator]).forEach { addSubview($0) }
        
        setupLayout()
        setInitialLocation()
    }
    
    private func setInitialLocation() {
        let firstDot = pageIndicators[0]
        currentPageIndicator.center = firstDot.center
    }
    
    
    // MARK: layout
    
    private func setupLayout() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: sizeConstraints())
        
        let isEvenNumber = Double(pageIndicators.count).truncatingRemainder(dividingBy: 2.0) == 0.0
        let initialElementIndex = isEvenNumber ? (pageIndicators.count / 2) - 1 : (pageIndicators.count / 2)
        let initialElement = pageIndicators[initialElementIndex]
        
        for index in 0...pageIndicators.count - 1 {
            let view = pageIndicators[index]
            let constraint: NSLayoutConstraint
            
            if (index != initialElementIndex) {
                constraint = view.centerXAnchor.constraint(equalTo: initialElement.centerXAnchor, constant: (CGFloat(index - initialElementIndex) * spacing))
            } else {
                constraint = view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: isEvenNumber ? -(spacing / 2) : 0.0)
            }
            
            constraints.append(constraint)
        }
        
        (pageIndicators + [currentPageIndicator]).forEach {
            constraints.append($0.centerYAnchor.constraint(equalTo: centerYAnchor))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func sizeConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: constraintsWithHeightAndWidth(equalTo: currentIndicatorDiameter, for: currentPageIndicator))
        pageIndicators.forEach { view in
            constraints.append(contentsOf: constraintsWithHeightAndWidth(equalTo: indicatorDiameter, for: view))
        }
        
        return constraints
    }
    
    private func constraintsWithHeightAndWidth(equalTo constant: CGFloat, for view: UIView) -> [NSLayoutConstraint] {
        return [
            view.heightAnchor.constraint(equalToConstant: constant),
            view.widthAnchor.constraint(equalTo: view.heightAnchor)
        ]
    }
}
