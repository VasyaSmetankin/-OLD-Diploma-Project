//
//  ReminderTableViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 01.05.2023.
//

import UIKit
import RealmSwift
import EmptyDataSet_Swift
import EmptyDataView
import UserNotifications

class ReminderTableViewController: UITableViewController, UIViewControllerTransitioningDelegate, UNUserNotificationCenterDelegate {
    
    
    let realm = try! Realm()
    
    var image: UIImage?
    var reminderEntityTable: Results<ReminderEntityRealm>?
    var PillBoxReminderEntityTable: Results<PillBoxEntityRealm>?
    let dateformatter = DateFormatter()

    
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var secondaryLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        setupRefreshControl()

        let realm = try! Realm()
        reminderEntityTable = realm.objects(ReminderEntityRealm.self)
        PillBoxReminderEntityTable = realm.objects(PillBoxEntityRealm.self)
        tableView.reloadData()
        UNUserNotificationCenter.current().requestAuthorization(options: [[.alert,
                        .sound, .badge]], completionHandler: { (granted, error) in
                    // Handle Error
                })
                UNUserNotificationCenter.current().delegate = self

        

    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
   
    

   
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        guard let count = reminderEntityTable?.count else { return 0 }
        if count == 0 {
            tableView.setEmptyDataView(image: UIImage(systemName: "exclamationmark.triangle.fill")!, title: "The reminder folder is empty...")
        } else {
            tableView.removeEmptyDataView()
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderEntity", for: indexPath) as! ReminderTableViewCell
        if let entityy = reminderEntityTable {
            let entity = entityy[indexPath.row]
            cell.mainLabel.text = entity.name
            cell.secondaryLabel.text = entity.pillEntity?.pillName
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            cell.dateLabel.text = dateFormatter.string(from: entity.date)
        }
//        let entity = reminderEntityTable[indexPath.row]
//        cell.mainLabel.text = entity.name
//        cell.secondaryLabel.text = entity.pillEntity?.pillName
        
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "HH:mm"
//        let currentDate = Date()
//        let calendar = Calendar.current
//        let convertedDate = calendar.date(bySettingHour: entity.date.hour ?? 0, minute: entity.date.minute ?? 0, second: 0, of: currentDate)
//        if let convertedDate = convertedDate {
//            cell.dateLabel.text = dateformatter.string(for: convertedDate)
//            cell.dateLabel.text = dateformatter.string(from: entity.date)
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let entityy = reminderEntityTable {
            let cell = entityy[indexPath.row]
            performSegue(withIdentifier: "showDetails", sender: cell)
        }
        
//        let cell = reminderEntityTable[indexPath.row]
//        performSegue(withIdentifier: "showDetails", sender: cell)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            guard let TB = self.tabBarController as? TabBarViewController else { return }
            do {
                    let realm = try Realm()
                    try realm.write {
                        guard let deleteEntity = reminderEntityTable?[indexPath.row] else { return }
                        realm.delete(deleteEntity)
                        reminderEntityTable = realm.objects(ReminderEntityRealm.self)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                } catch {
                    print("error \(error)")
                }
            
//            reminderEntityTable.remove(at: indexPath.row)
//            TB.reminderEntityArrayTB.remove(at: indexPath.row)
            
        }
    }
    
    
    // MARK: -  refresh control
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()


        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.refreshControl = refreshControl

    }
    
    @objc private func refreshData(_ sender: Any) {
        let realm = try! Realm()
        reminderEntityTable = realm.objects(ReminderEntityRealm.self)
        PillBoxReminderEntityTable = realm.objects(PillBoxEntityRealm.self)
//        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
//        tableView.refreshControl?.endRefreshing()
        
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let reminderDetails = segue.destination as? ReminderDetailsViewController else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        
        reminderDetails.ReminderEntityDetail = reminderEntityTable?[index.row]
//        reminderDetails.entityIndex = index.row
//        reminderDetails.pillBoxArr = PillBoxReminderEntityTable
        
    }
    
    
    @IBAction func reminderDetailsUnwind(for unwindSegue: UIStoryboardSegue) {
        guard let RemDetails = unwindSegue.source as? ReminderDetailsViewController else { return }
        guard let RemDetailsEntity = RemDetails.ReminderEntityDetail else { return }
        guard let entIndex = RemDetails.entityIndex else { return }
        guard let TB = self.tabBarController as? TabBarViewController else { return }
        do {
                let realm = try Realm()
                try realm.write {
                    realm.add(RemDetailsEntity)
                    reminderEntityTable = realm.objects(ReminderEntityRealm.self)
                    tableView.reloadData()
                }
            } catch {
                print("error \(error)")
            }
//        reminderEntityTable[entIndex] = ReminderEntity(name: RemDetailsEntity.name , date: RemDetailsEntity.date, description: RemDetailsEntity.description)
//        TB.reminderEntityArrayTB[entIndex] = ReminderEntity(name: RemDetailsEntity.name , date: RemDetailsEntity.date, description: RemDetailsEntity.description)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    }
    

    

    

    


    
    
  
    
    
    
    
    
    
    
    


   


