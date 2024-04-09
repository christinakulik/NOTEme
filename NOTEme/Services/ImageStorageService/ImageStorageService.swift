//
//  ImageStorageService.swift
//  NOTEme
//
//  Created by Christina on 19.03.24.
//

import UIKit

enum StorageError: Error {
    case invalidImageData
    case failedToSaveImage
}

final class LocalStorageService {
    
    func saveImageToDocumentsDirectory(image: UIImage, 
                                       completion: @escaping (Result<URL, Error>) 
                                       -> Void) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, 
                                                 in: .userDomainMask).first
        let imageName = UUID().uuidString
        let imageUrl = 
        documentDirectory?.appendingPathComponent("\(imageName).jpg")
        
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            completion(.failure(StorageError.invalidImageData))
            return
        }
        
        do {
            try imageData.write(to: imageUrl!)
            completion(.success(imageUrl!))
        } catch {
            completion(.failure(error))
        }
    }
    
    func loadImageFromDocumentsDirectory(imagePath: String, 
                                         completion: @escaping (UIImage?)
                                         -> Void) {
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let imageUrl = documentDirectory.appendingPathComponent(imagePath)
            
            if let image = UIImage(contentsOfFile: imageUrl.path) {
                completion(image)
            } else {
                print("Изображение не найдено.")
                completion(nil)
            }
        }
    
    func deleteImageFromDocumentsDirectory(imagePath: String, 
                                           completion: @escaping (Result<Void, Error>)
                                           -> Void) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, 
                                                 in: .userDomainMask).first!
        let imageUrl = documentDirectory.appendingPathComponent(imagePath)
        
        do {
            try fileManager.removeItem(at: imageUrl)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}



