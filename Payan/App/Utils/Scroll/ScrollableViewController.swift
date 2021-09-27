//
//  keyboardObserver.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation
import UIKit

class ScrollableViewController: UIViewController {
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        if let scrollView = scrollView {
            let keyboardRect = keyboardValue.cgRectValue
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height + keyboardRect.height)
        } else {
            Console.log("you must set a scroll view! Otherwise, the scroll won't work as you expect when the keyboard appears", level: .warn)
        }
    }
        
    @objc
    func keyboardWillHide(_ notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        if let scrollView = scrollView {
            let keyboardRect = keyboardValue.cgRectValue
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height - keyboardRect.height)
        }
    }
}
