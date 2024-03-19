//
//  String+Size.swift
//  NOTEme
//
//  Created by Christina on 15.03.24.
//

import UIKit

extension String {
    
    func minimumWidthToDisplay(font: UIFont, height: CGFloat) -> CGFloat {
       let label = UILabel()
        label.font = font
        label.text = self
        return label 
            .sizeThatFits(.init(width: .infinity,
                                         height: height))
            .width
    }
    
}
