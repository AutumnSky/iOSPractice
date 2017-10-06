//
//  ViewController.swift
//  MoneyCheck
//
//  Created by MinJeong Kim on 2017. 10. 6..
//  Copyright © 2017년 ASFY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var tf_50000: UITextField!
    @IBOutlet var tf_10000: UITextField!
    @IBOutlet var tf_5000: UITextField!
    @IBOutlet var tf_1000: UITextField!
    @IBOutlet var tf_500: UITextField!
    @IBOutlet var tf_100: UITextField!
    @IBOutlet var tf_50: UITextField!
    @IBOutlet var tf_10: UITextField!
    
    @IBOutlet var result_50000: UILabel!
    @IBOutlet var result_10000: UILabel!
    @IBOutlet var result_5000: UILabel!
    @IBOutlet var result_1000: UILabel!
    @IBOutlet var result_500: UILabel!
    @IBOutlet var result_100: UILabel!
    @IBOutlet var result_50: UILabel!
    @IBOutlet var result_10: UILabel!
    
    // total sum label
    @IBOutlet var resultLabel: UILabel!
    
    // currency locale of Korean
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        //        formatter.locale = NSLocale.current
        //        formatter.locale = Locale(identifier: Locale.current.identifier)
        //        formatter.locale = NSLocale(localeIdentifier: "ko_KR") as Locale!
        formatter.currencySymbol = ""
        
        return formatter
    }()
    
    var count_50000: Int = 0
    var count_10000: Int = 0
    var count_5000: Int = 0
    var count_1000: Int = 0
    var count_500: Int = 0
    var count_100: Int = 0
    var count_50: Int = 0
    var count_10: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키보드 프레임이 변경되었을 때 (UIKeyboardWillChangeFrame) 이벤트를 받기 위해 노티피케이션을 등록
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // 스크롤뷰 영역 (텍스트 필드 영역 밖)을 누르면 키보드를 숨김
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.scrollView.addGestureRecognizer(tap)
        
        tf_50000.delegate = self
        tf_10000.delegate = self
        tf_5000.delegate = self
        tf_1000.delegate = self
        tf_500.delegate = self
        tf_100.delegate = self
        tf_50.delegate = self
        tf_10.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            // 키보드 프레임의 변경 최종 값
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            // 키보드 등장 시간
            let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            
            // 키보드 등장시 애니메이션 인터폴레이션(커브)값
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
                            
                            // 스크롤뷰의 bottom inset을 키보드 높이만큼 설정해준다
                            let keyboardHeight = self.view.frame.size.height - (endFrame?.origin.y)!
                            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            },
                           completion: nil)
        }
    }
    
    // 키보드 숨김
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    // reset
    @IBAction func resetButtonTouched(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "reset?", preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "YES", style: .destructive) { (action) in
            self.tf_50000.text = "0"
            self.tf_10000.text = "0"
            self.tf_5000.text = "0"
            self.tf_1000.text = "0"
            self.tf_500.text = "0"
            self.tf_100.text = "0"
            self.tf_50.text = "0"
            self.tf_10.text = "0"
            
            self.result_50000.text = "0"
            self.result_10000.text = "0"
            self.result_5000.text = "0"
            self.result_1000.text = "0"
            self.result_500.text = "0"
            self.result_100.text = "0"
            self.result_50.text = "0"
            self.result_10.text = "0"
            
            self.count_50000 = 0
            self.count_10000 = 0
            self.count_5000 = 0
            self.count_1000 = 0
            self.count_500 = 0
            self.count_100 = 0
            self.count_50 = 0
            self.count_10 = 0
            
            self.resultLabel.text = "0"
            
            self.view.endEditing(true)
        }
        alertController.addAction(resetAction)
        
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tf_50000 {
            tf_10000.becomeFirstResponder()
        } else if textField == tf_10000 {
            tf_5000.becomeFirstResponder()
        } else if textField == tf_5000 {
            tf_1000.becomeFirstResponder()
        } else if textField == tf_1000 {
            tf_500.becomeFirstResponder()
        } else if textField == tf_500 {
            tf_100.becomeFirstResponder()
        } else if textField == tf_100 {
            tf_50.becomeFirstResponder()
        } else if textField == tf_50 {
            tf_10.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
        let count = Int(resultString)
        
        if count == nil {
            return false
        }
        
        if textField == tf_50000 {
            count_50000 = count!
            let resultNumber = NSNumber(value:(count_50000 * 50000))
            result_50000.text = self.formatter.string(from: resultNumber)
        } else if textField == tf_10000 {
            count_10000 = count!
            let resultNumber = NSNumber(value:(count_10000 * 10000))
            result_10000.text = self.formatter.string(from: resultNumber)
        } else if textField == tf_5000 {
            count_5000 = count!
            let resultNumber = NSNumber(value:(count_5000 * 5000))
            result_5000.text = self.formatter.string(from: resultNumber)
        } else if textField == tf_1000 {
            count_1000 = count!
            let resultNumber = NSNumber(value:(count_1000 * 1000))
            result_1000.text = self.formatter.string(from: resultNumber)
        } else if textField == tf_500 {
            count_500 = count!
            let resultNumber = NSNumber(value:(count_500 * 500))
            result_500.text = self.formatter.string(from: resultNumber)
        } else if textField == tf_100 {
            count_100 = count!
            let resultNumber = NSNumber(value:(count_100 * 100))
            result_100.text = self.formatter.string(from: resultNumber)
        } else if textField == tf_50 {
            count_50 = count!
            let resultNumber = NSNumber(value:(count_50 * 50))
            result_50.text = self.formatter.string(from: resultNumber)
        }
        
        let totalSumInt = (count_50000*50000)+(count_10000*10000)+(count_5000*5000)+(count_1000*1000)+(count_500*500)+(count_100*100)+(count_50*50)+(count_10*10)
        let totalSumNumber = NSNumber(value: totalSumInt)
        resultLabel.text = self.formatter.string(from: totalSumNumber)
        
        return true
    }
    
}

