//
//  MultipleSelectionViewDelegate.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/3/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

protocol MultipleSelectionViewDataSource: NSObjectProtocol {
    
    func numberOfItems(in selectionView: MultipleSelectionView) -> Int
    func multipleSelection(_ selectionView: MultipleSelectionView, itemAt index: Int) -> String
    func multipleSelection(_ selectionView: MultipleSelectionView, didSelectAt row: Int)

}
