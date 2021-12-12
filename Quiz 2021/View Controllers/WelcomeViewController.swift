//
//  WelcomeViewController.swift
//  Quiz 2021
//
//  Created by noone on 12/6/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting image as subview
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = .flexibleWidth
        imageView.image = UIImage(named: "заставка.jpeg")
        view.insertSubview(imageView, at: 0)
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        print(#line, #function)
    }
}

