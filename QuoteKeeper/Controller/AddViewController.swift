//
//  AddViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/21/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

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
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesText: UITextView!
    
    @IBAction func saveButtonTouched(_ sender: Any) {
        let quote = textView.text
        let source = sourceText.text
          
        let medium = titleText.text
        let char = characterText.text
        let pageNum = pageText.text
        let notes = notesText.text
        
        let fstore = Firestore.firestore()
        var ref: DocumentReference? = nil
        var docID: String = "-1"
          
        ref = fstore.collection("quotes").addDocument(data: [
            "quote" : quote ?? "",
            "source" : source ?? "",
            "uid" : Auth.auth().currentUser?.uid ?? ""
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                docID = ref!.documentID
                ref!.updateData(["docID" : docID])
                print("quote document added with ID: \(docID)")
                  
                // Add the extra info about the quote
                fstore.collection("quotes-info").document("info-\(docID)").setData([
                    "medium" : medium ?? "",
                    "char" : char ?? "",
                    "page-num" : pageNum ?? "",
                    "notes" : notes ?? ""
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("quotes-info document added with ID: info-\(docID)")
                    }
                }
            }
        }
        print("Saved")
        
        //performSegue(withIdentifier: "unwindAddtoAllQVC", sender: nil)
        
    }
    
	var quote = Quote()
	var quoteInfo = QuoteInfo()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		sourceText.delegate = self
		pageText.delegate = self
		titleText.delegate = self
		
		if quoteInfo.medium != "medium" {
			titleLabel.text = quoteInfo.medium
			characterLabel.text = quoteInfo.char
			pageLabel.text = quoteInfo.pageNum
            notesLabel.text = quoteInfo.notes
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
		return false
	}
	
}
