//
//  DetailViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/22/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

	@IBOutlet weak var quoteLabel: UILabel!
	@IBOutlet weak var sourceLabel: UILabel!
	@IBOutlet weak var mediumLabel: UILabel!
	@IBOutlet weak var charLabel: UILabel!
	@IBOutlet weak var pageLabel: UILabel!
	
	@IBAction func shareButtonTouched(_ sender: Any) {
		let activityViewController = UIActivityViewController(activityItems: [quoteLabel.text!, "by",  sourceLabel.text ?? ""], applicationActivities: nil)
		present(activityViewController, animated: true, completion: nil)
	}
	
	var selectedQuote: Quote = Quote()
	var selectedQuoteInfo: QuoteInfo? = QuoteInfo()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadQuoteInfoData()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is EditViewController {
			let editVC = segue.destination as? EditViewController
			editVC?.selectedQuote = selectedQuote
			editVC?.selectedQuoteInfo = selectedQuoteInfo
		}
	}
	
	// for editVC cancelling back to detailVC
	@IBAction func unwindToDetailVC(_ unwindSegue: UIStoryboardSegue) { }

	// TODO: LOAD IN PAGE NUM
	
	func loadQuoteInfoData() {
		var docID = ""
		docID = selectedQuote.docID
		var medium = ""
		var char = ""
		var pageNum = ""
		let fstore = Firestore.firestore()
		var ref: DocumentReference? = nil
		
		ref = fstore.collection("quotes-info").document("info-\(docID)")
		ref?.getDocument { (document, err) in
			if let document = document, document.exists {
				medium = document.data()?["medium"] as? String ?? ""
				char = document.data()?["char"] as? String ?? ""
				pageNum = document.data()?["pageNum"] as? String ?? ""
				self.selectedQuoteInfo = QuoteInfo(medium: medium, char: char, pageNum: pageNum)
				print("detailQuotes: \(self.selectedQuoteInfo)")
				self.setDetailLabels()
			} else {
				print("detailQuotes: Document does not exist")
			}
		}
	}
	
	func setDetailLabels() {
		quoteLabel.text = selectedQuote.quote
		sourceLabel.text = selectedQuote.source
		mediumLabel.text = selectedQuoteInfo?.medium
		charLabel.text = selectedQuoteInfo?.char
		pageLabel.text = selectedQuoteInfo?.pageNum
	}

}
