//
//  UIView+Layer.swift
//  NOTEme
//
//  Created by Christina on 30.10.23.
//

import UIKit

extension UIView {
    
    static func plainViewWithShadow() -> UIView {
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
    
    static func basicView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = .appGray
        
        return view
    }
    
    static func containerViewWithShadow() -> UIView {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 2, height: 4)
        view.layer.shadowColor = UIColor(red: 0,
                                           green: 0,
                                           blue: 0,
                                           alpha: 0.05).cgColor
        view.layer.masksToBounds = false
        view.cornerRadius = 5.0
        
        return view
    }
    
    static func separatedView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = .appGrayContent
        
        return view
    }

    func addShadowWithRadius() {
        backgroundColor = .white
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowColor = UIColor(red: 0,
                                           green: 0,
                                           blue: 0,
                                           alpha: 0.05).cgColor
        layer.masksToBounds = false
        cornerRadius = 5.0
    }
    
}

