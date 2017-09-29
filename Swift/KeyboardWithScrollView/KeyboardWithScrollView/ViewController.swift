//
//  ViewController.swift
//  KeyboardWithScrollView
//
//  Created by MinJeong Kim on 2017. 9. 29..
//  Copyright © 2017년 ASFY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키보드 프레임이 변경되었을 때 (UIKeyboardWillChangeFrame) 이벤트를 받기 위해 노티피케이션을 등록합니다
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // 스크롤뷰 영역 (텍스트 필드 영역 밖)을 누르면 키보드를 숨깁니다
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.scrollView.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // 메모리에서 정리될 때 노티피케이션에 등록된 self를 삭제해줍니다
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // viewDidLoad에서 키보드 프레임이 변경될 때 호출되도록 설정했기 때문에 키보드 프레임이 변경될 때 마다 호출됩니다
    // 예) 키보드 등장할 때, 키보드 사라질 때, 이모지등으로 키보드 레이아웃이 바뀔 때
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
}

