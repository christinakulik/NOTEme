//
//  SearchBarView.swift
//  NOTEme
//
//  Created by Christina on 12.03.24.
//

import UIKit
import MapKit

protocol SearchBarViewDelegate: AnyObject {
    func didBeginEditing()
    func didCancel()
    func didSelectPlace(_ mapItem: MKMapItem)
}

class SearchBarView: UIView, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: SearchBarViewDelegate?
    private let searchBar = UISearchBar()
   
    private(set)  var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 45.0
        return tableView
    }()
   
    private var places: [MKMapItem] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.cornerRadius = 18.0
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        tableView.register(RouteTableViewCell.self)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        tableView.isHidden = false
        delegate?.didBeginEditing()
       
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchPlaces(searchText)
        }
        
        private func searchPlaces(_ query: String) {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = query
            
            let search = MKLocalSearch(request: searchRequest)
            search.start { response, _ in
                guard let response = response else {
                    return
                }
                
                self.places = response.mapItems
                self.tableView.reloadData()
            }
        }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.placeholder = "Search"
        searchBar.resignFirstResponder()
        tableView.isHidden = true
        delegate?.didCancel()
    }
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
            return places.count
        }
        
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeue(at: indexPath) as RouteTableViewCell
            let place = places[indexPath.row]
            cell.textLabel?.text = place.name
            return cell
        }
        
        func tableView(_ tableView: UITableView, 
                       didSelectRowAt indexPath: IndexPath) {
            let place = places[indexPath.row]
            delegate?.didSelectPlace(place)
            
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
            tableView.isHidden = true
         
        }
   
}
