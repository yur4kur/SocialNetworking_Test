//
//  ViewController.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 12.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
