//
//  OnboardingPageViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/24/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIViewController {
    
    private struct Observers {
        static let contentOffset = "contentOffset"
    }
    
    private var onBoardingViewControllers: [UIViewController] = [] {
        didSet { pageControl.numberOfPages = onBoardingViewControllers.count }
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl().viewForAutoLayout()
        pageControl.numberOfPages = onBoardingViewControllers.count
        pageControl.pageIndicatorTintColor = UIColor.AppColors.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.AppColors.lightPink
        return pageControl
    }()
    
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
        view.bringSubviewToFront(pageControl)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupObservers()
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
            print("[vova]: currentOffset x:\(scrollView.contentOffset.x)")
            
            guard scrollView.contentOffset.x > 0.0 && scrollView.contentOffset.x < CGFloat(controllersCount - 1) * controllerWidth else {
                return
            }
            
            let relativeOffset = scrollView.contentOffset.x.truncatingRemainder(dividingBy: controllerWidth)
            let leftControllerShown = abs((relativeOffset - controllerWidth) / controllerWidth)
            let rightControllerShown = 1 - leftControllerShown
            let leftControllerIndex = Int(scrollView.contentOffset.x / controllerWidth)
            let rightControllerIndex = leftControllerIndex + 1
            
            print("[vova]: relativeOffset :\(relativeOffset)")
            print("[vova]: leftControllerIndex: \(leftControllerIndex)")
            print("[vova]: rightControllerIndex: \(rightControllerIndex)")
            print("[vova]: leftControllerShown: \(leftControllerShown)")
            print("[vova]: rightOne: \(rightControllerShown)\n\n")
            
            let leftVC = onBoardingViewControllers[leftControllerIndex]
            let rightVC = onBoardingViewControllers[rightControllerIndex]
            leftVC.view.alpha = leftControllerShown
            rightVC.view.alpha = rightControllerShown
        }
    }
    
    //MARK: Constraints
    
    private func setupConstraints() {
        setupControllersWithConstraints()
        
        let scrollViewContraints = scrollView.constraintsWithAnchorsEqual(to: view)
        let pageConstraints = [
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10.0),
            pageControl.widthAnchor.constraint(equalToConstant: 60.0)
        ]
        
        NSLayoutConstraint.activate(scrollViewContraints + pageConstraints)
    }
    
    private func setupControllersWithConstraints() {
        
        let page1 = ViewController(with: "View Controller №1")
        let page2 = ViewController(with: "View Controller №2")
        let page3 = ViewController(with: "View Controller №3")
        onBoardingViewControllers = [page1, page2, page3]
        onBoardingViewControllers.forEach { addToHierarchy($0) }
        
        let views: [String: UIView] = ["view": view, "page1": page1.view, "page2": page2.view, "page3": page3.view]
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[page1(==view)]|", options: [], metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[page1(==view)][page2(==view)][page3(==view)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(verticalConstraints + horizontalConstraints)
    }
    
    private func addToHierarchy(_ viewController: UIViewController) {
        _ = viewController.view.viewForAutoLayout()
        
        scrollView.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
}
