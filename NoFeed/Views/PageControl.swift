//
//  PageControl.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/12/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class PageControl: UIControl {
    
    var numberOfPages: Int = 0 {
        didSet {
            removeViews()
            setupViews()
        }
    }
    
    var spacing: CGFloat = 22.0 {
        didSet {
            //TODO: refactor to make it more efficient
            removeViews()
            setupViews()
        }
    }
    
    var indicatorDiameter: CGFloat = 6.0 {
        didSet {
            NSLayoutConstraint.deactivate(sizeConstraints)
            setupSizeConstraints()
        }
    }
    
    var currentIndicatorDiameter: CGFloat = 10.0 {
        didSet {
            NSLayoutConstraint.deactivate(sizeConstraints)
            setupSizeConstraints()
        }
    }
    
    var pageIndicatorTintColor: UIColor = UIColor(netHex: 0xD8D8D8) {
        didSet {
            pageIndicators.forEach { $0.backgroundColor = pageIndicatorTintColor }
        }
    }
    
    var currentPageIndicatorTintColor: UIColor = UIColor(netHex: 0xFF3482) {
        didSet {
            currentPageIndicator.backgroundColor = currentPageIndicatorTintColor
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.1) { [weak self] in
                guard let self = self, self.pageIndicators.count > self.currentPage else {
                    return
                }
                let newCenter = self.pageIndicators[self.currentPage].center
                self.currentPageIndicator.center = newCenter
            }
        }
    }
    
    //MARK: private methods
    
    private lazy var currentPageIndicator: UIView = {
        return pageIndicator(with: currentIndicatorDiameter, backgroundColor: currentPageIndicatorTintColor)
    }()
    private var pageIndicators: [UIView] = []
    
    private var sizeConstraints: [NSLayoutConstraint] = []
    
    private func pageIndicator(with diameter: CGFloat, backgroundColor: UIColor?) -> UIView {
        let view = UIView(frame: .zero).viewForAutoLayout()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = diameter / 2
        return view
    }
    
    private func removeViews() {
        for view in subviews {
            pageIndicators = []
            sizeConstraints = []
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
        }
    }
    
    private func setupViews() {
        if numberOfPages != 0 {
            for _ in 0..<numberOfPages {
                pageIndicators.append(pageIndicator(with: indicatorDiameter, backgroundColor: pageIndicatorTintColor))
            }
            
            (pageIndicators + [currentPageIndicator]).forEach { addSubview($0) }
            
            setupLayout()
            
            setCurrrentIndicatorLocation()
        }
    }
    
    private func setCurrrentIndicatorLocation() {
        if numberOfPages != 0 {
            let firstDot = pageIndicators[0]
            currentPageIndicator.center = firstDot.center
        }
    }
    
    // MARK: layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard pageIndicators.count > currentPage else { return }
        let updatedCenter = pageIndicators[currentPage].center
        
        if self.currentPageIndicator.center != updatedCenter {
            self.currentPageIndicator.center = updatedCenter
        }
    }
    
    private func setupLayout() {
        var constraints = [NSLayoutConstraint]()
        
        setupSizeConstraints()
        
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
    
    private func setupSizeConstraints () {
        pageIndicators.forEach { $0.layer.cornerRadius = indicatorDiameter / 2.0 }
        sizeConstraints = sizeConstraintsForIndicators()
        NSLayoutConstraint.activate(sizeConstraints)
    }
    
    private func sizeConstraintsForIndicators() -> [NSLayoutConstraint] {
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
