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

    func addShadow() {
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowColor = UIColor(red: 0,
                                           green: 0,
                                           blue: 0,
                                           alpha: 0.05).cgColor
        self.layer.masksToBounds = false
        if let tableView = self as? UITableView {
                 for section in 0..<tableView.numberOfSections {
                     for row in 0..<tableView.numberOfRows(inSection: section) {
                         if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) {
                             cell.contentView.layer.masksToBounds = false
                             cell.contentView.layer.shadowColor = UIColor.black.cgColor
                             cell.contentView.layer.shadowOpacity = 0.5
                             cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
                             cell.contentView.layer.shadowRadius = 4
                         }
                     }
                 }
             }
         }
}

