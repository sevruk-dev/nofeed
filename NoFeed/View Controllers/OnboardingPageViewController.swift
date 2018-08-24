//
//  OnboardingPageViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/24/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = onBoardingViewControllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.AppColors.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.AppColors.lightPink
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(pageControl)
        view.bringSubview(toFront: pageControl)
        
        dataSource = self
        delegate = self
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setInitialViewController()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0),
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        pageControl.heightAnchor.constraint(equalToConstant: 10.0),
        pageControl.widthAnchor.constraint(equalToConstant: 60.0)
        ])
    }
    
    private func setInitialViewController() {
        guard let initialController = onBoardingViewControllers.first else { return }
        
        setViewControllers([initialController], direction: .forward, animated: false)
    }
    
    fileprivate lazy var onBoardingViewControllers: [UIViewController] = {
        return [1,2,3].map({ index -> UIViewController in
            let viewController = ViewController()
            viewController.label.text = "ViewController №\(index)"
            return viewController
        })
    }()

}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first as? ViewController else { return }
        guard let index = onBoardingViewControllers.index(of: currentViewController) else { return }
        pageControl.currentPage = index
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = onBoardingViewControllers.index(of: viewController) else { return nil }
        guard index > 0 else { return nil }
        
        return onBoardingViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = onBoardingViewControllers.index(of: viewController) else { return nil }
        guard index < onBoardingViewControllers.count - 1 else { return nil }
        
        return onBoardingViewControllers[index + 1]
    }
}
