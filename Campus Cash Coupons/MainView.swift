//
//  MainView.swift
//  Campus Cash Coupons
//
//  Created by Tyler Jordan Cagle on 8/3/17.
//  Copyright © 2017 COAD. All rights reserved.
//

import UIKit
import PureLayout

class MainView: UIView {
    
    var mainViewController = ViewController()
    var bottomBarImage: UIButton!
    
    private var searchBar: UISearchBar!
    private var searchButton: UIButton!
    private var resultsTable: UITableView!
    private var searchBarTop = false
    private var searchButtonWidthConstraint: NSLayoutConstraint?
    private var searchButtonEdgeConstraint: NSLayoutConstraint?
    
    private let searchButtonHeight: CGFloat = 46
    private let searchButtonWidth: CGFloat = 350
    
    private let searchBarStartingAlpha: CGFloat = 0
    private let searchButtonStartingAlpha: CGFloat = 1
    private let tableStartingAlpha: CGFloat = 0
    private let searchBarEndingAlpha: CGFloat = 1
    private let searchButtonEndingAlpha: CGFloat = 0
    private let tableEndingAlpha: CGFloat = 1
    
    private let searchButtonStartingCornerRadius: CGFloat = 20
    private let searchButtonEndingCornerRadius: CGFloat = 0
    
    private var didSetupConstraints = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupBottomBar()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupBottomBar()
    }
    
    // MARK: - Initialization
    
    func setupViews() {
        setupSearchBar()
        setupSearchButton()
        setupResultsTable()
    }
    
    func setupBottomBar() {
        let image = UIImage(named: "bottomBar")
        bottomBarImage = UIButton(type: .custom)
        bottomBarImage.setBackgroundImage(image, for: .normal)
        bottomBarImage.translatesAutoresizingMaskIntoConstraints = false
        bottomBarImage.isUserInteractionEnabled = true
        bottomBarImage.addTarget(self, action: #selector(sendBottomBar), for: .touchDragInside)
        
//        bottomBarImage.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        addSubview(bottomBarImage)
        
        bottomBarImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBarImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBarImage.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomBarImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func  sendBottomBar() {
        mainViewController.viewDidAppear(true)
    }

    
    func setupSearchBar() {
        searchBar = UISearchBar.newAutoLayout()
        searchBar.showsCancelButton = true
        searchBar.alpha = searchBarStartingAlpha
        addSubview(searchBar)
        searchBar.delegate = self
    }
    
    func setupSearchButton() {
        searchButton = UIButton(type: .custom)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
        searchButton.setTitle("Search..", for: .normal)
        searchButton.backgroundColor = UIColor.init(red: 72/255, green: 69/255, blue: 55/255, alpha: 1)
        searchButton.layer.cornerRadius = searchButtonStartingCornerRadius
        searchButton.layer.zPosition = 10
        addSubview(searchButton)
    }
    
    func setupResultsTable() {
        resultsTable = UITableView.newAutoLayout()
        resultsTable.alpha = tableStartingAlpha
        addSubview(resultsTable)
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            searchBar.autoAlignAxis(toSuperviewAxis: .vertical)
            searchBar.autoMatch(.width, to: .width, of: self)
            searchBar.autoPinEdge(toSuperviewEdge: .top)
            
            searchButton.autoSetDimension(.height, toSize: searchButtonHeight)
            searchButton.autoSetDimension(.width, toSize: searchButtonWidth)
            searchButton.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
            searchButton.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor, constant: 50).isActive = true
//            searchButton.autoCenterInSuperview()
         
            
            resultsTable.autoAlignAxis(toSuperviewAxis: .vertical)
            resultsTable.autoPinEdge(toSuperviewEdge: .leading)
            resultsTable.autoPinEdge(toSuperviewEdge: .trailing)
            resultsTable.autoPinEdge(toSuperviewEdge: .bottom)
            resultsTable.autoPinEdge(.top, to: .bottom, of: searchBar)
            
            didSetupConstraints = true
        }
        
        searchButtonWidthConstraint?.autoRemove()
        searchButtonEdgeConstraint?.autoRemove()
        
        if searchBarTop {
            searchButtonWidthConstraint = searchButton.autoMatch(.width, to: .width, of: self)
            searchButtonEdgeConstraint = searchButton.autoPinEdge(toSuperviewEdge: .top)
        } else {
            searchButtonWidthConstraint = searchButton.autoSetDimension(.width, toSize: searchButtonWidth)
            searchButtonEdgeConstraint = searchButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        }
        
        super.updateConstraints()
    }
    
    // MARK: - User Interaction
    
    func searchClicked(sender: UIButton!) {
        showSearchBar(searchBar: searchBar)
        bottomBarImage.isHidden = true
    }
    
    // MARK: - Helpers
    
    func showSearchBar(searchBar: UISearchBar) {
        searchBarTop = true
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        
        UIView.animate(withDuration: 0.3,
                                   animations: {
                                    searchBar.becomeFirstResponder()
                                    self.layoutIfNeeded()
        }, completion: { finished in
            UIView.animate(withDuration: 0.2,
                                       animations: {
                                        searchBar.alpha = self.searchBarEndingAlpha
                                        self.resultsTable.alpha = self.tableEndingAlpha
                                        self.searchButton.alpha = self.searchButtonEndingAlpha
                                        self.searchButton.layer.cornerRadius = self.searchButtonEndingCornerRadius
            }
            )
        }
        )
    }
    
    func dismissSearchBar(searchBar: UISearchBar) {
        searchBarTop = false
        
        UIView.animate(withDuration: 0.2,
                                   animations: {
                                    searchBar.alpha = self.searchBarStartingAlpha
                                    self.resultsTable.alpha = self.tableStartingAlpha
                                    self.searchButton.alpha = self.searchButtonStartingAlpha
                                    self.searchButton.layer.cornerRadius = self.searchButtonStartingCornerRadius
        }, completion:  { finished in
            self.setNeedsUpdateConstraints()
            self.updateConstraintsIfNeeded()
            UIView.animate(withDuration: 0.3,
                                       animations: {
                                        searchBar.resignFirstResponder()
                                        self.layoutIfNeeded()
            }
            )
        }
        )
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

extension MainView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        dismissSearchBar(searchBar: searchBar)
        bottomBarImage.isHidden = false
    }
}




