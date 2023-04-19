//
//  PostsTableViewController.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 23.03.2023.
//

import UIKit

class PostsTableViewController: UITableViewController {
    
    @IBOutlet var postsTableView: UITableView!
    
    var userId = 0
    
    var newPostTitle = "Si vic pacem para belum"
    var newPostBody = "Veni vidi vici"
    
    var posts: [Post] = [] {
        didSet {
            print(posts.count)
            postsTableView.reloadData()
        }
    }
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        postsTableView.register(nib, forCellReuseIdentifier: "PostCellID")

        
        networkManager.getPostsByUser(userId: userId) { posts in
            DispatchQueue.main.async {
                self.posts = posts
            }
        }
        
        self.clearsSelectionOnViewWillAppear = true
        self.navigationItem.title = "Posts"
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func didTapAddPost(_ sender: Any) {
        
        var post = Post(userId: userId, id: 0, title: newPostTitle, body: newPostBody)
        
        networkManager.createPost(post) { serverPost in
            post.id = serverPost.id
            DispatchQueue.main.async {
                self.posts.append(serverPost)
                print(serverPost.id)
                
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID", for: indexPath) as! PostTableViewCell
        
        cell.configurePostCell(posts[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsTableViewController") as? CommentsTableViewController {
            vc.postId = posts[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Delete cell method.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            networkManager.deletePost(posts[indexPath.row]) { deletedPost in
                DispatchQueue.main.async {
                    print(deletedPost.id)
                }
            }
            self.posts.remove(at: indexPath.row)
            
       }
//             else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
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
