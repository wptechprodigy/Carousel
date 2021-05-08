//
//  CollectionTableViewCell.swift
//  Carousel
//
//  Created by waheedCodes on 08/05/2021.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func didTapCollectionTableViewCell(with viewModel: TileCollectionViewCellViewModel)
}

class CollectionTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let identifier = "CollectionTableViewCell"
    
    // MARK: - Properties
    
    private var viewModels: [TileCollectionViewCellViewModel] = []
    
    weak var delegate: CollectionTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        
        collectionView.register(TileCollectionViewCell.self,
                                forCellWithReuseIdentifier: TileCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: - Add Collection view to table cell
        
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    // MARK: - Helper Methods
    
    func configure(with viewModel: CollectionTableViewCellViewModel) {
        self.viewModels = viewModel.viewModels
        collectionView.reloadData()
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Collection View Delegate and Datasource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TileCollectionViewCell.identifier,
            for: indexPath
        ) as? TileCollectionViewCell else {
            fatalError()
        }
        
        collectionCell.configure(with: viewModels[indexPath.row])
        
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let viewModel = viewModels[indexPath.row]
        delegate?.didTapCollectionTableViewCell(with: viewModel)
    }
    
}

extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection Cell Layout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.frame.size.width / 2.0
        let height = width / 1.2
        return CGSize(width: width, height: height)
    }
}
