//
//  LoadCSVViewController.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 29.03.24.
//

import UIKit
import JGProgressHUD

class LoadCSVViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func chooseCSVTapped(_ sender: UIButton) {
        UserData.loadedFileName = ""
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.commaSeparatedText])
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
}

extension LoadCSVViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedURL = urls.first else { return }
        readCSVFile(url: selectedURL)
    }
    
    func readCSVFile(url: URL) {
        var employeeProjects = [EmployeeProject]()
        guard url.startAccessingSecurityScopedResource() else {
            self.showError(error: "missing permissions read file", delay: 3.0, onDismiss: nil)
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        do {
            let data = try String(contentsOf: url)
            let rows = data.components(separatedBy: "\n")
            
            for row in rows {
                let columns = row.components(separatedBy: ",")
                
                guard columns.count >= 3 else {
                    continue
                }
                
                let employeeID = columns[0]
                let projectID = columns[1]
                let dateFrom = DataManager.formatDate(dateString: columns[2])
                let dateTo:String = DataManager.formatDate(dateString: columns.count > 3 ? columns[3] : "")
                
                let employeeProject = EmployeeProject(employeeID: employeeID, projectID: projectID, dateFrom: dateFrom, dateTo: dateTo)
                employeeProjects.append(employeeProject)
            }
            DataManager.employeeProjects = employeeProjects
            DataManager.fetchData()
            UserData.loadedFileName = url.lastPathComponent
            self.showMessage(message: "Success fetch data", delay: 3.0, onDismiss: {
                self.navigationController?.popViewController(animated: true)
            })
        } catch {
            self.showError(error: "Error reading file: \(error.localizedDescription)", delay: 3.0, onDismiss: nil)
        }
    }
}
