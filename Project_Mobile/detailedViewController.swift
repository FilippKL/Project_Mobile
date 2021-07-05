//
//  detailedViewController.swift
//  Project_Mobile
//
//  Created by Filipp Krupnov on 30/6/21.
//

import UIKit

class detailedViewController: UIViewController {
    var userN: String = ""
    var words1 : String = ""
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var issuesCount: UILabel!
    @IBAction func buttonUpdateInfo(_ sender: Any) {
        stars.text = "\(sumStar)"
        issuesCount.text = "\(sumIssues)"
    }
    
    override func viewDidLoad() {
        requestData()
//        requestDataImage()
        userName?.text = words1
        print("\(userN) username" )

    }
    var sumStar : Int = 0
    var sumIssues: Int = 0
    
//    func requestDataImage() {
//        let urlComponents = URLComponents(string: "https://api.github.com/users/\(words1)")
//        let wordsRequest = URLRequest(url: urlComponents!.url!)
//        let sharedSession = URLSession.shared
//        let wordTask = sharedSession.dataTask(with: wordsRequest) { [self] (data, response, error) in
//            if let data = data,
//               let response = response as? HTTPURLResponse,
//               (200..<300) ~= response.statusCode,
//               error == nil,
//               let requestedWord = try? JSONDecoder().decode([owner].self, from: data){
//                print("\(requestedWord) url image")
//
//                }
//        }
//        wordTask.resume()
//    }
    
    func requestData() {
        let urlComponents = URLComponents(string: "https://api.github.com/users/\(words1)/repos")
        let wordsRequest = URLRequest(url: urlComponents!.url!)
    
        
        let sharedSession = URLSession.shared
        
        let wordTask = sharedSession.dataTask(with: wordsRequest) { [self] (data, response, error) in
            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<300) ~= response.statusCode,
               error == nil,
               let requestedWord = try? JSONDecoder().decode([Request].self, from: data){
//                print(requestedWord)
                sumStar = requestedWord.map({ $0.stargazers_count }).reduce(0, +)
                sumIssues = requestedWord.map({ $0.open_issues_count }).reduce(0, +)
//                print("\(sumStar) stars")
//                print("\(sumIssues) issues")
                        }
        }
        wordTask.resume()
    }
}
