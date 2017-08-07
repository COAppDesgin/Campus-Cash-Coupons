//
//  ViewController.swift
//  Campus Cash Coupons
//
//  Created by Tyler Jordan Cagle on 8/2/17.
//  Copyright © 2017 COAD. All rights reserved.
//

import UIKit
import PureLayout

class ViewController : UIViewController {
    
    @IBOutlet weak var bottomBarTab: UIImageView!
    private var mainView: MainView!
    private var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainView = MainView.newAutoLayout()
        view.addSubview(mainView)
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Layout
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            mainView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
            mainView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
            mainView.autoPinEdge(toSuperviewEdge: .leading)
            mainView.autoPinEdge(toSuperviewEdge: .trailing)
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    func categoriesIconSlide() {
        let categoriesController = CategoriesTableViewController()
        let navController = UINavigationController(rootViewController: categoriesController)
        present(navController, animated: true, completion: nil)
    }
    
}
















