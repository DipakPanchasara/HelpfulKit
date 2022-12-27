//
//  EmptyView.swift
//  Circle Back
//
//  Created by Dipak Panchasara on 07/02/22.
//

import UIKit

class EmptyView: UIView {
    
    @IBOutlet  var emptyStateImageView  : UIImageView!
    @IBOutlet  var emptyTitleLabel      : UILabel!
    @IBOutlet  var emptySubtitleLabel   : UILabel!
    
    override func awakeFromNib() {
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

extension UIView {
    
    func getEmptyStateDetailsView() -> EmptyView? {
        //Bundle.main.loadNibNamed(EmptyView.className, owner: nil, options: nil)?[0] as? EmptyView
        
//        guard let emptyView = EmptyView.fromNib(named: EmptyView.className)  else {
//            return nil
//        }
        return EmptyView.fromNib(named: EmptyView.className)
    }
    // MARK: Get Empty State
    func getEmptyStateDetails(image: UIImage? = nil,strTitle: String,strSubTitle: String = "") -> EmptyView? {
        guard let emptyView = self.getEmptyStateDetailsView() else {
        return nil
      }
      emptyView.emptyStateImageView.image = image
      emptyView.emptyTitleLabel.text = strTitle
      emptyView.emptySubtitleLabel.text = strSubTitle
      return emptyView
    }
}
//MARK:- UITableView
extension UITableView {
    func setEmptyView(image: UIImage? = nil,strTitle: String, strSubTitle: String = "") {
        guard let emptyView = getEmptyStateDetailsView() else {
            return
        }
        emptyView.emptyStateImageView.image = image
        emptyView.emptyTitleLabel.text = strTitle
        emptyView.emptySubtitleLabel.text = strSubTitle
        emptyView.frame = self.frame
        self.backgroundView = emptyView
    }
    func removeEmptyView(){
        self.backgroundView = nil
    }
}
