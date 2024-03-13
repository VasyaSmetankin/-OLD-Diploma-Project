//
//  PillBoxTableViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 01.05.2023.
//

import UIKit
import RealmSwift
import EmptyDataView

class PillBoxTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var pillBoxEntityTable: Results<PillBoxEntityRealm>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pillBoxEntityTable = realm.objects(PillBoxEntityRealm.self)
        tableView.reloadData()
        

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countt = pillBoxEntityTable?.count else { return 0 }
        if countt == 0 {
            tableView.setEmptyDataView(image: UIImage(systemName: "exclamationmark.triangle.fill")!, title: "The pillBox folder is empty...")
        } else {
            tableView.removeEmptyDataView()
        }
        return countt
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pillBoxEntity", for: indexPath) as! PillBoxTableViewCell
        if let entityy = pillBoxEntityTable {
            let entity = entityy[indexPath.row]
            cell.nameLabel.text = entity.pillName
            cell.countLabel.text = String(entity.pillCount) + " tablets left"
        }
//        let entity = pillBoxEntityTable[indexPath.row]
//        cell.nameLabel.text = entity.pillName
//        cell.countLabel.text = String(entity.pillCount) + " tablets left"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = pillBoxEntityTable?[indexPath.row]
        performSegue(withIdentifier: "showPillDetails", sender: cell)
        
            
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            guard let TB = self.tabBarController as? TabBarViewController else { return }
            do {
                    let realm = try Realm()
                    try realm.write {
                        guard let deleteEntity = pillBoxEntityTable?[indexPath.row] else { return }
                        realm.delete(deleteEntity)
                        pillBoxEntityTable = realm.objects(PillBoxEntityRealm.self)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                } catch {
                    print("error \(error)")
                }
            
//            reminderEntityTable.remove(at: indexPath.row)
//            TB.reminderEntityArrayTB.remove(at: indexPath.row)
            
        }    }


   
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if tableView.indexPathForSelectedRow != nil {
            guard let pillBoxDetailsVC = segue.destination as? PillBoxDetailsViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let selected = pillBoxEntityTable?[indexPath.row]
            pillBoxDetailsVC.pillBoxDetailsEntity = selected
            pillBoxDetailsVC.entityIndex = indexPath.row
        }
      

    }
    
    @IBAction func pillDetailsUnwind(for segue: UIStoryboardSegue) {
        guard let pillBoxDetailsVC = segue.source as? PillBoxDetailsViewController else { return }
        guard let PBDEntity = pillBoxDetailsVC.pillBoxDetailsEntity else { return }
        guard let PBDIndex = pillBoxDetailsVC.entityIndex else { return }
        guard let TB = self.tabBarController as? TabBarViewController else { return }
        
//        TB.pillBoxEntityArrayTB[PBDIndex] = PBDEntity
//        pillBoxEntityTable[PBDIndex] = PBDEntity
        tableView.reloadData()


    }

    

    
    
   
    
    
   
    
    
    
    
    

}


