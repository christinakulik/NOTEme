//
//  RouteAdapter.swift
//  NOTEme
//
//  Created by Christina on 12.03.24.
//

import UIKit
import MapKit

final class RouteAdapter: NSObject {
//    
//    var places: [MKMapItem] = [] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//    
//    var didSelectRow: ((MKMapItem) -> Void)?
//    
//    private(set)  var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.rowHeight = 35.0
//        return tableView
//    }()
//    
//    override init() {
//        super.init()
//        setupTableView()
//    }
//    
//    private func setupTableView() {
//        tableView.dataSource = self
//        tableView.delegate = self
//        
//        tableView.register(RouteTableViewCell.self)
//      
//    }
//}
//
//extension RouteAdapter: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
//    -> Int {
//        return places.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
//    -> UITableViewCell {
//        let row = places[indexPath.row]
//        let cell = tableView.dequeue(at: indexPath) as RouteTableViewCell
//        cell.setup(row)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView,
//                   didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//    }
}
//
//extension RouteAdapter: UITableViewDelegate {
//    func tableView(_ tableView: UITableView,
//                   heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30.0
//    }
//}
//
extension RouteAdapter: RouteAdapterProtocol {
 
    
//    func reloadData(with sections: [MKMapItem]) {
//        self.places = sections
//    }
//    
//    func makeTableView() -> UITableView {
//        return tableView
//    }
}
