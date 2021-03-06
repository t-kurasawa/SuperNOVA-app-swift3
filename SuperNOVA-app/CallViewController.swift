//
//  CallViewController.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/25.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {
    
    override
    func viewDidLoad() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        shopName.text = appDelegate._shoptitle
        
        let imageData :Data = try! Data(contentsOf: URL(string: appDelegate._shopimage as! String)! );
        shopImage.image = UIImage(data:imageData)
        
        //selectTimeBtn.isUserInteractionEnabled = false
        change30mBtn.setBackgroundImage(UIImage(named: "btn_orange"), for: UIControlState.normal)
        change60mBtn.setBackgroundImage(UIImage(named: "btn_gray"), for: UIControlState.normal)
    }
    
    @IBOutlet weak var selectTimeBtn: UIButton!
    
    @IBOutlet weak var change30mBtn: UIButton!
    @IBOutlet weak var change60mBtn: UIButton!
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    
    @IBAction func change30m(_ sender: UIButton) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        appDelegate._time = 30
        
        //selectTimeBtn.isUserInteractionEnabled = true
        change30mBtn.setBackgroundImage(UIImage(named: "btn_orange"), for: UIControlState.normal)
        change60mBtn.setBackgroundImage(UIImage(named: "btn_gray"), for: UIControlState.normal)
    }
    
    @IBAction func change60m(_ sender: UIButton) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        appDelegate._time = 60
        
        //selectTimeBtn.isUserInteractionEnabled = true
        change30mBtn.setBackgroundImage(UIImage(named: "btn_gray"), for: UIControlState.normal)
        change60mBtn.setBackgroundImage(UIImage(named: "btn_orange"), for: UIControlState.normal)
    }
    
    @IBAction func call(_ sender: UIButton) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        
        if(appDelegate._time == 0){
            appDelegate._time = 30
        }
        
        // 画面遷移
        ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toWaitingMapView")
        
    }
}
