//
//  DogViewController 2.swift
//  RandomAPIsProject
//
//  Created by Wesley Keetch on 12/3/24.
//

import UIKit

class RepresentativeTableViewController: UITableViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  var info = [RepresentativeModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func fetchMatchingItems() {
    self.info = []
    self.tableView.reloadData()
    let searchTerm = searchBar.text ?? ""
    if !searchTerm.isEmpty {
      
      Task {
        do {
          self.info = await RepInfoAPI.fetchRepInfo(zip: searchTerm)
          self.tableView.reloadData()
        }
      }
    }
  }
  
  func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? RepresentativeCell else { return }
    let info = info[indexPath.row]
    configure(cell: cell, for: info)
  }
  
  func configure(cell: RepresentativeCell, for info: RepresentativeModel) {
    cell.representativeNameLabel.text = info.name
    cell.partyAndStateLabel.text = info.party
    cell.linkLabel.text = info.link.absoluteString
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RepresentativeCell", for: indexPath) as! RepresentativeCell
    
    let rep = info[indexPath.row]
    
    cell.representativeNameLabel.text = rep.name
    cell.partyAndStateLabel.text = "\(rep.party), \(rep.state)"
    cell.linkLabel.text = rep.link.absoluteString
    
    return cell
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return info.count
  }
}

extension RepresentativeTableViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    fetchMatchingItems()
    searchBar.resignFirstResponder()
  }
}
