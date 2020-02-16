//
//  UIViewStyle.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/16/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import UIKit

typealias UIViewStyleHandler<T: UIView> = (T) -> Void

struct UIViewStyle<T: UIView> {
    let styling: UIViewStyleHandler<T>
}

extension UIViewStyle {
    static func compose(_ styles: UIViewStyle<T>...) -> UIViewStyle<T> {
        return UIViewStyle { view in
            for style in styles {
                style.styling(view)
            }
        }
    }
    
    func apply(to view: T) {
        styling(view)
    }
}
