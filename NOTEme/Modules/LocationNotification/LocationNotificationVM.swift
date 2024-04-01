//
//  LocationNotificationVM.swift
//  NOTEme
//
//  Created by Christina on 5.03.24.
//

import UIKit
import Storage
import MapKit

protocol LocationNotificationStorageProtocol {
    func createLocationNotification(dto: LocationNotificationDTO)
}

protocol LocationNotificationCoordinatorProtocol: AnyObject {
    func finish()
    func openRoute(delegate: RouteModuleDelegate?,
                   region: MKCoordinateRegion?)
}

final class LocationNotificationVM: LocationNotificationViewModelProtocol, 
                                        RouteModuleDelegate {
    func didFindNearbyPlaces(_ results: [NearByResponseModel.Result]) {
        
    }
    
    var locationDidSet: ((LocationData) -> Void)?
    
    private enum L10n {
        static let errorHandler: String =
        "createDate_errorHandler".localized
    }
    
    var comment: String?
    var title: String? {
        didSet { checkValidation() }
    }
    var imageDidSet: ((UIImage?) -> Void)?
    var shouldEditDTO: ((LocationNotificationDTO) -> Void)?
    
    private var notificationService: NotificationService
    private weak var coordinator: LocationNotificationCoordinatorProtocol?
    private var storage: LocationNotificationStorageProtocol
    private var dtoToEdit: LocationNotificationDTO?
    private var image: UIImage? {
        didSet
        { imageDidSet?(image) }
    }
    private var region: MKCoordinateRegion?
    private var circleRegion: CLCircularRegion?
    private var errorHandler: ((String?) -> Void)?
    
    // MARK: - Initializer
    init(coordinator: LocationNotificationCoordinatorProtocol,
         storage: LocationNotificationStorageProtocol,
         dtoToEdit: LocationNotificationDTO? = nil,
         notificationService: NotificationService) {
        self.coordinator = coordinator
        self.storage = storage
        self.dtoToEdit = dtoToEdit
        self.notificationService = notificationService
       
        loadDTOToEdit()
        
        locationDidSet = { [weak self] locationData in
                    self?.image = locationData.image
                    self?.region = locationData.region
                    self?.circleRegion  = locationData.circularRegion
                }
    }
    
    func viewDidLoad() {
        guard let dtoToEdit else { return }
        setRegion(for: dtoToEdit)
    }
    
    func loadDTOToEdit() {
        guard let dto = dtoToEdit else { return }
        title = dto.title
        comment = dto.subtitle
    }
    
    // MARK: - Public Methods
    func createDidTap() {
        guard checkValidation() else {
            errorHandler?(L10n.errorHandler)
            return
        }
        
        guard let title, let region, let image else { return }
        
        saveImageAndGetPath(image: image) { [weak self] imagePath in
            guard let imagePath = imagePath else {
                print("Не удалось получить путь к изображению")
                return
            }
            
            let dto = LocationNotificationDTO(date: Date(),
                                              title: title,
                                              longitude: region.center.longitude,
                                              latitude: region.center.latitude,
                                              deltalLongitude: region.span.longitudeDelta,
                                              deltaLatitutde: region.span.latitudeDelta,
                                              imagePath: imagePath)
            self?.storage.createLocationNotification(dto: dto)
            if let circleRegion = self?.circleRegion {
                       self?.notificationService.makeLocationNotification(circleRegion: circleRegion, dto: dto)
                   }
            self?.coordinator?.finish()
        }
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    func locationImageDidTap() {
        coordinator?.openRoute(delegate: self, region: region)
    }
    
    func createNotification(with circularRegion: CLCircularRegion) {
    }
    
    func saveImageAndGetPath(image: UIImage, 
                             completion: @escaping (String?) -> Void) {
        let localStorageService = LocalStorageService()
        localStorageService.saveImageToDocumentsDirectory(image: image) {
            result in
            switch result {
            case .success(let url):
                let imageName = url.lastPathComponent 
                completion(imageName)
            case .failure(let error):
                print("Ошибка при сохранении изображения: \(error)")
                completion(nil)
            }
        }
    }
    
    private func setRegion(for dto: LocationNotificationDTO) {
            self.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: dto.latitude,
                    longitude: dto.longitude),
                span: MKCoordinateSpan(
                    latitudeDelta: dto.deltaLatitutde,
                    longitudeDelta: dto.deltalLongitude))
        }
    
    @discardableResult
    func checkValidation() -> Bool {
        let titleValid = isValid(title)
        return titleValid
    }
    
    // MARK: - Private Methods
    func isValid(_ value: Any?) -> Bool {
        if let title = value as? String, !title.isEmpty {
            return true
        } else {
            return false
        }
    }
}
