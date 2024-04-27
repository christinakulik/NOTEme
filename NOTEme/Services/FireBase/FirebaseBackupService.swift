//
//  FirebaseBackupService.swift
//  NOTEme
//
//  Created by Christina on 9.04.24.
//

import Foundation
import Storage
import FirebaseDatabaseInternal
import FirebaseAuth

final class FirebaseBackupService {
    
    private enum NotificationType {
        static let notification = "notification"
    }
    
    private let backupQueueu: DispatchQueue = .init(label: "com.noteme.backup",
                                                    qos: .background,
                                                    attributes: .concurrent)
    
    private var userId: String? {
        return Auth.auth().currentUser?.uid
    }
    
    private var ref: DatabaseReference {
        return  Database.database().reference()
    }
    
    func backup(dto: any DTODescription) {
        guard let userId else { return }
        backupQueueu.async { [ref] in
            let backupModel = BackupModel(dto: dto)
            let dict = backupModel.buildDict()
            ref
                .child(NotificationType.notification)
                .child(userId)
                .child(dto.identifier).setValue(
                    dict
                )
        }
    }
    
    func delete(id: String) {
        guard let userId else { return }
        backupQueueu.async { [ref] in
            ref
                .child(NotificationType.notification)
                .child(userId)
                .child(id)
                .removeValue()
        }
    }
    
    func loadBackup(completion: @escaping (([any DTODescription]) -> Void)) {
        guard let userId else { return }
        ref
            .child(NotificationType.notification)
            .child(userId)
            .getData { [weak self] error, snapshot in
                self?.backupQueueu.async {
                    guard
                        let snapshotDict = snapshot?.value as? [String: Any]
                    else {
                        return
                    }
                    let value = snapshotDict.map { _, value in value }
                    guard
                        let data = try? JSONSerialization.data(withJSONObject: value),
                        let backupModels = try? JSONDecoder().decode(
                            [BackupModel].self,
                            from: data
                        )
                    else {
                        print("Error: Data serialization or decoding failed")
                        completion([])
                        return
                    }
                    completion(backupModels.compactMap {$0.dto})
                    // TODO: Create notCompleted in IUCenter
                }
            }
    }
}
