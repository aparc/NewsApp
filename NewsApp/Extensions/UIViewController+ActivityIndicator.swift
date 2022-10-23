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
        activityView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 300))
        
		guard let containerView = activityView else { return }
        
		let ai = UIActivityIndicatorView(style: .medium)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        ai.center = containerView.center
        ai.startAnimating()
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "LOADING"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
		containerView.addSubview(ai)
        containerView.addSubview(label)
        
        ai.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        ai.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: ai.bottomAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
	}
	
	func removeActivityIndicator() {
		activityView?.removeFromSuperview()
		activityView = nil
	}
	
}
