//
//  NotificationDataWorker.swift
//  NOTEme
//
//  Created by Christina on 23.04.24.
//

import Foundation
import Storage
import CoreData
import UserNotifications

protocol NotificationServiceDataWorkerUseCase {
    func makeNotifications(from dto: [any DTODescription])
    func removeNotifications(id: [String])
}

final class NotificationDataWorker {
    
    typealias CompletionHandler = (Bool) -> Void
    
    private let backupService: FirebaseBackupService
    private let storage: AllNotificationStorage
    private let notificationsService: NotificationServiceDataWorkerUseCase
    
    init(backupService: FirebaseBackupService,
         storage: AllNotificationStorage,
         notificationsCenter: NotificationServiceDataWorkerUseCase) {
        self.backupService = backupService
        self.storage = storage
        self.notificationsService = notificationsCenter
    }
    
    func createOrUpdate(dto: any DTODescription,
                        completion: CompletionHandler? = nil) {
        storage.updateOrCreate(dto: dto) { [notificationsService, backupService]
            isSuccess in
            defer { completion?(isSuccess) }
            
            guard isSuccess else { return }
            
            notificationsService.makeNotifications(from: [dto])
            backupService.backup(dto: dto)
        }
    }
    
    func deleteByUser(dto: any DTODescription,
                      completion: CompletionHandler? = nil) {
        storage.delete(dto: dto) { [notificationsService, backupService] isSuccess in
            defer { completion?(isSuccess) }
            
            guard isSuccess else { return }
         
            notificationsService.removeNotifications(id: [dto.identifier])
            backupService.delete(id: dto.identifier)
        }
        
        func deleteAll(completion: CompletionHandler? = nil) {
            let allDTOs = storage.fetch()
            let allIds = allDTOs.map { $0.identifier }
            
            notificationsService.removeNotifications(id: allIds)
            storage.deleteAll(dtos: allDTOs, completion: completion)
            
        }
        
        func restore(completion: CompletionHandler? = nil) {
            backupService.loadBackup { [weak self] dtos in
                self?.storage.createDTOs(dtos: dtos) { isSuccess in
                    defer { completion?(isSuccess) }
                    guard isSuccess else { return }
                    
                    self?.notificationsService.makeNotifications(from: dtos)
                }
            }
        }
    }
}



