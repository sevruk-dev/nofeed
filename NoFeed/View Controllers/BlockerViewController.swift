//
//  BlockerViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BlockerViewController: UIViewController {
    
    fileprivate let cellReuseIdentifier = "blockerCell"
    fileprivate let headerReuseIdentifier = "blockerHeader"
    
    fileprivate let dataSource: BlockerDataProvider
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(BlockerCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.register(BlockerReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellReuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        
        view.backgroundColor = .white
        title = "No Feed"
        
        view.addSubview(collectionView)
        
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }

}

extension BlockerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfItems(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: headerReuseIdentifier, withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        guard let blockerHeader = headerView as? BlockerReusableView else { return headerView }
        
        blockerHeader.title = dataSource.titleForSupplementaryView(at: indexPath)
        return blockerHeader
    }
}

extension BlockerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // some stuff
    }
    
}
