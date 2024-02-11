//
//  PopoverRows.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit

fileprivate enum L10n {
    static let calendarTitle: String = "popover_calendar".localized
    static let locationTitle: String = "popover_location".localized
    static let timerTitle: String = "popover_timer".localized
}

enum PopoverRows: CaseIterable {
    
    case calendar
    case location
    case timer
    
    var icon: UIImage {
        switch self {
        case .calendar: return .Popover.calendar
        case .location: return .Popover.location
        case .timer: return .Popover.timer
        }
    }
    
    var title: String {
        switch self {
        case .calendar: return L10n.calendarTitle
        case .location: return L10n.locationTitle
        case .timer: return L10n.timerTitle
        }
    }
}
