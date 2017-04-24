//
//  ViewController.swift
//  PCBuilderGuide
//
//  Created by u0939404 on 4/7/17.
//  Copyright © 2017 Fenn/Phelps. All rights reserved.
//

import UIKit

class UserBuildsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BuildInterfaceViewControllerDelegate {
    
    private var _partsList: PartsList = PartsList.Instance
    private var _userBuilds: UserBuilds = UserBuilds.Instance

    private var contentView: UITableView! { return view as! UITableView }
    
    private var numOfBuilds = 0
    
    override func loadView() {
        super.loadView()
        
        
        
        let userBuildTableView: UITableView  = UITableView()
        
        view = userBuildTableView
        
        _userBuilds.loadBuilds()
        _partsList.loadParts()
        
        contentView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Builds"
        

        let newBuildButton = UIBarButtonItem(title: "New Build", style: .plain, target: self, action: #selector(newBuildClicked))
        self.navigationItem.rightBarButtonItem = newBuildButton
        
        
        contentView.dataSource = self
        contentView.delegate = self
        
        contentView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _userBuilds.getNumberOfBuilds()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                // Never fails:
                return UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        
        
        var title: String
        if (_userBuilds.getBuildAt(index: indexPath.row).buildTitle == "") {
            title = "User build \(indexPath.row)"
        }
        else {
            title = _userBuilds.getBuildAt(index: indexPath.row).buildTitle /* Data from user builds */
        }
        
        cell.textLabel?.text = title
        
        
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userParts: [MyParts] = _userBuilds.getPartsOfBuild(buildIndex: indexPath.item)
        let userTitle: String = _userBuilds.getTitleOfBuild(buildIndex: indexPath.item)
        
        let userBuild = _userBuilds.getBuildAt(index: indexPath.item)
        
        let buildInterfaceViewController: BuildInterfaceViewController = BuildInterfaceViewController(build: userBuild)
        
        buildInterfaceViewController.delegate = self
        
        navigationController?.pushViewController(buildInterfaceViewController, animated: true)
    }
    
    
    func saveBuilds() {
        print("in tableview save the builds")
        _userBuilds.saveBuilds()
    }
    
    
    
    @objc private func newBuildClicked() {
        print("New Build was clicked")
        numOfBuilds = numOfBuilds + 1
        _userBuilds.createBuild()
        contentView.reloadData()
    }
}

