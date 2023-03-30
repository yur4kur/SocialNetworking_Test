//
//  ViewController.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 12.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView! {
        didSet {
            usersTableView.delegate = self
            usersTableView.dataSource = self
            
            let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
            usersTableView.register(nib, forCellReuseIdentifier: "UserCellID")
            
        }
    }
    
    var users: [User] = [] {
        didSet {
            usersTableView.reloadData()
        }
    }
     
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getAllUser { users in
            DispatchQueue.main.async {
                self.users = users
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellID", for: indexPath) as! UserTableViewCell
        cell.configureUserCell(users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostsTableViewController") as? PostsTableViewController {
            vc.userId = users[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
