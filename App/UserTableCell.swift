//
//  TableCell.swift
//  Smithington Public High School Library
//
//  Created by Colten Seevers & Nick Kortz on 1/29/18.
//  Copyright © 2018 Colten & Nick Kortz. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {
    
    @IBOutlet var UserTableLbl: UILabel!
    @IBOutlet var categoryLbl: UILabel!
    @IBOutlet var barcodeLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
