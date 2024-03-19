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
    static let editTitle: String = "popover_edit".localized
    static let deleteTitle: String = "popover_delete".localized
}

enum PopoverRows: CaseIterable {
    
    case calendar
    case location
    case timer
    case edit
    case delete
    
    var icon: UIImage {
        switch self {
        case .calendar: return .Popover.calendar
        case .location: return .Popover.location
        case .timer: return .Popover.timer
        case .edit: return .Popover.edit
        case .delete: return .Popover.delete
        }
    }
    
    var title: String {
        switch self {
        case .calendar: return L10n.calendarTitle
        case .location: return L10n.locationTitle
        case .timer: return L10n.timerTitle
        case .edit: return L10n.editTitle
        case .delete: return L10n.deleteTitle
        }
    }
}
