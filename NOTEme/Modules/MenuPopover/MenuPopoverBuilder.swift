//
//  MenuPopoverBuilder.swift
//  NOTEme
//
//  Created by Christina on 27.02.24.
//

import UIKit

final class MenuPopoverBuilder {
    
    private init() {}
    
    static func buildAddMenu(delegate: MenuPopoverDelegate, 
                             sourceView: UIView) -> UIViewController {
        let menu = build(delegate: delegate,
                     actions: [.calendar, .location, .timer],
                     sourceView: sourceView)
        menu.popoverPresentationController?.permittedArrowDirections = .down
        return menu
        
    }
    
    static func buildEditMenu(delegate: MenuPopoverDelegate, 
                              sourceView: UIView) -> UIViewController {
        let menu = build(delegate: delegate,
                     actions: [.edit, .delete],
                     sourceView: sourceView)
        menu.popoverPresentationController?.permittedArrowDirections = .up
        return menu
    }
    
    static func build(delegate: MenuPopoverDelegate,
                      actions: [MenuPopoverVC.Action],
                      sourceView: UIView)
    -> UIViewController {
        let adapter = MenuPopoverAdapter(actions: actions)
        return MenuPopoverVC(delegate: delegate,
                             adapter: adapter,
                             sourceView: sourceView)
    }
}
