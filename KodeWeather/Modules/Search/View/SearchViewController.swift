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
    private var timer: Timer?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        view.backgroundColor = StyleGuide.Colors.darkGray
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupSearchController()
        setupTableView()
        setupLayouts()
    }

    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = StyleGuide.Colors.darkGray
        searchController.searchBar.placeholder = Localization.Search.searchBarPlaceholder
        searchController.searchBar.tintColor = StyleGuide.Colors.white
        searchController.searchResultsUpdater = self
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
        let backgroundView = UIView()
        backgroundView.backgroundColor = StyleGuide.Colors.darkGray
        tableView.backgroundView = backgroundView
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
    }

    private func setupLayouts() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Tableview Delegate & Datasource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        cell.configure(with: output?.cellViewModel(for: indexPath)?.name ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.navigationBar.prefersLargeTitles = false
        searchController.searchBar.endEditing(true)
        output?.selectRowAtIndexPath(at: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SearchTableSectionHeaderView()
        view.configure(with: "Последние запросы")
        return view
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self ] (_) in
                self?.output?.fetchPreviewLocations(for: searchText)
            })
        }
    }
}
