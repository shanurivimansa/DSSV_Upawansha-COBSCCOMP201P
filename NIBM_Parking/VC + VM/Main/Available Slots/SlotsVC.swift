//
//  SlotsVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa  on 2021-11-01.
//

import UIKit

class SlotsVC: UIViewController,LoadingIndicatorDelegate {
    
    @IBOutlet weak var slotTbl: UITableView!
    
    var vm = SlotVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotTbl.delegate = self
        slotTbl.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAvailableSlots()
    }
    
    func getAvailableSlots(){
        self.startLoading()
        vm.fetchSlots { success, code, message in
            self.stopLoading()
            
            if success{
                self.slotTbl.reloadData()
            }
            
        }
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
            cellCount = vm.vipSlotList.count
        }else{
            cellCount = vm.normalSlotList.count
        }
        return cellCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SlotCell") as! SlotCell
        
        switch indexPath.section{
        case 0:
            cell.configCell(model: vm.vipSlotList[indexPath.row])
        case 1:
            cell.configCell(model: vm.normalSlotList[indexPath.row])
        default:
            print("")
        }
   
        return cell
    }
    
    
}
