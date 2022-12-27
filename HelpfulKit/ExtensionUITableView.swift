//
//  ExtensionUITableView.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

public extension UITableView {
    /// Convenience function for reloading data on the main thread.
    /// - Parameter queue: defualt is main.
    func reload(on queue: DispatchQueue = .main) {
        queue.async { self.reloadData() }
    }
    
    func dequeueCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withIdentifier: Cell.className, for: indexPath) as? Cell
    }
    
    /// dequeues a cell of the type matching the cell argument's type, and assigns a view model to that cell.
    /// - Parameters:
    ///   - indexPath: indexpath of the cell
    ///   - cell: An argument only provided for the purpose to assist Swift's generic type inference.
    /// - Returns: returns a `UITableViewCell`
    func dequeueCell<T: UITableViewCell>(
        for indexPath: IndexPath, cell: T) -> UITableViewCell
    {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else { return .init() }
        return cell
    }
    
    /// dequeues a UITableViewHeaderFooterView of the type matching the
    /// UITableViewHeaderFooterView argument's type, and assigns a view model to that
    /// UITableViewHeaderFooterView.
    ///
    /// - Parameters:
    ///   - section: An argument only provided for the purpose to assist Swift's generic type inference.
    /// - Returns: returns a `UITableViewHeaderFooterView`
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        section: T) -> UITableViewHeaderFooterView
    {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else { return .init() }
        
        return cell
    }
    
    
    // MARK: - Convenience methods
    
    func register(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forCellReuseIdentifier: nibAndReuse)
    }
    func register(multiple: String...) {
        multiple.forEach { register($0) }
    }
    
    
    func registerforHeaderFooterView(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forHeaderFooterViewReuseIdentifier: nibAndReuse)
    }
    func registerforHeaderFooterView(multiple: String...) {
        multiple.forEach { registerforHeaderFooterView($0) }
    }
    
    
    func setBoth<T>(_ dataSourceDelegate: T?) where T: UITableViewDataSource, T: UITableViewDelegate {
        dataSource = dataSourceDelegate
        delegate = dataSourceDelegate
    }
    
    func insert(atIndexPath indexPath: IndexPath) {
        beginUpdates()
        insertRows(at: [indexPath], with: .automatic)
        endUpdates()
    }
    
    func delete(atIndexPath indexPath: IndexPath) {
        beginUpdates()
        deleteRows(at: [indexPath], with: .automatic)
        endUpdates()
    }
}
