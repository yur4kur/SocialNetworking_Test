//
//  CommentsTableViewController.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 27.03.2023.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    @IBOutlet var commentsTableView: UITableView!
    
    let newComment = "In vino veritas"
    
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
        
        let nib = UINib(nibName: "CommentsTableViewCell", bundle: nil)
        commentsTableView.register(nib, forCellReuseIdentifier: "CommentsCellID")
    
        networkManager.getCommentsByPost(postId: postId){ comments in
            DispatchQueue.main.async {
                self.comments = comments
            }
        }

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.title = "Comments"
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func didTapAddComment(_ sender: Any) {
        
        var comment = Comment(postId: postId, id: 0, name: "", email: "", body: newComment)
        
        networkManager.createComment(comment) { serverComment in
            comment.id = serverComment.id
            DispatchQueue.main.async {
                self.comments.append(serverComment)
                print(comment.id)
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCellID", for: indexPath) as! CommentsTableViewCell
        
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

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            networkManager.deleteComment(comments[indexPath.row]) { wipedComment in
                DispatchQueue.main.async {
                    print(wipedComment.id)
                    print(self.comments.count)
                }
            }
            self.comments.remove(at: indexPath.row)

        }
    }
   

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
