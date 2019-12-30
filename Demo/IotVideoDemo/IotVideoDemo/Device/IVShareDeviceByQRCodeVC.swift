//
//  IVQRCodeCreateVC.swift
//  IotVideoDemo
//
//  Created by ZhaoYong on 2019/12/3.
//  Copyright © 2019 gwell. All rights reserved.
//

import UIKit
import IVAccountMgr
import IoTVideo
import SwiftyJSON

class IVShareDeviceByQRCodeVC: UIViewController, IVDeviceAccessable {
    var device: IVDevice!
    @IBOutlet weak var didTF: UITextField!
    @IBOutlet weak var devNameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var QRCodeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let device = device {
            didTF.text = device.deviceID
            devNameTF.text = "gwell"
            userNameTF.text = "萌胖子"
        } 
    }
    
    @IBAction func createQRCode(_ sender: UIButton) {
        view.endEditing(true)
        IVAccountMgr.shared.shareDevieForQRCode(deviceId: didTF.text ?? "", deviceName: devNameTF.text ?? "", userName: userNameTF.text ?? "") { (json, error) in
            guard let json = json else {
                showAlert(msg: "\(error!)")
                return
            }
            let token = JSON(parseJSON: json)["data"]["qrcodeToken"].string ?? ""
            showAlert(msg: "获取二维码token: \(token)")
            self.QRCodeImage.image = IVQRCodeHelper.createQRCode(with: token, qrSize: self.QRCodeImage.bounds.size)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}