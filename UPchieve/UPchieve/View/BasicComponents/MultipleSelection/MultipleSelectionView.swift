//
//  MultipleSelectionView.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/3/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class MultipleSelectionView: UIView {
    
    final let ITEM_HEIGHT = 30.0
    
    weak var viewDataSource: MultipleSelectionViewDataSource?
    
    var dataSource: MultipleSelectionViewDataSource? {
        get {
            return viewDataSource
        }
        set(dataSource) {
            if self.viewDataSource == nil {
                self.viewDataSource = dataSource
                setup()
            }
        }
    }
    
    var itemsNum: Int {
        get {
            if let viewDataSource = viewDataSource {
                return viewDataSource.numberOfItems(in: self)
            }
            return 0
        }
    }
    
    func setup() {
        self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: CGFloat(Double(itemsNum) * ITEM_HEIGHT)))
        loadItems()
    }
    
    func loadItems() {
        for index in 0..<itemsNum {
            let view = MultipleSelectionItemView(frame: CGRect(x: 0.0, y: Double(index) * ITEM_HEIGHT, width: Double(self.frame.width), height: ITEM_HEIGHT), title: viewDataSource!.multipleSelection(self, itemAt: index))
            let action = UITapGestureRecognizer(target: self, action: #selector(handleSelection(_:)))
            view.addGestureRecognizer(action)
            view.index = index
            self.addSubview(view)
        }
    }
    
    func handleSelection(_ sender: UITapGestureRecognizer) {
        if sender.view is MultipleSelectionItemView {
            let target = sender.view as! MultipleSelectionItemView
            dataSource?.multipleSelection(self, didSelectAt: target.index)
            target.changeSelectionStatus()
        }
    }

}
