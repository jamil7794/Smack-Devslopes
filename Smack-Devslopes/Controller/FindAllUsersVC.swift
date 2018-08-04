//
//  FindAllUsersVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/28/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class FindAllUsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AuthService.instance.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as? UsersCell {
            let user = AuthService.instance.users[indexPath.row]
            cell.configureCell(user: user)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
