//
//  UIView+Layer.swift
//  NOTEme
//
//  Created by Christina on 30.10.23.
//

import UIKit

extension UIView {
    
    static func plainView() -> UIView {
      let view = UIView()
        
        view.backgroundColor = .white
        view.cornerRadius = 5.0
        
        view.layer.shadowColor = UIColor(red: 0,
                                         green: 0,
                                         blue: 0,
                                         alpha: 0.05).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 2, height: 4)
        view.layer.shadowRadius = 4
        
        return view
    }
    
}

