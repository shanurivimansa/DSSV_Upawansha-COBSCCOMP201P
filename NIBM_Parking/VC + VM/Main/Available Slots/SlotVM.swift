//
//  SlotVM.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-13.
//

import Foundation
import FirebaseStorage
import Firebase

class SlotVM{
    
    var normalSlotList = [Slot]()
    var vipSlotList = [Slot]()

    
    
    
    func fetchFoods(completion:@escaping CompletionHandler){
        
        let slotListRef: DatabaseReference! = Database.database().reference().child("slots")
        
        slotListRef.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.normalSlotList.removeAll()
                self.vipSlotList.removeAll()
                
                for slots in snapshot.children.allObjects as! [DataSnapshot]{
                    
                    let slotObject = slots.value as? [String: AnyObject]
                    
                    let slotId = slotObject?["slotId"]
                    let name  = slotObject?["name"]
                    let isVIP = slotObject?["isVIP"]
                    let isAvailable  = slotObject?["isAvailable"]
                    let bookedBy  = slotObject?["bookedBy"]
   
                    
                    let slot = Slot(slotId: slotId as! String?, name: name as! String?, isVIP: isVIP as! String?, isAvailable: isAvailable as! String?, bookedBy: bookedBy as! String?)
                    //appending it to list
                    
                    if slot.isAvailable == "true" && slot.isVIP == "false"{
                        self.normalSlotList.append(slot)
                    }else if slot.isAvailable == "true" && slot.isVIP == "true" {
                        self.vipSlotList.append(slot)
                    }
                    
                }
                
                completion(true, 200, "success")
            }
        }
    }
    
}
