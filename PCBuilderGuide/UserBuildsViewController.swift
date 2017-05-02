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
        
        _partsList.loadParts()
        
        _partsList.loadCustomParts()
        
        _userBuilds.loadBuilds()
        
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.deleteBuild(index: indexPath.row)
        }
        delete.backgroundColor = UIColor.red
        
        let rename = UITableViewRowAction(style: .normal, title: "Rename") {action , index in
            self.renameBuild(index: indexPath.row)
        }
        
        
        return [delete, rename]
    }
    
    
    func deleteBuild(index: Int) {
        
        // Have an alert to make sure they actually want to delete it
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this build?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            self._userBuilds.deleteBuild(index: index)
            self._userBuilds.saveBuilds()
            self.contentView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func renameBuild(index: Int) {
        let alertController = UIAlertController(title: "", message: "Please enter a name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                // store your data
                UserDefaults.standard.set(field.text, forKey: "saveBuild")
                UserDefaults.standard.synchronize()
                self._userBuilds.getBuildAt(index: index).buildTitle = field.text!
                self._userBuilds.saveBuilds()
                self.contentView.reloadData()
            } else {
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    func saveBuilds() {
        _userBuilds.saveBuilds()
        
    }
    
    
    
    @objc private func newBuildClicked() {
        numOfBuilds = numOfBuilds + 1
        _userBuilds.createBuild()
        contentView.reloadData()
    }
}

