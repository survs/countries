//
//  CountryListViewControlerViewController.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit


protocol CountryListViewInput: AnyObject {
    func madeSections(sections: [CountryListTableViewCellModel])
}

protocol CountryListViewOutput: AnyObject {
    func reloadData()
    func displayedCell(row: Int)
}

class CountryListViewController: UIViewController, CountryListViewInput {
    
    // MARK: - Properties
    
    var output: CountryListViewOutput?
    
    var sections: [CountryListTableViewCellModel] = []
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.reloadData()
        self.setupView()
    }
    
    func setupView() {
        self.title = R.string.localizable.country_list()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(R.nib.countryListTableViewCell)
        let refreshControl = UIRefreshControl()
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    // MARK: - CurrencyViewInput
    
    func madeSections(sections: [CountryListTableViewCellModel]) {
        self.tableView.refreshControl?.endRefreshing()
        self.sections = sections
        self.tableView.reloadData()
    }
    
    
    // MARK: - IBAction

}

// MARK: - Actions

extension CountryListViewController {
    @objc
    func handleRefresh() {
        self.output?.reloadData()
    }
}


// MARK: - UITableViewDelegate

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.output?.displayedCell(row: indexPath.row)
    }
}


// MARK: - UITableViewDataSource

extension CountryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryListTableViewCellModel.identifier) as? CountryListTableViewCell else { return UITableViewCell() }
        cell.model = self.sections[indexPath.row]
        return cell
    }
}
