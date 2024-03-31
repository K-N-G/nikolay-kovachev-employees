//
//  ProjectViewController.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 29.03.24.
//

import UIKit

class ProjectViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var rows:[ProjectRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupScreen()
    }
    
    func setupScreen() {
        self.rows = []
        if UserData.loadedFileName != "" && DataManager.employeePairs.isEmpty {
            self.rows.append(ProjectRow(type: .missingData, project: nil))
        } else if DataManager.projects.isEmpty {
            self.rows.append(ProjectRow(type: .loadCSV, project: nil))
        } else {
            for project in DataManager.projects {
                self.rows.append(ProjectRow(type: .project, project: project))
            }
        }
        
        self.tableView.reloadData()
    }
}

extension ProjectViewController: UITableViewDelegate, UITableViewDataSource {
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
        case .project:
            if let projectTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as? ProjectTableViewCell,
               let project = row.project {
                projectTableViewCell.projectIDLabel.text = project.id
                return projectTableViewCell
            }
        case .missingData:
            if let missingDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MissingDataTableViewCell", for: indexPath) as? MissingDataTableViewCell {
                return missingDataTableViewCell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.rows[indexPath.row]
        switch row.type {
        case .project:
            if let project = row.project {
                if let projectDetailsViewController = UIStoryboard.projects.instantiateViewController(identifier: "ProjectDetailsViewController") as? ProjectDetailsViewController {
                    projectDetailsViewController.project = project
                    self.navigationController?.pushViewController(projectDetailsViewController, animated: true)
                }
            }
        default:
            break
        }
    }
}

extension ProjectViewController {
    struct ProjectRow {
        enum RowType {
            case loadCSV
            case project
            case missingData
        }

        let type: RowType
        let project: Project?
    }
}
