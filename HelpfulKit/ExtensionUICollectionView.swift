//
//  ExtensionUICollectionView.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 16/10/23.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    /// Give Visible Current Cell IndexPath
    var visibleCurrentCellIndexPath: IndexPath? {
        if let cell = self.visibleCells.first {
           return self.indexPath(for: cell)
        }
        return nil
    }
    
    /// Visible Current Cell
    var visibleCurrentCell: UICollectionViewCell? {
        if let cell = self.visibleCells.first {
            return cell
        }
        return nil
    }
    
    func visibleIndex() -> IndexPath? {
        var visibleRect = CGRect()

        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size

        let visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect))

        let visibleIndexPath = self.indexPathForItem(at: visiblePoint)

        guard let indexPath = visibleIndexPath else { return nil}
        return indexPath
    }
    
    /// Convenience function for reloading data on the main thread.
    /// - Parameter queue: defualt is main.
    func reload(on queue: DispatchQueue = .main) {
        queue.async { self.reloadData() }
    }
    func dequeueCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withReuseIdentifier: Cell.className, for: indexPath) as? Cell
    }
    /// dequeues a cell of the type matching the cell argument's type, and assigns a view model to that cell.
    /// - Parameters:
    ///   - indexPath: indexpath of the cell
    ///   - cell: An argument only provided for the purpose to assist Swift's generic type inference.
    /// - Returns: returns a `UITableViewCell`
    func dequeueCell<T: UICollectionViewCell>(
        for indexPath: IndexPath, cell: T) -> UICollectionViewCell {
            guard let cell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else { return .init() }
            return cell
        }
    
    // MARK: - Convenience methods
    func register(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forCellWithReuseIdentifier: nibAndReuse)
    }
    func register(multiple: String...) {
        multiple.forEach { register($0) }
    }
    func registerforHeaderView(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nibAndReuse)
    }
    func registerforFooterView(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: nibAndReuse)
    }
    func setBoth<T>(_ dataSourceDelegate: T?) where T: UICollectionViewDataSource, T: UICollectionViewDelegate {
        dataSource = dataSourceDelegate
        delegate = dataSourceDelegate
    }
}
