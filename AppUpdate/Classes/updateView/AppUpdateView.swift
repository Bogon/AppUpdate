//
//  AppUpdateView.swift
//
//  Created by Senyas
//  Copyright © Senyas. All rights reserved.
//

import UIKit

class AppUpdateView: UITableViewCell{

    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var btn_update: UIButton!
    @IBOutlet weak var btn_close: UIButton!
    @IBOutlet weak var label_version: UILabel!
    var receiveContent :String?
    var mustUpdate:Bool = false;
    override func awakeFromNib() {
        super.awakeFromNib()
        view_bg.layer.cornerRadius = 4;
        btn_update.layer.cornerRadius = 4;
        // Initialization code
        self.contentTextView.isEditable = false
    }
    @IBAction func btnClick_close(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func btnClick_update(_ sender: Any) {
        
        if UIApplication.shared.canOpenURL(UpdateProvider.AppUpdateUrl) {
            UIApplication.shared.openURL(UpdateProvider.AppUpdateUrl)
            if mustUpdate {
                exit(0)
            }
        }
        self.removeFromSuperview()
    }
}
