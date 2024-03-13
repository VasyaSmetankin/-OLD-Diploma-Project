//
//  TabBarViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 01.05.2023.
//

import UIKit
import RealmSwift
import UserNotifications


class TabBarViewController: UITabBarController, UIViewControllerTransitioningDelegate {
    
    
    
    
    
    
    
    @IBOutlet var debugItem: UIBarButtonItem!
    

    var reminderEntityArrayTB: Results<ReminderEntityRealm>!
    var pillBoxEntityArrayTB: Results<PillBoxEntityRealm>!
//
//    var reminderEntityArrayTB: [ReminderEntity] = []
//    var pillBoxEntityArrayTB: [PillBoxEntity] = []
    
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableViews()
        debugItem.isHidden = true
        
        
        
        
        let realm = try! Realm()
        reminderEntityArrayTB = realm.objects(ReminderEntityRealm.self)
        pillBoxEntityArrayTB = realm.objects(PillBoxEntityRealm.self)
        
        
//        guard let TV = viewControllers?.first as? ReminderTableViewController else { return }
//        TV.tableView.reloadData()
//        guard let PB = viewControllers?.last as? PillBoxTableViewController else { return }
//        PB.tableView.reloadData()
        


        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
    }
    
    
    private func prepareTableViews() {
//        guard let reminderTV = viewControllers?.first as? ReminderTableViewController else { return }
//        reminderTV.reminderEntityTable = reminderEntityArrayTB
//
//        guard let pillBoxTV = viewControllers?.last as? PillBoxTableViewController else { return }
//        pillBoxTV.pillBoxEntityTable = pillBoxEntityArrayTB
//        print("prepareTableViews done")
    }
    
    
    
    // MARK: -  segues
    
    @IBAction func transitionToCreation() {
        if self.selectedIndex == 0 {
            performSegue(withIdentifier: "reminderCreation", sender: nil)
        } else {
            performSegue(withIdentifier: "pillBoxCreation", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reminderCreation" {
            if let RemCreateVC = segue.destination as? CreateReminderViewController {
                RemCreateVC.ReminderEntityArray = ReminderEntityRealm()
                RemCreateVC.PillBoxEntityArray = pillBoxEntityArrayTB
            }
            
        } else if segue.identifier == "pillBoxCreation" {
            if let PillCreateVC = segue.destination as?
                CreatePillBoxViewController {
                PillCreateVC.PillEntityArray = PillBoxEntityRealm()
            }
        }
    }
    

    @IBAction func creationUnwind(for unwindSegue: UIStoryboardSegue) {
        guard let RemCreateVC = unwindSegue.source as? CreateReminderViewController else { return }
        guard let remCreateEntity = RemCreateVC.ReminderEntityArray else { return }
//        reminderEntityArrayTB.append(ReminderEntity(name: remCreateEntity.name, date: remCreateEntity.date, description: remCreateEntity.description))
        do {
                let realm = try Realm()
                try realm.write {
                    realm.add(remCreateEntity)
                    guard let TB = viewControllers?.first as? ReminderTableViewController else { return }
                    TB.tableView.reloadData()
                }
            } catch {
                print("error \(error)")
            }
        
        ReminderManager.shared.scheduleLocalNotification(for: remCreateEntity)
        

        guard let TB = viewControllers?.first as? ReminderTableViewController else { return }
        TB.reminderEntityTable = reminderEntityArrayTB
        TB.PillBoxReminderEntityTable = pillBoxEntityArrayTB
        TB.tableView.reloadData()
       
        
       
       
    }
    
    @IBAction func pillBoxUnwind(for unwindSegue: UIStoryboardSegue) {
        guard let pillCreateVC = unwindSegue.source as? CreatePillBoxViewController else { return }
        guard let PillCreateEntity = pillCreateVC.PillEntityArray else { return }
//        pillBoxEntityArrayTB.append(PillBoxEntity(pillName: PillCreateEntity.pillName , pillCount: PillCreateEntity.pillCount, pillDescription: PillCreateEntity.pillDescription))
        do {
                let realm = try Realm()
                try realm.write {
                    realm.add(PillCreateEntity)
                }
            } catch {
                print("error \(error)")
            }
        
        
        
        
        guard let TB = viewControllers?.last as? PillBoxTableViewController else { return }
        TB.pillBoxEntityTable = pillBoxEntityArrayTB
        TB.tableView.reloadData()
        
    }
    
    
    
    
    @IBAction func debugButton() {
        NotificationCenter.default.removeObserver(self)
        UserDefaults.standard.set(false, forKey: "HasLaunchedBefore")

        // Проверяем значение ключа после обнуления
        if !UserDefaults.standard.bool(forKey: "HasLaunchedBefore") {
            // Значение успешно обнулено и равно false
            print("Value has been reset")
        } else {
            // Значение не было обнулено или по-прежнему равно true
            print("Value has not been reset")
        }
        
    }
    
    
}
