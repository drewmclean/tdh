//
//  NiblessViewController.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import Foundation
import UIKit

open class ViewController : UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported.")
    override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init()
    }

    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported.")
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
