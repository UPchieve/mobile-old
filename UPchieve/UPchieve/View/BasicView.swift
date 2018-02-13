//
//  BasicView.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/3/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

let globalTintColor = UIColor(red:0.38, green:0.81, blue:0.67, alpha:1.0)
let globalBackgroundColor = UIColor(red:0.90, green:0.95, blue:0.99, alpha:1.0)

extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
}

extension UIColor {
    
    var image: UIImage {
        get {
            return toImage()
        }
    }
    
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
}

extension UIImageView {
    
    func updateUIAsync(withFunction function: @escaping () -> Void) {
        DispatchQueue.main.async {
            function()
        }
    }
    
}
