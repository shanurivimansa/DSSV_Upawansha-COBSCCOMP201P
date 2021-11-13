//
//  SlotCell.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-01.
//

import UIKit

class SlotCell: UITableViewCell {

    @IBOutlet weak var slotNoLbl: UILabel!
    @IBOutlet weak var parkImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(model:Slot){
        
        if model.isVIP == "true"{
            parkImg.image = UIImage(named: "b5998afc-2282-4e5a-bf96-351b84704cb0.cb685ede3f93c8f195048d40dd3664bf")
        }else{
            parkImg.image = UIImage(named: "sjoerdverbeek-schiphol-icondesign-large-parking")
        }
        
        slotNoLbl.text = model.name
    }

}
