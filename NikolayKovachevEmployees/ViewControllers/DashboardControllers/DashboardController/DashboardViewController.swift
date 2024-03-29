//
//  DashboardViewController.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 29.03.24.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var rows:[DashboardRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScreen()
    }
    
    func setupScreen() {
        self.rows = []
        
        self.rows.append(DashboardRow(type: .loadCSV))
        self.rows.append(DashboardRow(type: .pairOfEmployees))
        self.rows.append(DashboardRow(type: .missingData))
        
        self.tableView.reloadData()
    }
    
    @IBAction func LoadCSVTapped(_ sender: UIBarButtonItem) {
        if let loadCSVViewController = UIStoryboard.dashboard.instantiateViewController(identifier: "LoadCSVViewController") as? LoadCSVViewController {
            self.navigationController?.pushViewController(loadCSVViewController, animated: true)
        }
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.rows[indexPath.row]
        
        switch row.type {
        case .loadCSV:
            if let loadCSVTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LoadCSVTableViewCell", for: indexPath) as? LoadCSVTableViewCell {
                return loadCSVTableViewCell
            }
        case .pairOfEmployees:
            if let pairOfEmployeesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PairOfEmployeesTableViewCell", for: indexPath) as? PairOfEmployeesTableViewCell {
                return pairOfEmployeesTableViewCell
            }
        case .missingData:
            if let missingDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MissingDataTableViewCell", for: indexPath) as? MissingDataTableViewCell {
                return missingDataTableViewCell
            }
        }
        
        return UITableViewCell()
    }
}

extension DashboardViewController {
    struct DashboardRow {
        enum RowType {
            case loadCSV
            case pairOfEmployees
            case missingData
        }

        let type: RowType
    }
}
