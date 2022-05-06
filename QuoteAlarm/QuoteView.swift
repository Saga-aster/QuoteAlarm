//
//  QuoteView.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/02/13.
//

import UIKit
import Alamofire

class QuoteViewController: UIViewController {

    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!

    var quotes = [Quote]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchQuotes()

    }

    func fetchQuotes() {
        // Alamofireリクエスト
        AF.request("https://meigen.doodlenote.net/api/json.php")
            .responseJSON { response in
                let decoder = JSONDecoder()

                do {

                    self.quotes = try decoder.decode([Quote].self, from: response.data!)
                    print("Quote: \(self.quotes)")
                    self.quoteTextView.text = self.quotes[0].meigen
                    self.authorLabel.text = self.quotes[0].auther

                } catch  {

                    print("失敗しました")

                }
            }
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}