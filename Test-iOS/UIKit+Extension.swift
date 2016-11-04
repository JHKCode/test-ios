//
//  UIKit+Extension.swift
//  Picks
//
//  Created by Jinhong Kim on 10/26/16.
//  Copyright © 2016 JHK. All rights reserved.
//

import UIKit


protocol ReusableView: class {
}


extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


protocol NibLoadable: class {
}


extension NibLoadable where Self: UIView  {
    static var NibName: String {
        return String(describing: self)
    }
}


extension NibLoadable where Self: UIViewController {
    static var NibName: String {
        return String(describing: self)
    }
}


extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadable {
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}


extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadable {
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}


extension UIViewAnimationOptions {
    init(animationCurve: UIViewAnimationCurve) {
        var option: UIViewAnimationOptions
        
        switch animationCurve {
        case UIViewAnimationCurve.easeInOut:
            option = UIViewAnimationOptions.curveEaseInOut
        case UIViewAnimationCurve.easeIn:
            option = UIViewAnimationOptions.curveEaseIn
        case UIViewAnimationCurve.easeOut:
            option = UIViewAnimationOptions.curveEaseOut
        case UIViewAnimationCurve.linear:
            option = UIViewAnimationOptions.curveLinear
        }
        
        self = option
    }
}


extension UIViewController {
    convenience init?<T: UIViewController>(_: T.Type) where T: NibLoadable {
        self.init(nibName: T.NibName, bundle: nil)
    }
    
    
    static func make<T: UIViewController>(storyboardName: String = "Main") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
