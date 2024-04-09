//
//  RouteVC.swift
//  NOTEme
//
//  Created by Christina on 10.03.24.
//

import UIKit
import SnapKit
import MapKit

@objc protocol RouteViewModelProtocol: AnyObject {
    var locationDidSelect: ((CLLocationCoordinate2D) -> Void)? { get set }
    var screenshotDidChanged: ((UIImage?) -> Void)? { get set }
    var isSelected: Bool { get }
    func selectDidTap(mapView: MKMapView, regionView: UIView)
    func setDefaultMapPosition(for mapView: MKMapView)
    func makeScreenshot(_ view: UIView,
                        mapView: MKMapView,
                        regionView: UIView)
    func viewDidLoad()
    func makeTableView() -> UITableView
    func getSearchPlaces(query: String)
    @objc func cancelDidTap()
}

final class RouteVC: UIViewController {
    
    private enum L10n {
        static let titleLabel: String =
        "login_screen_welcome_label".localized
        static let selectButton: String =
        "createLocation_selectButton".localized
    }
    
    private lazy var locationManager: CLLocationManager = .init()
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var searchBar: UISearchBar = {
           let searchBar = UISearchBar()
           searchBar.placeholder = "Search"
           searchBar.delegate = self
           searchBar.showsCancelButton = true
           return searchBar
       }()
    
    private lazy var regionImageView: UIImageView =
    UIImageView(image: .Location.region)
    
    private lazy var screenshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
//    private lazy var searchBarView: SearchBarView = {
//        let view = SearchBarView()
//        view.delegate = self
//        return view
//    }()
    
    private lazy var selectButton: UIButton =
        .yellowRoundedButton(L10n.selectButton)
        .withAction(self, #selector(createDidTap))
    
    private lazy var cancelButton: UIButton =
        .cancelButton()
        .withAction(viewModel,
                    #selector(RouteViewModelProtocol.cancelDidTap))
    
    private lazy var tableView: UITableView = viewModel.makeTableView()
    
    private var viewModel: RouteViewModelProtocol
    
    // MARK: - Initializers
    init(viewModel: RouteViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        viewModel.viewDidLoad()
        viewModel.setDefaultMapPosition(for: mapView)
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(cancelButton)
        view.addSubview(selectButton)
        contentView.addSubview(searchBar)
        contentView.addSubview(mapView)
        contentView.addSubview(regionImageView)
        contentView.addSubview(screenshotImageView)
//        view.addSubview(searchBarView)
    }
    
    private func setupConstraints() {
        
        searchBar.snp.makeConstraints { make in
               make.height.equalTo(56)
               make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
               make.horizontalEdges.equalToSuperview()
           }
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(selectButton.snp.centerY)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        selectButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(55.0)
        }
        
        regionImageView.snp.makeConstraints { make in
            make.centerX.equalTo(mapView.snp.centerX)
            make.centerY.equalTo(mapView.snp.centerY)
            make.size.equalTo(95.0)
        }
  
        screenshotImageView.snp.makeConstraints { make in
            make.centerX.equalTo(mapView.snp.centerX)
            make.centerY.equalTo(mapView.snp.centerY)
        }
        
//        searchBarView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(55.0)
//        }
    }
    
    private func askPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc private func createDidTap() {
        if viewModel.isSelected  {
                    viewModel.selectDidTap(mapView: mapView,
                                            regionView: regionImageView)
                } else {
                    makeScreenshot()
                }
    }
    
    private func makeScreenshot() {
        viewModel.makeScreenshot(view, mapView: mapView,
                                 regionView: regionImageView)
    }
    
    private func bind() {
        viewModel.screenshotDidChanged = { [weak self] image in
            self?.screenshotImageView.image = image
            self?.screenshotImageView.isHidden = image == nil
            self?.selectButton.setTitle(image == nil ? "Select" : "Confirm",
                                        for: .normal)
        }
    }
}

extension RouteVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.isHidden = false
        viewModel.getSearchPlaces(query: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
    }
}
