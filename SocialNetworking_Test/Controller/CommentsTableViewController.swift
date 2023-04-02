//
//  CommentsTableViewController.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 27.03.2023.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    @IBOutlet var commentsTableView: UITableView!
    
    var postId = 0
    
    var comments: [Comment] = [] {
        didSet {
            commentsTableView.reloadData()
        }
    }
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
//        commentsTableView.estimatedRowHeight = 200
//        commentsTableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: "CommentsTableViewCell", bundle: nil)
        commentsTableView.register(nib, forCellReuseIdentifier: "CommentsCellID")
        commentsTableView.autoresizingMask = [.flexibleHeight]
        
        

        
        networkManager.getCommentsByPost(postId: postId){ comments in
            DispatchQueue.main.async {
                self.comments = comments
                
            }
        }

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.title = "Comments"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCellID", for: indexPath) as! CommentsTableViewCell
        
//        if cell == nil {
//            cell = (Bundle.main.loadNibNamed("CommentsTableViewCell", owner: self)?.first as? CommentsTableViewCell)!
//        }
//
        cell.configureCommentCell(comments[indexPath.row])

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
