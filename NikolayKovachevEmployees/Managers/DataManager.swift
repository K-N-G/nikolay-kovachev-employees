//
//  DataManager.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 30.03.24.
//

import Foundation

final class DataManager {
    static var employeeProjects: [EmployeeProject] = []
    static var employees: [Employee] = []
    static var projects: [Project] = []
    static var employeePairs: [EmployeePair] = []
    
    static func fetchData() {
        self.fetchEmployees()
        self.fetchProjects()
        self.fetchEmployeePair()
    }
    
    static private func fetchEmployees() {
        for employeeProject in employeeProjects {
            if let projectIndex = self.projects.firstIndex(where: {$0.id == employeeProject.projectID}) {
                let currentValue = self.projects[projectIndex].employees[employeeProject.employeeID] ?? 0
                self.projects[projectIndex].employees[employeeProject.employeeID] = currentValue + calculateDaysWorked(dateFrom: employeeProject.dateFrom, dateTo: employeeProject.dateTo ?? "")
            } else {
                self.projects.append(Project(
                    id: employeeProject.projectID,
                    employees: [employeeProject.employeeID:calculateDaysWorked(dateFrom: employeeProject.dateFrom, dateTo: employeeProject.dateTo ?? "")]))
            }
        }
    }
    
    static private func fetchProjects() {
        for employeeProject in employeeProjects {
            if let employeeIndex = self.employees.firstIndex(where: {$0.id == employeeProject.employeeID}) {
                let currentValue = self.employees[employeeIndex].projects[employeeProject.projectID] ?? 0
                self.employees[employeeIndex].projects[employeeProject.projectID] = currentValue +  calculateDaysWorked(dateFrom: employeeProject.dateFrom, dateTo: employeeProject.dateTo ?? "")
            } else {
                self.employees.append(Employee(
                    id: employeeProject.employeeID,
                    projects: [employeeProject.projectID:calculateDaysWorked(dateFrom: employeeProject.dateFrom, dateTo: employeeProject.dateTo ?? "")]))
            }
        }
    }
    
    static private func fetchEmployeePair() {
        self.employeePairs = []
        for project in projects {
            let employees = self.employeeProjects.filter({$0.projectID == project.id})
            if employees.count >= 2 {
                for i in 0..<employees.count {
                    for j in (i + 1)..<employees.count {
                        self.employeePairs.append(EmployeePair(
                            employee1: employees[i].employeeID, 
                            employee2: employees[j].employeeID,
                            projectID: project.id,
                            daysWorkedTogether: self.calculateWorkPeriod(employee1Project: employees[i], employee2Project: employees[j])))
                    }
                }
            }
        }
    }
    
    static private func calculateWorkPeriod(employee1Project: EmployeeProject, employee2Project: EmployeeProject) -> Int? {
        guard let employee1DateFrom = toDate(dateString: employee1Project.dateFrom),
              let dateTo1 = employee1Project.dateTo,
              let employee1DateTo = toDate(dateString: dateTo1),
              let employee2DateFrom = toDate(dateString: employee2Project.dateFrom),
              let dateTo2 = employee2Project.dateTo,
              let employee2DateTo = toDate(dateString: dateTo2) else {
            return nil
        }
        let startDate = max(employee1DateFrom, employee2DateFrom)
        let endDate = min(employee1DateTo, employee2DateTo)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if startDate < endDate {
            return calculateDaysWorked(dateFrom: dateFormatter.string(from: startDate), dateTo: dateFormatter.string(from: endDate))
        }
        
        return nil
    }
    
    static private func calculateDaysWorked(dateFrom: String, dateTo: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let fromDate = dateFormatter.date(from: dateFrom),
              let toDate = dateFormatter.date(from: dateTo) else {
            return 0
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: fromDate, to: toDate)
        var workingDays = 0
        var currentDate = fromDate
        
        for _ in 0...(components.weekday ?? 0) {
            let weekday = calendar.component(.weekday, from: currentDate)
            if weekday != 1 && weekday != 2 {
                workingDays += 1
            }
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                return workingDays
            }
            currentDate = nextDate
        }
        
        return workingDays
    }
    
    static func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        switch dateString {
        case " NULL", "":
            dateFormatter.dateFormat = DateFormat.standard.rawValue
            return dateFormatter.string(from: Date())
        default:
            for format in DateFormat.allFormats {
                dateFormatter.dateFormat = format.rawValue
                if let date = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = DateFormat.standard.rawValue
                    return dateFormatter.string(from: date)
                }
            }
            return dateString
        }
    }
    
    static func toDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: dateString)
    }
}
