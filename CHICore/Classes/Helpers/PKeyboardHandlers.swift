//
// Created by Igors Nemenonoks on 21/04/16.
// Copyright (c) 2016 Chili. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

public protocol PKeyboardObservable {
    var keyboardNotificationsObserver: EventBusObserver {get set}
    func onKeyboardAppear(handler:@escaping ((CGRect) -> Void))
    func onKeyboardDissappear(handler:@escaping () -> Void)
}

extension PKeyboardObservable where Self : UIViewController {
    public func onKeyboardAppear(handler:@escaping ((CGRect) -> Void)) {
        _ = self.keyboardNotificationsObserver.addObserver(
            forName: NSNotification.Name.UIKeyboardWillShow,
            object: nil,
            queue: OperationQueue.main
        ) { (notification) in
            let value: NSValue = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
            let keyboardFrame: CGRect = value.cgRectValue
            handler(keyboardFrame)
        }
    }

    public func onKeyboardDissappear(handler:@escaping () -> Void) {
        let notificationName = NSNotification.Name.UIKeyboardWillHide
        _ = self.keyboardNotificationsObserver.addObserver(forName: notificationName, object: nil, queue: OperationQueue.main) { _ in
            handler()
        }
    }
}
