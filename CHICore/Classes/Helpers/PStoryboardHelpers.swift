//
//  PStoryboardHelpers.swift
//  Hippo
//
//  Created by Igors Nemenonoks on 29/11/16.
//  Copyright © 2016 Chili. All rights reserved.
//

import UIKit

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

public protocol PStoryBoard {
    func name() -> String
}

public extension UIStoryboard {
    
    convenience init(storyboard: PStoryBoard, bundle: Bundle? = nil) {
        self.init(name: storyboard.name(), bundle: bundle)
    }

    public func instantiateViewController<T: UIViewController>() -> T {
        let storyBoardId = String(describing: T.self)
        let optionalViewController = self.instantiateViewController(withIdentifier: storyBoardId)

        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate view controller with identifier \(storyBoardId) ")
        }

        return viewController
    }

    public func instantiateInitialViewController<T: UIViewController>() -> T {
        let optionalViewController = self.instantiateInitialViewController()
        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate initial view controller")
        }
        return viewController
    }
}
