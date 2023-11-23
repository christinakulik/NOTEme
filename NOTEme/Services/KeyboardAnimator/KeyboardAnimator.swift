//
//  KeyboardAnimator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit
import SnapKit

final class KeyboardAnimator {
    func move(for targetView: UIView,
              frame: CGRect,
              with padding: CGFloat) {
        let maxY = targetView.frame.maxY + padding
        let keyboardY = frame.minY
        let diff = maxY - keyboardY
        
        if diff > 0 {
            update(for: targetView, with: -diff)
        } else if diff < 0 {
            update(for: targetView, with: .zero)
        }
    }
    
  private func update(for targetView: UIView,
                      with offset: CGFloat) {
        targetView.snp.updateConstraints {
            $0.centerY.equalToSuperview().offset(offset)
        }
      targetView.superview?.layoutIfNeeded()
    }
}

