//
//  AddViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/21/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var presetButton: UIButton!
	@IBOutlet weak var sourceLabel: UILabel!
	@IBOutlet weak var sourceText: UITextField!
	@IBOutlet weak var pageLabel: UILabel!
	@IBOutlet weak var pageText: UITextField!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var titleText: UITextField!
	@IBOutlet weak var characterLabel: UILabel!
	@IBOutlet weak var characterText: UITextField!
	
	@IBAction func saveButtonTouched(_ sender: Any) {
		
		let quote = textView.text
		let source = sourceText.text
		
		let medium = titleText.text
		let char = characterText.text
		let pageNum = pageText.text
		
		let fstore = Firestore.firestore()
		var ref: DocumentReference? = nil
		var docID: String = "-1"
		
		ref = fstore.collection("quotes").addDocument(data: ["quote" : quote ?? "", "source" : source ?? ""]) { err in
			if let err = err {
				print("Error adding document: \(err)")
			} else {
				docID = ref!.documentID
				print("quote document added with ID: \(docID)")
				
				// Add the extra info about the quote
				fstore.collection("quotes-info").document("info-\(docID)").setData(["medium" : medium ?? "", "char" : char ?? "", "page-num" : pageNum ?? ""]) { err in
					if let err = err {
						print("Error adding document: \(err)")
					} else {
						print("quotes-info document added with ID: \(docID)")
					}
				}
			}
		}
		print("Saved")
	}
	
	@IBAction func presetButtonTouch(_ sender: Any) {
	}
	
	
	@IBOutlet weak var dateLabel: UILabel!
	
	// shares the quote and source
	@IBAction func shareQuote(_ sender: Any) {
		let activityViewController = UIActivityViewController(activityItems: [textView.text!, sourceLabel.text!], applicationActivities: nil)
		present(activityViewController, animated: true, completion: nil)
	}
	
	var quoteInfo = QuoteInfo()
	///var quote = Quote()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addDate()
		//updateInfo()
		sourceText.delegate = self
		pageText.delegate = self
		titleText.delegate = self
		
		if quoteInfo.title != "title" {
			titleLabel.text = quoteInfo.title
			pageLabel.text = quoteInfo.pageNum
		}
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
		return false
	}

	// gets current date for when quote was added
	func addDate() {
		let date = Date() // gets current date
		let format = DateFormatter()
		format.dateFormat = "MM/dd/yy" // determines the date format
		let formattedDate = format.string(from: date) // formats the date
		dateLabel.text = "Date Added: \(formattedDate)" // sets label in UI
	}
	

	
}
