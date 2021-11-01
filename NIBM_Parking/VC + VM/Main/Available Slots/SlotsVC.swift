//
//  SlotsVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa  on 2021-11-01.
//

import UIKit

class SlotsVC: UIViewController {

    @IBOutlet weak var slotTbl: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotTbl.delegate = self
        slotTbl.dataSource = self
        // Do any additional setup after loading the view.
    }
    

   
}

extension SlotsVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "VIP Parkings"
        }else{
            return "Normal Parkings"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cellCount:Int?
        
        if section == 0{
            cellCount = 4
        }else{
            cellCount = 16
        }
        return cellCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SlotCell") as! SlotCell
        return cell
    }
    
    
}
