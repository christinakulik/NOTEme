//
//  AnnotationsMapVC.swift
//  NOTEme
//
//  Created by Christina on 8.04.24.
//

import UIKit
import MapKit
import SnapKit

protocol AnnotationsMapViewModelProtocol {
    func finishDidTap()
}

final class AnnotationsMapVC: UIViewController {
    
    private var viewmodel: AnnotationsMapViewModelProtocol
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var finishButton: UIButton =
        .yellowRoundedButton("Finish")
        .withAction(self,
                    #selector(finishDidTap))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    init(viewmodel: AnnotationsMapViewModelProtocol) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(mapView)
        view.addSubview(finishButton)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(finishButton.snp.centerY)
        }
        
        finishButton.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func finishDidTap() {
        viewmodel.finishDidTap()
    }
}
