//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Shunsuke Sogaya on 2017/02/19.
//  Copyright © 2017年 Shunsuke Sogaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var button: UIButton!
    
    var timer: Timer!
    var x: UIImage!

    @IBOutlet weak var viewImage: UIImageView!
    
    
    var count = 0
    
    let imageArray = [
    UIImage(named:"one")!,
    UIImage(named:"two")!,
    UIImage(named:"three")!,
    UIImage(named:"four")!,
    UIImage(named:"five")!
    ]

    @IBAction func Back(_ sender: Any) {
        count -= 1
        if count < 0{
            count = imageArray.count - 1
        }
        viewImage.image = imageArray[count]
     }
    
    @IBAction func Slide(_ sender: Any) {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            button.setTitle("停止", for: .normal)
            backButton.isEnabled = false // ボタン無効
            nextButton.isEnabled = false // ボタン無効
        }else{
            button.setTitle("再生", for: .normal)

            self.timer.invalidate()   // 現在のタイマーを破棄する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
            backButton.isEnabled = true
            nextButton.isEnabled = true
        }
    }
    
    @IBAction func Next(_ sender: Any) {
        count += 1
        
        if count >= imageArray.count{
            count = 0
        }
        
        viewImage.image = imageArray[count]
  
    }
    
    @IBAction func Zoom(_ sender: Any) {
        
        
    }
    
    func updateTimer(timer: Timer) {
        
        
        count += 1
        
        if count > 4{
            count = 0
        }
        
        viewImage.image = imageArray[count]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if self.timer != nil{
            button.setTitle("再生", for: .normal)
            
            self.timer.invalidate()   // 現在のタイマーを破棄する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
            backButton.isEnabled = true
            nextButton.isEnabled = true
        }
        

        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているxに値を代入して渡す
        resultViewController.x = imageArray[count]
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}

