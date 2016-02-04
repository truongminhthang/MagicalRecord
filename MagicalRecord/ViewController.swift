//
//  ViewController.swift
//  MagicalRecord
//
//  Created by Trương Thắng on 2/4/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var reuseIdCell = "cell"
    var label = UILabel()
    var currentVideo :VideoEntity!
    var data : NSFetchedResultsController!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = fetchAllVideos()
        do {
            try  data.performFetch()
            let test = data.fetchedObjects
            
        } catch  {
            
        }
        
        //        view.addSubview(label)
        //        label.frame = CGRect(origin: CGPoint(x: 40, y: 200), size: CGSize(width: 280, height: 40))
        var index = Int.loadFromUserDefaults(withKey: "index")
        print("index", index)
        index++
        index.saveToUserDefaults(withKey: "index")
        currentVideo = VideoEntity.MR_createEntity()
        currentVideo.id = "thang \(index)"
        
        AppDelegate.shareInstance().saveContext()
    }
    
    //    override func viewWillUnload() {
    //
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension ViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sectionCount = data.sections?.count {
            print(sectionCount)
            return sectionCount
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowCount = data.sections?[section].numberOfObjects {
            print(rowCount)
            return rowCount
        }
        return 0
        
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdCell)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdCell)
        }
        configureCell(cell!, atIndexPath: indexPath)
        return cell!
    }
}


// MARK: - NSFetchedResultsControllerDelegate

extension ViewController: NSFetchedResultsControllerDelegate {
    
    
    private func fetchAllVideos() -> NSFetchedResultsController? {
        
        let test = VideoEntity.MR_findAll()
        return VideoEntity.MR_fetchAllGroupedBy("id", withPredicate: nil, sortedBy: nil, ascending: false)
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRowAtIndexPath(indexPath)!
                configureCell(cell,atIndexPath: indexPath)
            }
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            }
        }
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        let videoEntity = data.objectAtIndexPath(indexPath) as! VideoEntity
        cell.textLabel?.text = videoEntity.id
    }
}

