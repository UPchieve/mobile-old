//
//  ProfileMultipleSelectionTableViewCell.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/3/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ProfileMultipleSelectionTableViewCell: ProfileTableViewCell, MultipleSelectionViewDataSource {
    
    var selectionViewItems = [String]()
    
    var multipleSelectionCellData: ProfileCellMultipleSelectionData?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var multipleSelectionView: MultipleSelectionView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func configure() {
        multipleSelectionCellData = cellData as! ProfileCellMultipleSelectionData
        titleLabel.text = multipleSelectionCellData?.title
        selectionViewItems = multipleSelectionCellData!.selectionItems!
        titleLabel.sizeToFit()
        multipleSelectionView.dataSource = self
        let constraintHeight = NSLayoutConstraint(item: multipleSelectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: multipleSelectionView.frame.height)
        self.addConstraint(constraintHeight)
        self.viewHeightConstraint.constant = multipleSelectionView.frame.height
    }
    
    func numberOfItems(in selectionView: MultipleSelectionView) -> Int {
        return selectionViewItems.count
    }
    
    func multipleSelection(_ selectionView: MultipleSelectionView, itemAt index: Int) -> String {
        return selectionViewItems[index]
    }
    
    func multipleSelection(_ selectionView: MultipleSelectionView, didSelectAt row: Int) {
        if multipleSelectionCellData?.itemSelection != nil {
            multipleSelectionCellData!.itemSelection![row] = !(multipleSelectionCellData!.itemSelection![row])
        }
    }

}
