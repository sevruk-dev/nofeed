//
//  OnboardingPageViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/24/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import InsiderPageControl

protocol OnboardingDelegate: class {
    func onboardingCompleted()
}

class OnboardingPageViewController: UIViewController {
    
    weak var delegate: OnboardingDelegate?
    
    private struct Observers {
        static let contentOffset = "contentOffset"
    }
    
    private var onBoardingViewControllers: [UIViewController] = [] {
        didSet {
            pageControl.numberOfPages = onBoardingViewControllers.count
        }
    }

    fileprivate lazy var pageControl: PageControl = {
        let pageControl = PageControl().viewForAutoLayout()
        pageControl.indicatorTintColor = UIColor.AppColors.pageControlGray
        pageControl.currentIndicatorTintColor = UIColor.AppColors.lightPink
        return pageControl
    }()
    
    fileprivate let skipButton: UIButton = {
        let button = UIButton(type: .system).viewForAutoLayout()
        button.backgroundColor = .clear
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.AppColors.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.avenirNextRegular(of: 18.0)
        return button
    }()
    
    fileprivate let doneButton: UIControl = RoundButton().viewForAutoLayout()
    
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
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: Observers.contentOffset)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
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
    
    @objc private func completeOnboarding() {
        delegate?.onboardingCompleted()
    }
    
    //MARK: KVO
    
    private func setupObservers() {
        scrollView.addObserver(self, forKeyPath: Observers.contentOffset, options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Observers.contentOffset {
            guard let scrollView = object as? UIScrollView else { return }
            let controllersCount = onBoardingViewControllers.count
            let controllerWidth = scrollView.contentSize.width / CGFloat(controllersCount)
            
            guard scrollView.contentOffset.x > 0.0 && scrollView.contentOffset.x < CGFloat(controllersCount - 1) * controllerWidth else {
                return
            }
            
            let relativeOffset = scrollView.contentOffset.x.truncatingRemainder(dividingBy: controllerWidth)
            let leftControllerShown = abs((relativeOffset - controllerWidth) / controllerWidth)
            let rightControllerShown = 1 - leftControllerShown
            let leftControllerIndex = Int(scrollView.contentOffset.x / controllerWidth)
            let rightControllerIndex = leftControllerIndex + 1
            
            let leftVC = onBoardingViewControllers[leftControllerIndex]
            let rightVC = onBoardingViewControllers[rightControllerIndex]
            leftVC.view.alpha = leftControllerShown
            rightVC.view.alpha = rightControllerShown
            
            if rightControllerIndex == 2 {
                doneButton.alpha = rightControllerShown
                skipButton.alpha = leftControllerShown
                pageControl.alpha = leftControllerShown
            }
        }
    }
    
    //MARK: Constraints
    
    private func setupConstraints() {
        setupControllersWithConstraints()
        
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
        
        NSLayoutConstraint.activate(scrollViewContraints + pageConstraints + skipButtonConstraints)
    }
    
    private func setupControllersWithConstraints() {
        
        let page1 = OnboardingViewController(with: UIImage(named: "onboarding-1"), title: "Current limitations", description: "Unfortunately limiting App’s traffic is not available in iOS, at least yet.\n We’re only available to filter content in Safari and this is what our App is about.")
        let page2 = OnboardingViewController(with: .table, dataSource: BlockerDataSource(), title: "How it works?", description: "To start blocking a feed choose one from the list, touch it and enjoy your NoFeed experience.")
        let page3 = OnboardingViewController(with: UIImage(named: "onboarding-2"), title: "One more thing…", description: "We’re welcome to present you with a\n3-day Premium experience. Enjoy it!")
        page3.view.addSubview(doneButton)
        onBoardingViewControllers = [page1, page2, page3]
        onBoardingViewControllers.forEach { addToHierarchy($0) }
        
        let views: [String: UIView] = ["view": view, "page1": page1.view, "page2": page2.view, "page3": page3.view]
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[page1(==view)]|", options: [], metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[page1(==view)][page2(==view)][page3(==view)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        
        let doneButtonConstraints = [
            doneButton.bottomAnchor.constraint(equalTo: page3.view.bottomAnchor, constant: -32.0),
            doneButton.centerXAnchor.constraint(equalTo: page3.view.centerXAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 60.0),
            doneButton.widthAnchor.constraint(equalTo: doneButton.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(verticalConstraints + horizontalConstraints + doneButtonConstraints)
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
        let controllersCount = onBoardingViewControllers.count
        let controllerWidth = Int(scrollView.contentSize.width) / controllersCount
        let controllerIndex = Int(scrollView.contentOffset.x) / controllerWidth
        pageControl.currentPage = controllerIndex
    }
    
}
