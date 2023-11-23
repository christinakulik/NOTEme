//
//  KeyboardAnimator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit
import SnapKit

final class KeyboardAnimator {
    
    func move(for vc: UIViewController, 
              view: UIView,
              frame: CGRect,
              with padding: CGFloat) {
        let maxY = view.frame.maxY + padding
        let keyboardY = frame.minY
        let diff = maxY - keyboardY
        
        if diff > 0 {
            update(for: vc, view: view, with: -diff)
        } else if diff < 0 {
            update(for: vc, view: view, with: .zero)
        }
    }
    
  private  func update(for vc: UIViewController, 
                       view: UIView,
                       with offset: CGFloat) {
        view.snp.updateConstraints {
            $0.centerY.equalToSuperview().offset(offset)
        }
        vc.view.layoutIfNeeded()
    }
}

