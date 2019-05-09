//
//  WhetherReportListVC.swift
//  WhetherReport
//
//  Created by Deepak.Maheshwari on 08/05/19.
//  Copyright © 2019 Deepak.Maheshwari. All rights reserved.
//

import UIKit
import SwiftSpinner
import CoreData


class WhetherReportListVC: UIViewController {
    
    //MARK: - Properties
    var isViewLaod = false
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var apiTimer: Timer?
    var count = 0
    var sendObj : CityTemp?
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - UIView methods
    override func viewDidLoad() {
        super.viewDidLoad()
        isViewLaod = false
        fetchCityTempratureFromDB()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isViewLaod == false {
            SwiftSpinner.show(kSpinnerMsg)
            isViewLaod = true
        }
        tableView.tableFooterView = UIView()
        apiTimer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(getDataFromServer), userInfo: nil, repeats: true)
        getDataFromServer()

    }
     //MARK: - Custom Methods
    @objc func getDataFromServer()  {
        
        Utilities.getcityTempratureFromServer("4163971") { (data) in
            print(data)
            CoreDataOperationClass.setValueOnCoreData(data)
            self.count += 1
            if self.count == 3 {
                SwiftSpinner.hide()
            }
            
        }
        Utilities.getcityTempratureFromServer("2147714") { (data) in
            CoreDataOperationClass.setValueOnCoreData(data)
            self.count += 1
            if self.count == 3 {
                SwiftSpinner.hide()
            }
        }
        Utilities.getcityTempratureFromServer("2174003") { (data) in
            CoreDataOperationClass.setValueOnCoreData(data)
            self.count += 1
            if self.count == 3 {
                SwiftSpinner.hide()
            }
        }
    }
    
    func fetchCityTempratureFromDB() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityTemp")
        let fetchSort = NSSortDescriptor(key: KCityName, ascending: true)
        fetchRequest.sortDescriptors = [fetchSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDel.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }
    }
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource methods

extension WhetherReportListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = fetchedResultsController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KCellIdentifier)! as UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    ////////Configuring cell
    func configureCell(_ cell: UITableViewCell, forRowAtIndexPath: IndexPath) {
        let tempObj = fetchedResultsController.object(at:forRowAtIndexPath) as! CityTemp
        cell.textLabel?.text = tempObj.value(forKey: KCityName) as? String
        cell.detailTextLabel?.text = "\(tempObj.value(forKey: KCityTemprature)!)"
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendObj = fetchedResultsController.object(at:indexPath) as? CityTemp
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "CityWeatherDetail") as! CityWeatherDetailVC
        ivc.sendObj = sendObj
        ivc.modalTransitionStyle = .flipHorizontal
        self.present(ivc, animated: true, completion: nil)
    }
    
}
//MARK: - FetchedResultsController Delegate

extension WhetherReportListVC:NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
//    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
//        default: break
//        }
//    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath! as IndexPath], with: .automatic)
        default: break
        }
    }
}
