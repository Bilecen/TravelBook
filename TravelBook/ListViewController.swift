//
//  ListViewController.swift
//  TravelBook
//
//  Created by Muhammet Taha Bilecen on 27.10.2021.
//

import UIKit
import CoreData

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource   {
    
    
    @IBOutlet weak var konumlar: UITableView!
    
    var idArray = [UUID]()
    var titles = [String]()
    var subtitle = [String]()
    var latitude = [Double]()
    var longtide = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        konumlar.delegate = self
        konumlar.dataSource=self

         getData()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }

    
    @objc func addButtonClicked(){
         performSegue(withIdentifier: "mapPage" , sender: nil)
    }
    
    @objc func getData(){
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
          fetchRequest.returnsObjectsAsFaults = false
          do{
               let results = try context.fetch(fetchRequest)
          
              for result in results as! [NSManagedObject] {
                  if let id = result.value(forKey: "id") as? UUID{
                      self.idArray.append(id)
                  }
                  
                  if let title = result.value(forKey: "title") as? String{
                      self.titles.append(title)
                  }
                  
                  if let stitle = result.value(forKey: "subtitle")as? String{
                      self.subtitle.append(stitle)
                  }
                  
                  if let x = result.value(forKey: "latitude")  as? Double{
                      self.latitude.append(x)
                  }
                  
                  if let y = result.value(forKey: "longitude") as? Double{
                      self.longtide.append(y)
                  }
              }
              konumlar.reloadData()
          }catch{
              print("Hata Bastı")
          }
          
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return idArray.count;
  }
  
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = konumlar.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CellRow
      cell.title.text = titles[indexPath.row]
      cell.subtitle.text = subtitle[indexPath.row]
      cell.x.text =  String(latitude[indexPath.row])
      cell.y.text =  String(longtide[indexPath.row])
      return cell;
  }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0;//Choose your custom row height
    }
   

}

 
