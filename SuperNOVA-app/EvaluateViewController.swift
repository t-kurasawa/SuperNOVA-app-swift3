//
//  EvaluateViewController.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/25.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import Foundation
import UIKit

class EvaluateViewController: UIViewController {
    
    @IBOutlet weak var photo_teacher: UIImageView!
    @IBOutlet weak var name_teacher: UILabel!
    @IBOutlet weak var rate_image: UIImageView!
    var rating: String = "0"
    
    @IBAction func rate1(_ sender: UIButton) {
        rate_image.image = UIImage(named: "rating_star_1")
        rating = "1";
    }
    
    @IBAction func rate2(_ sender: UIButton) {
        rate_image.image = UIImage(named: "rating_star_2")
        rating = "2";
    }
    
    @IBAction func rate3(_ sender: UIButton) {
        rate_image.image = UIImage(named: "rating_star_3")
        rating = "3";
    }
    
    @IBAction func rate4(_ sender: UIButton) {
        rate_image.image = UIImage(named: "rating_star_4")
        rating = "4";
    }
    
    @IBAction func rate5(_ sender: UIButton) {
        rate_image.image = UIImage(named: "rating_star_5")
        rating = "5";
    }
    
    override func viewDidLoad() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        //教師
        self.name_teacher.text = appDelegate._partnerName
        self.photo_teacher.image =  API.downloadImage(appDelegate._partnerimage)
        self.photo_teacher.layer.cornerRadius = self.photo_teacher.frame.size.width / 2
        self.photo_teacher.clipsToBounds = true
        self.photo_teacher.layer.borderColor = UIColor.orange.cgColor
        
    }
    
    
    @IBAction func rate(_ sender: UIButton) {
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        
        //ピッチング終了リクエスト
        UserAPI.updateUserRate(appDelegate._partner,rate: rating ,sync: true,
            success:{
                values in let closure = {
                    NSLog("---EvaluateViewController UserAPI.updateUserRate success");
                    // 通信は成功したが、エラーが返ってきた場合
                    if(API.isError(values)){
                        NSLog("---EvaluateViewController UserAPI.updateUserRate isError");
                        /**
                         *  ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                            Indicator.windowClose()
                         */
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                message: values["errorMessage"] as! String)
                            return
                    }
                                        
                    NSLog(values.debugDescription);
                    ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toMapView")

                }
                // 通知の監視
                if(!Thread.isMainThread){
                    NSLog("---EvaluateViewController !NSThread.isMainThread() in success");
                    DispatchQueue.main.sync {
                        NSLog("---EvaluateViewController dispatch_sync");
                        closure()
                    }
                } else {
                        NSLog("---EvaluateViewController dispatch_sync else");
                        closure()   // 恐らく実行されない
                }
                                    
            },
            failed: {
                id, message in let closure = {
                    NSLog("---EvaluateViewController UserAPI.updateUserRate failed");
                    /**
                     *  ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                        Indicator.windowClose()
                     */
                    // 失敗した場合エラー情報を表示
                    if(id == -2) {
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                message: NSLocalizedString("MAX_FILE_SIZE_OVER", comment: ""));
                    } else {
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                message: NSLocalizedString("ALERT_MESSAGE_NETWORK_ERROR", comment: ""));
                    }
                }
                // 通知の監視
                if(!Thread.isMainThread){
                    NSLog("---EvaluateViewController !NSThread.isMainThread() in failed");
                    DispatchQueue.main.sync {
                        NSLog("---EvaluateViewController dispatch_sync");
                        closure()
                    }
                } else {
                    NSLog("---EvaluateViewController dispatch_sync else");
                    closure()   //恐らく実行されない
                }
            }
        )
    }
}
