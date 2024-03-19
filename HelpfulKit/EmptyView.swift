//
//  EmptyView.swift
//  DPFoundationExtensionKit
//
//  Created by Dipak Panchasara on 22/12/22.
//

import Foundation
import UIKit

public class EmptyView: UIView {
    @IBOutlet  var emptyStateImageView: UIImageView!
    @IBOutlet  var emptyTitleLabel: UILabel!
    @IBOutlet  var emptySubtitleLabel: UILabel!
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTheme()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTheme()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTheme()
    }
    func setupTheme() {
    }
}

public extension UIView {
    func getEmptyStateDetailsView() -> EmptyView? {
        return try? EmptyView.viewFromNib()
    }
    // MARK: - Get Empty State
    func getEmptyStateDetails(image: UIImage? = nil,
                              strTitle: String,
                              strSubTitle: String = "") -> EmptyView? {
        guard let emptyView = self.getEmptyStateDetailsView() else {
            return nil
        }
        emptyView.emptyStateImageView.image = image
        emptyView.emptyTitleLabel.text = strTitle
        emptyView.emptySubtitleLabel.text = strSubTitle
        return emptyView
    }
}
// MARK: - UITableView
public extension UITableView {
    func setEmptyView(image: UIImage? = nil,
                      strTitle: String,
                      strSubTitle: String = "") {
        guard let emptyView = getEmptyStateDetailsView() else {
            return
        }
        emptyView.emptyStateImageView.image = image
        emptyView.emptyTitleLabel.text = strTitle
        emptyView.emptySubtitleLabel.text = strSubTitle
        emptyView.frame = self.frame
        self.backgroundView = emptyView
    }
    func removeEmptyView() {
        self.backgroundView = nil
    }
}

// MARK: - UICollectionView
public extension UICollectionView {
    func setEmptyView(image: UIImage? = nil,
                      strTitle: String,
                      strSubTitle: String = "") {
        guard let emptyView = getEmptyStateDetailsView() else {
            return
        }
        emptyView.emptyStateImageView.image = image
        emptyView.emptyTitleLabel.text = strTitle
        emptyView.emptySubtitleLabel.text = strSubTitle
        emptyView.frame = self.frame
        self.backgroundView = emptyView
    }
    func removeEmptyView() {
        self.backgroundView = nil
    }
}
