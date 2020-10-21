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
        view.backgroundColor = StyleGuide.Colors.darkGrey
        setupSearchController()
        setupTableView()
        setupLayouts()
    }

    private func setupSearchController() {
        searchController.searchBar.barTintColor = StyleGuide.Colors.darkGrey
        searchController.searchBar.placeholder = Localization.Search.searchBarPlaceholder
        searchController.searchBar.tintColor = StyleGuide.Colors.white
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = StyleGuide.Colors.defaultTextColor
        }
        searchController.searchBar.setValue(Localization.Search.searchBarCancelButtonText, forKey:"cancelButtonText")
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchController.searchBar
        let backgroundView = UIView()
        backgroundView.backgroundColor = StyleGuide.Colors.darkGrey
        tableView.backgroundView = backgroundView
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
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
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        cell.configure(with: "Калининград")
        return cell
    }
}
