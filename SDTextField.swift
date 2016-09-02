//
//  SDTextField.swift
//
//  The MIT License
//  Copyright (c) 2015 - 2016 Susan Cheng. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public protocol SDTextFieldDelegate : UITextFieldDelegate {
    
    func textFieldKeyboardWillShow(_ textField: SDTextField, animationDuration: Double, animationCurve: UIViewAnimationCurve, startFrame: CGRect, endFrame: CGRect)
    func textFieldKeyboardDidShow(_ textField: SDTextField, frame: CGRect)
    func textFieldKeyboardWillHide(_ textField: SDTextField, animationDuration: Double, animationCurve: UIViewAnimationCurve, startFrame: CGRect, endFrame: CGRect)
    func textFieldKeyboardDidHide(_ textField: SDTextField, frame: CGRect)
    func textFieldKeyboardWillChangeFrame(_ textField: SDTextField, animationDuration: Double, animationCurve: UIViewAnimationCurve, startFrame: CGRect, endFrame: CGRect)
    func textFieldKeyboardDidChangeFrame(_ textField: SDTextField, frame: CGRect)
    
    func textFieldDidChanged(_ textField: SDTextField)
}

public extension SDTextFieldDelegate {
    
    func textFieldKeyboardWillShow(_ textField: SDTextField, animationDuration: Double, animationCurve: UIViewAnimationCurve, startFrame: CGRect, endFrame: CGRect) {
        // do nothing
    }
    func textFieldKeyboardDidShow(_ textField: SDTextField, frame: CGRect) {
        // do nothing
    }
    func textFieldKeyboardWillHide(_ textField: SDTextField, animationDuration: Double, animationCurve: UIViewAnimationCurve, startFrame: CGRect, endFrame: CGRect) {
        // do nothing
    }
    func textFieldKeyboardDidHide(_ textField: SDTextField, frame: CGRect) {
        // do nothing
    }
    func textFieldKeyboardWillChangeFrame(_ textField: SDTextField, animationDuration: Double, animationCurve: UIViewAnimationCurve, startFrame: CGRect, endFrame: CGRect) {
        // do nothing
    }
    func textFieldKeyboardDidChangeFrame(_ textField: SDTextField, frame: CGRect) {
        // do nothing
    }
    
    func textFieldDidChanged(_ textField: SDTextField) {
        // do nothing
    }
}

@objc
open class SDTextField: UITextField {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(_textFieldKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_textFieldKeyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_textFieldKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_textFieldKeyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_textFieldKeyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_textFieldKeyboardDidChangeFrame), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_textFieldDidChanged), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
}

extension SDTextField {
    
    private var _delegate : SDTextFieldDelegate? {
        return self.delegate as? SDTextFieldDelegate
    }
    
    func _textFieldKeyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        guard let startFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        guard let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        if self.isFirstResponder {
            _delegate?.textFieldKeyboardWillShow(self, animationDuration: duration.doubleValue, animationCurve: UIViewAnimationCurve(rawValue: curve.intValue)!, startFrame: startFrame.cgRectValue, endFrame: endFrame.cgRectValue)
        }
    }
    func _textFieldKeyboardDidShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        if self.isFirstResponder {
            _delegate?.textFieldKeyboardDidShow(self, frame: endFrame.cgRectValue)
        }
    }
    func _textFieldKeyboardWillHide(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        guard let startFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        guard let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        if self.isFirstResponder {
            _delegate?.textFieldKeyboardWillHide(self, animationDuration: duration.doubleValue, animationCurve: UIViewAnimationCurve(rawValue: curve.intValue)!, startFrame: startFrame.cgRectValue, endFrame: endFrame.cgRectValue)
        }
    }
    func _textFieldKeyboardDidHide(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        _delegate?.textFieldKeyboardDidHide(self, frame: endFrame.cgRectValue)
    }
    func _textFieldKeyboardWillChangeFrame(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        guard let startFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        guard let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        if self.isFirstResponder {
            _delegate?.textFieldKeyboardWillChangeFrame(self, animationDuration: duration.doubleValue, animationCurve: UIViewAnimationCurve(rawValue: curve.intValue)!, startFrame: startFrame.cgRectValue, endFrame: endFrame.cgRectValue)
        }
    }
    func _textFieldKeyboardDidChangeFrame(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        _delegate?.textFieldKeyboardDidChangeFrame(self, frame: endFrame.cgRectValue)
    }
    
    func _textFieldDidChanged(notification: NSNotification) {
        if self.isFirstResponder {
            _delegate?.textFieldDidChanged(self)
        }
    }
}
