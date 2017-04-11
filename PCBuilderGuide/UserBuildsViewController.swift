//
//  ViewController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/7/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class UserBuildsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var _partsList: PartsList = PartsList.Instance

    private var contentView: UITableView! { return view as! UITableView }
    
    private var numOfBuilds = 0
    
    override func loadView() {
        super.loadView()
        
        let userBuildTableView: UITableView  = UITableView()
        
        view = userBuildTableView
        
        _partsList.loadParts()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Builds"
        

        let newBuildButton = UIBarButtonItem(title: "New Build", style: .plain, target: self, action: #selector(newBuildClicked))
        self.navigationItem.rightBarButtonItem = newBuildButton
        
        
        contentView.dataSource = self
        contentView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfBuilds
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                // Never fails:
                return UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        
        cell.textLabel?.text = "User build \(indexPath.row)" /* Data from user builds */
        
        
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buildInterfaceViewController: BuildInterfaceViewController = BuildInterfaceViewController()
        
        navigationController?.pushViewController(buildInterfaceViewController, animated: true)
    }
    
    
    
    
    @objc private func newBuildClicked() {
        print("New Build was clicked")
        numOfBuilds = numOfBuilds + 1
        contentView.reloadData()
    }
}

