//
//  ViewController.swift
//  tarepanda
//
//  Created by Min Hu on 2023/10/29.
//

import UIKit

class ViewController: UIViewController {
    // 顯示請輸入密碼或密碼錯誤的 Label
    @IBOutlet weak var passcodeIntroLabel: UILabel!
    // 趴趴熊圖片
    @IBOutlet var passcodeImageViews: [UIImageView]!
    // 數字鍵 Array
    @IBOutlet var numberKeys: [UIButton]!
    // 預設正確密碼
    let passcode = "2046"
    // 變數儲存使用者輸入的數字
    var codeEntered = ""
    // 紀錄錯誤密碼次數
    var wrongCodeTimes = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // 使用迴圈將所有 passcodeImageView 的透明度變成 0.1
        for passcodeImageView in passcodeImageViews{
            passcodeImageView.alpha = 0.1
        }
        passcodeIntroLabel.text = "請輸入密碼。"
        // 清除所有已輸入密碼
        codeEntered.removeAll()
        // 重置錯誤次數
        wrongCodeTimes = 0
    }
    // 只要數字鍵被點按，就會執行這個函數
    @IBAction func passcodeCheck(_ sender: UIButton) {
        // codeEntered 加入被按到按鍵的文字
        codeEntered.append((sender.titleLabel?.text)!)
        // 依據輸入密碼的數量決定密碼圖片的顯示，並在輸入四個密碼時核對密碼
        switch codeEntered.count{
        // 輸入一個數字
        case 1:
            // 趴趴熊的透明度改成 1 ，變成不透明
            passcodeImageViews[0].alpha = 1
        // 輸入兩個數字
        case 2:
            passcodeImageViews[1].alpha = 1
        // 輸入三個數字
        case 3:
            passcodeImageViews[2].alpha = 1
        // 輸入四個數字
        case 4:
            passcodeImageViews[3].alpha = 1
            // 如果密碼錯誤
            if codeEntered != passcode{
                // 使用迴圈將所有 passcodeImageView 的透明度變成 0.1
                for passcodeImageView in passcodeImageViews{
                    passcodeImageView.alpha = 0.1
                }
                // 顯示密碼錯誤
                passcodeIntroLabel.text = "密碼錯誤。"
                // 清除剛輸入的全部密碼
                codeEntered.removeAll()
                // 錯誤次數 +1
                wrongCodeTimes += 1

                switch wrongCodeTimes{
                case 1:
                    // 宣告一個提示窗常數
                    let alertLogIn = UIAlertController(title: "密碼錯誤", message: "密碼錯誤1次。", preferredStyle: .alert)
                    // 設定確定鍵
                    let okAction = UIAlertAction(title: "確定", style: .destructive, handler: nil)
                    // 將確定鍵加入提示窗
                    alertLogIn.addAction(okAction)
                    // 顯示提示框
                    self.present(alertLogIn, animated: true)
                case 2:
                    // 宣告一個提示窗常數
                    let alertLogIn = UIAlertController(title: "密碼錯誤", message: "密碼錯誤2次。", preferredStyle: .alert)
                    // 設定確定鍵
                    let okAction = UIAlertAction(title: "確定", style: .destructive, handler: nil)
                    // 將確定鍵加入提示窗
                    alertLogIn.addAction(okAction)
                    // 顯示提示框
                    self.present(alertLogIn, animated: true)
                default:
                    // 宣告一個提示窗常數
                    let alertLogIn = UIAlertController(title: "密碼錯誤", message: "請於10秒後再輸入密碼。", preferredStyle: .alert)
                    // 顯示提示框
                    self.present(alertLogIn, animated: true)
                    // 設定確定鍵
                    let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
                    // 將確定鍵加入提示窗
                    alertLogIn.addAction(okAction)
                    // 將數字鍵全部隱藏
                    for numberKey in numberKeys{
                        numberKey.isHidden = true
                    }
                    // 設定鎖定時間10秒之後執行 reset()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        self.reset()
                    }
                }
                
            }else{// 如果密碼正確
                // 宣告一個提示窗常數
                let alertLogIn = UIAlertController(title: "成功登入", message: "密碼正確。", preferredStyle: .alert)
                // 設定確定鍵
                let okAction = UIAlertAction(title: "確定", style: .destructive, handler: nil)
                // 將確定鍵加入提示窗
                alertLogIn.addAction(okAction)
                // 顯示提示框
                self.present(alertLogIn, animated: true)
                // 重置畫面
                viewDidLoad()
                }
        default://沒輸密碼的狀態
            // 使用迴圈將所有 passcodeImageView 的透明度變成 0.1
            for passcodeImageView in passcodeImageViews{
                passcodeImageView.alpha = 0.1
            }
        }        
    }
    // 點按倒退鍵
    @IBAction func deleteTapped(_ sender: UIButton) {
        // 依據輸入密碼的數量決定行動
        switch codeEntered.count{
        case 3:
            // 第三張圖片變成半透明
            passcodeImageViews[2].alpha = 0.1
            // 清除最後一個輸入的數字
            codeEntered.removeLast()
        case 2:
            // 第二張圖片變成半透明
            passcodeImageViews[1].alpha = 0.1
            // 清除最後一個輸入的數字
            codeEntered.removeLast()
        case 1:
            // 第一張圖片變成半透明
            passcodeImageViews[0].alpha = 0.1
            // 清除最後一個輸入的數字
            codeEntered.removeLast()
        default:
            // 終止執行
            break
        }
    }
    func reset(){
        // 使用迴圈將所有 passcodeImageView 的透明度變成 0.1
        for passcodeImageView in passcodeImageViews{
            passcodeImageView.alpha = 0.1
        }
        passcodeIntroLabel.text = "請輸入密碼。"
        // 清除所有已輸入密碼
        codeEntered.removeAll()
        // 重置錯誤次數
        wrongCodeTimes = 0
        // 顯示全部數字鍵
        for numberKey in numberKeys{
            numberKey.isHidden = false
        }
    }
}

