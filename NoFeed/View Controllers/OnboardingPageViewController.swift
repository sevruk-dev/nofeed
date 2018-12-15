//
//  OnboardingPageViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/24/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import Sevruk_PageControl

protocol OnboardingDelegate: class {
    func onboardingCompleted()
}

class OnboardingPageViewController: UIViewController {
    
    weak var delegate: OnboardingDelegate?
    
    private let dataSource: OnboardingDataSourceProtocol

    private lazy var pageControl: PageControl = {
        let pageControl = PageControl().viewForAutoLayout()
        pageControl.indicatorTintColor = UIColor.AppColors.pageControlGray
        pageControl.currentIndicatorTintColor = UIColor.AppColors.lightPink
        return pageControl
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system).viewForAutoLayout()
        button.backgroundColor = .clear
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.AppColors.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.avenirNextRegular(of: 18.0)
        return button
    }()
    
    private let doneButton: UIControl = RoundButton().viewForAutoLayout()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView().viewForAutoLayout()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        return scrollView
    }()
    
    init(with dataSource: OnboardingDataSourceProtocol) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        pageControl.numberOfPages = dataSource.controllers.count
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        dataSource.controllers.last?.view.addSubview(doneButton)
        dataSource.controllers.forEach { addToHierarchy($0) }
        
        view.bringSubviewToFront(skipButton)
        view.bringSubviewToFront(pageControl)
        
        scrollView.delegate = self
        
        skipButton.addTarget(self, action: #selector(completeOnboarding), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(completeOnboarding), for: .touchUpInside)
        doneButton.alpha = 0.0
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    @objc private func completeOnboarding() {
        delegate?.onboardingCompleted()
    }
    
    //MARK: KVO
    
    private struct Observers {
        static let contentOffset = "contentOffset"
    }
    
    private func setupObservers() {
        scrollView.addObserver(self, forKeyPath: Observers.contentOffset, options: [.old, .new], context: nil)
    }
    
    private func removeObservers() {
        scrollView.removeObserver(self, forKeyPath: Observers.contentOffset)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Observers.contentOffset {
            guard let scrollView = object as? UIScrollView else { return }
            let controllersCount = dataSource.controllers.count
            let controllerWidth = scrollView.contentSize.width / CGFloat(controllersCount)
            
            guard scrollView.contentOffset.x > 0.0 && scrollView.contentOffset.x < CGFloat(controllersCount - 1) * controllerWidth else {
                return
            }
            
            let relativeOffset = scrollView.contentOffset.x.truncatingRemainder(dividingBy: controllerWidth)
            let leftControllerShown = abs((relativeOffset - controllerWidth) / controllerWidth)
            let rightControllerShown = 1 - leftControllerShown
            let leftControllerIndex = Int(scrollView.contentOffset.x / controllerWidth)
            let rightControllerIndex = leftControllerIndex + 1
            
            let leftVC = dataSource.controllers[leftControllerIndex]
            let rightVC = dataSource.controllers[rightControllerIndex]
            leftVC.view.alpha = leftControllerShown
            rightVC.view.alpha = rightControllerShown
            
            if rightControllerIndex == controllersCount - 1 {
                doneButton.alpha = rightControllerShown
                skipButton.alpha = leftControllerShown
                pageControl.alpha = leftControllerShown
            }
        }
    }
    
    //MARK: Constraints
    
    private func setupConstraints() {
        guard let lastController = dataSource.controllers.last else { return }
        setupControllerConstraints()
        
        let scrollViewContraints = scrollView.constraintsWithAnchorsEqual(to: view)
        let pageConstraints = [
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -57.0),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10.0),
            pageControl.widthAnchor.constraint(equalToConstant: 58.0)
        ]
        let skipButtonConstraints = [
            skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            skipButton.heightAnchor.constraint(equalToConstant: 40.0),
            skipButton.widthAnchor.constraint(equalToConstant: 70.0),
            skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
        ]
        let doneButtonConstraints = [
            doneButton.bottomAnchor.constraint(equalTo: lastController.view.bottomAnchor, constant: -32.0),
            doneButton.centerXAnchor.constraint(equalTo: lastController.view.centerXAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 60.0),
            doneButton.widthAnchor.constraint(equalTo: doneButton.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewContraints + pageConstraints + skipButtonConstraints + doneButtonConstraints)
    }
    
    private func setupControllerConstraints() {
        var lastView: UIView = scrollView
        var constraints: [NSLayoutConstraint] = []
        
        for controller in dataSource.controllers {
            let leftAnchor: NSLayoutXAxisAnchor = (controller == dataSource.controllers.first) ? lastView.leftAnchor : lastView.rightAnchor
            
            constraints.append(controller.view.widthAnchor.constraint(equalTo: lastView.widthAnchor))
            constraints.append(controller.view.heightAnchor.constraint(equalTo: lastView.heightAnchor))
            constraints.append(controller.view.leftAnchor.constraint(equalTo: leftAnchor))
            
            if (controller == dataSource.controllers.last) {
                constraints.append(controller.view.rightAnchor.constraint(equalTo: scrollView.rightAnchor))
            }
            lastView = controller.view
        }

        NSLayoutConstraint.activate(constraints)
    }
    
    private func addToHierarchy(_ viewController: UIViewController) {
        _ = viewController.view.viewForAutoLayout()
        
        scrollView.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
}

extension OnboardingPageViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let controllersCount = dataSource.controllers.count
        let controllerWidth = Int(scrollView.contentSize.width) / controllersCount
        let controllerIndex = Int(scrollView.contentOffset.x) / controllerWidth
        pageControl.currentPage = controllerIndex
    }
    
}
