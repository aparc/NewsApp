//
//  UIViewController+ActivityIndicator.swift
//  NewsApp
//
//  Created by Андрей on 13.08.2022.
//

import UIKit


fileprivate var activityView: UIView?

extension UIViewController {
	
	func showActivityIndicator() {
		activityView = UIView(frame: self.view.bounds)
		guard let containerView = activityView else { return }
		
		let ai = UIActivityIndicatorView(style: .medium)
		ai.hidesWhenStopped = true
		ai.center = containerView.center
		ai.startAnimating()
		
		containerView.addSubview(ai)
		view.addSubview(containerView)
	}
	
	func removeActivityIndicator() {
		activityView?.removeFromSuperview()
		activityView = nil
	}
	
}
