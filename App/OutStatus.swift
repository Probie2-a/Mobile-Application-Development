//
//  OutStatus
//  Smithington Public High School Library
//
//  Created by Colten Seevers & Nick Kortz on 1/29/18.
//  Copyright © 2018 Colten & Nick Kortz. All rights reserved.
//

import UIKit

class OutStatus: UIViewController
{
    @IBOutlet weak var CurrentUserLbl: UILabel!
    @IBOutlet weak var CurrentNameLbl: UILabel!
    @IBOutlet weak var CurrentUserIDLbl: UILabel!
    @IBOutlet weak var CurrentUserTypeLbl: UILabel!
    @IBOutlet weak var CurrentBookNameLbl: UILabel!
    @IBOutlet weak var CurrentDueLbl: UILabel!
    @IBOutlet weak var ReservedNameLbl: UILabel!
    
    
    override func viewDidLoad() {
        
        print(CurrentUser)
        print(CurrentCode)
        print(CurrentUserType.rawValue)
        print(CObook)
        print(COdue)
        print(RESbook)
        
       CurrentUserLbl.text = CurrentUser
        CurrentNameLbl.text = CurrentUser
        CurrentUserIDLbl.text = CurrentCode
        CurrentUserTypeLbl.text = CurrentUserType.rawValue
        CurrentBookNameLbl.text = CObook
        CurrentDueLbl.text = COdue
        ReservedNameLbl.text = RESbook
        
        
        super.viewDidLoad()
    }
}
