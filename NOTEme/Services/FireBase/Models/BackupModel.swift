//
//  BackupModel.swift
//  NOTEme
//
//  Created by Christina on 9.04.24.
//

import Foundation
import Storage

enum BackupErrors: Error {
    case notSupportedBackupType
}

struct BackupModel: Codable {
    
    let dto: any DTODescription
    
    enum CodingKeys: CodingKey {
        // main attributes
        case id
        case date
        case title
        case subtitle
        case completedDate
        case type
        // Date & Timer attributes
        case targetDate
        // TODO: add location parameters
    }
    
    enum BackupType {
        static let date = "date"
        static let timer = "timer"
        static let location = "location"
    }
    
    init(dto: any DTODescription) {
        self.dto = dto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        let id = try container.decode(String.self, forKey: .id)
        let dateTimeInterval = try container.decode(Double.self, forKey: .date)
        let title = try container.decode(String.self, forKey: .title)
        let subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        let comletedDateTimeInterval = try container.decodeIfPresent(Double.self, forKey: .completedDate)
        
        if type == BackupType.date {
            let targetDateTimeInterval = (try container.decode(Double.self, forKey: .targetDate))
            
            let dateDTO = DateNotificationDTO(date: Date(timeIntervalSince1970: dateTimeInterval),
                                              identifier: id,
                                              title: title,
                                              subtitle: subtitle,
                                              completedDate: Date(comletedDateTimeInterval),
                                              targetDate: Date(timeIntervalSince1970: targetDateTimeInterval))
            self.dto = dateDTO
            return
        } else if type == BackupType.timer {
            let targetTimerTimeInterval = try container.decode(Double.self, forKey: .targetDate)
            
            let timerDTO = TimerNotificationDTO(date: Date(timeIntervalSince1970: dateTimeInterval),
                                                identifier: id,
                                                title: title,
                                                subtitle: subtitle,
                                                completedDate: Date(comletedDateTimeInterval),
                                                targetTime: Date(timeIntervalSince1970: targetTimerTimeInterval))
            self.dto = timerDTO
            return
        } else if type == BackupType.location {
            
        }
        throw BackupErrors.notSupportedBackupType
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // main
        try container.encode(dto.identifier, forKey: .id)
        try container.encode(dto.date.timeIntervalSince1970, forKey: .date)
        try container.encode(dto.title, forKey: .title)
        try container.encode(dto.subtitle, forKey: .subtitle)
        if let completedDate = dto.completedDate {
            try container.encode(dto.completedDate, forKey: .completedDate)
        }
        
        if let dateDTO = dto as? DateNotificationDTO {
            try container.encode(dateDTO.targetDate.timeIntervalSince1970,
                                 forKey: .targetDate)
            try container.encode(BackupType.date, forKey: .type)
            
        } else if let timerDTO = dto as? TimerNotificationDTO {
            try container.encode(timerDTO.targetTime.timeIntervalSince1970, 
                                 forKey: .targetDate)
            try container.encode(BackupType.timer, forKey: .type)
        } else if let locationDTO = dto as? LocationNotificationDTO {}
    }
    
    func buildDict() -> [String: Any]? {
        guard
            let data = try? JSONEncoder().encode(self),
            let dict = try? JSONSerialization.jsonObject(with: data,
                                                         options: .fragmentsAllowed)
        else { return nil }
        return dict as? [String: Any]
    }
}
