//
//  BlockerViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BlockerViewController: UIViewController {
    
    fileprivate let blockerCellReuseIdentifier = "blockerCell"
    fileprivate let headerReuseIdentifier = "blockerHeader"
    
    fileprivate let dataSource: BlockerDataProvider
    private let containerManager: ContainerManagerProtocol = ContainerManager()
    private var currentPopupView: PopupView?
    
    fileprivate struct Constants {
        static let rowHeight: CGFloat = 95.0
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped).viewForAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BlockerReusableView.self, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
        tableView.register(BlockerTableViewCell.self, forCellReuseIdentifier: blockerCellReuseIdentifier)
        tableView.backgroundColor = .white
        tableView.rowHeight = Constants.rowHeight
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(with dataSource: BlockerDataProvider) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        title = "NoFeed"
        
        view.addSubview(tableView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(tableView.constraintsWithAnchorsEqual(to: view, with: UIEdgeInsets(top: 13.0, left: 0.0, bottom: 0.0, right: 0.0)))
    }
    
    fileprivate func setBlockerStateIfNeeded(for cell: BlockerTableViewCell) {
        
        guard let identifier = cell.dataSource?.identifier,
            let blockerIdenrifier = containerManager.blockerIndetifier(for: identifier) else {
                return
        }
        let modelExists = containerManager.modelExists(with: blockerIdenrifier)
        
        cell.setBlockerIsOn(modelExists)
    }

    // MARK: cell selected action
    
    fileprivate func selectBlocker(with cell: BlockerTableViewCell) {
        cell.selected()
        
        guard let id = cell.dataSource?.identifier, let blockerIdenrifier = containerManager.blockerIndetifier(for: id) else { return }
        
        if cell.isBlockerOn {
            containerManager.addModel(with: blockerIdenrifier)
        } else {
            containerManager.removeModel(with: blockerIdenrifier)
        }
    }
    
    // MARK: popupPresentstion
    
    fileprivate func presentBuyPremiumView() {
        guard let navigationView = navigationController?.view else { return }
        
        let popupView = PopupView(with: .buyPremium, purchaseBlock: {
            // purchase logic
        }, restoreBlock: {
            // restore purchase logic
            }).viewForAutoLayout()
        currentPopupView = popupView
        
        navigationController?.view.addSubview(popupView)
        NSLayoutConstraint.activate(popupView.constraintsWithAnchorsEqual(to: navigationView))
        
        UIView.animate(withDuration: 0.3) {
            popupView.isVisible = true
        }
    }
    
    private func presentLimitationsView() {
        guard let navigationView = navigationController?.view else { return }
        
        let popupView = PopupView(becomePremiumCompletion: nil).viewForAutoLayout()
        currentPopupView = popupView
        
        navigationController?.view.addSubview(popupView)
        NSLayoutConstraint.activate(popupView.constraintsWithAnchorsEqual(to: navigationView))
        
        UIView.animate(withDuration: 0.3) {
            popupView.isVisible = true
        }
    }
    
    private func hidePopup() {
        currentPopupView?.isVisible = false
        currentPopupView?.removeFromSuperview()
        currentPopupView = nil
    }
}

extension BlockerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: blockerCellReuseIdentifier, for: indexPath)
        
        guard let blockerCell = cell as? BlockerTableViewCell else {
            return cell
        }
        blockerCell.dataSource = dataSource.model(at: indexPath)
        setBlockerStateIfNeeded(for: blockerCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier)
        
        if let blockerHeader = headerView as? BlockerReusableView {
            blockerHeader.title = dataSource.titleForSupplementaryView()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33.0
    }
    
}

extension BlockerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let blockerCell = tableView.cellForRow(at: indexPath) as? BlockerTableViewCell else {
            return
        }
        selectBlocker(with: blockerCell)
    }
    
}
