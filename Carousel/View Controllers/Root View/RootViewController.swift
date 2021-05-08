//
//  RootViewController.swift
//  Carousel
//
//  Created by waheedCodes on 08/05/2021.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CollectionTableViewCell.self,
                       forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    private let viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(viewModels: [
            TileCollectionViewCellViewModel(name: "iPhone X", backgroundColor: .systemBlue),
            TileCollectionViewCellViewModel(name: "iPhone XR", backgroundColor: .systemPink),
            TileCollectionViewCellViewModel(name: "iPhone 11", backgroundColor: .systemTeal),
            TileCollectionViewCellViewModel(name: "iPhone 11 Pro", backgroundColor: .systemRed),
            TileCollectionViewCellViewModel(name: "iPhone 11 Pro Max", backgroundColor: .systemGreen),
            TileCollectionViewCellViewModel(name: "iPhone 12", backgroundColor: .systemGray),
            TileCollectionViewCellViewModel(name: "iPhone 12 Pro", backgroundColor: .systemPurple),
            TileCollectionViewCellViewModel(name: "iPhone 12 Pro Max", backgroundColor: .systemYellow)
        ])
    ]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension RootViewController: UITableViewDataSource {
    
    // MARK: - Datasource Methods
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CollectionTableViewCell.identifier,
                for: indexPath) as? CollectionTableViewCell else {
            fatalError()
        }
        
        let viewModel = viewModels[indexPath.row]
        cell.delegate = self
        cell.configure(with: viewModel)
        return cell
    }

}

extension RootViewController: UITableViewDelegate {
    
    // MARK: - Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width / 2
    }
}

extension RootViewController: CollectionTableViewCellDelegate {
    
    // MARK: -
    
    func didTapCollectionTableViewCell(with viewModel: TileCollectionViewCellViewModel) {
        let nameOfSelectedItem = viewModel.name
        let alertController = UIAlertController(
            title: nameOfSelectedItem,
            message: "You successfully selected: \(nameOfSelectedItem). Congratulations!!!",
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "OK",
                                        style: .cancel,
                                        handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
