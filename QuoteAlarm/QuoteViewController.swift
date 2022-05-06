//
//  QuoteViewController.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/03/26.
//

import UIKit
import Alamofire

class QuoteViewController: UIViewController {

    @IBOutlet private weak var quoteTextView: UITextView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    
    var quotes = [QuoteData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        quoteTextView.isEditable = false
        fetchQuotes()

    }

    func fetchQuotes() {
        // Alamofireリクエスト
        AF.request("https://meigen.doodlenote.net/api/json.php")
            .responseJSON { response in
                let decoder = JSONDecoder()

                do {

                    self.quotes = try decoder.decode([QuoteData].self, from: response.data!)
                    print("Quote: \(self.quotes)")
                    self.quoteTextView.text = self.quotes[0].meigen
                    self.authorLabel.text = self.quotes[0].auther

                } catch  {

                    print("失敗しました")

                }
            }
    }

    @IBAction func back(_ sender: Any) {

        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }

}
