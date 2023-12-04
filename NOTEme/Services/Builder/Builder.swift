//
//  Builder.swift
//  NOTEme
//
//  Created by Christina on 27.11.23.
//

import UIKit

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let action: () -> Void
}

