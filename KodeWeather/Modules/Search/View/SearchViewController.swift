//
//  SearchViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Properties

    var output: SearchViewOutput?

    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView: UITableView = UITableView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        setupLayouts()
    }

    private func setupSearchController() {
        searchController.searchBar.barStyle = .black
        searchController.searchBar.backgroundColor = .black
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundColor = UIColor(hex: "#1E1E1E")
    }

    private func setupLayouts() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {

}

// MARK: - Tableview Delegate & Datasource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
