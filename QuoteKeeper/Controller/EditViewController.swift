//
//  EditViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 8/7/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UIViewController {
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var sourceTF: UITextField!
	@IBOutlet weak var mediumTF: UITextField!
	@IBOutlet weak var charTF: UITextField!
	@IBOutlet weak var pageNumTF: UITextField!
    @IBOutlet weak var notesView: UITextView!
    
    
    var selectedQuote: Quote? = Quote()
	var selectedQuoteInfo: QuoteInfo? = QuoteInfo()
	var selectedDocID: String = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()
		print("editQuotes: \(String(describing: selectedQuote?.quote))")
        // Do any additional setup after loading the view.
		setEditLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let quote = textView.text
        let source = sourceTF.text
        let medium = mediumTF.text
        let char = charTF.text
        let pageNum = pageNumTF.text
        let notes = notesView.text
        
        let fstore = Firestore.firestore()
        var ref: DocumentReference? = nil
        print("Saved touched")
        // updates quotes collection
        ref = fstore.collection("quotes").document(selectedDocID)
        ref?.setData(["quote" : quote ?? "", "source" : source ?? ""], merge: true) { err in
            print("HELP")
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("quote document updated with ID: \(self.selectedDocID)")
                
                // updates quotes-info collection
                fstore.collection("quotes-info").document("info-\(self.selectedDocID)").setData(["medium" : medium ?? "", "char" : char ?? "", "page-num" : pageNum ?? "", "notes" : notes ?? ""]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("quotes-info document updated with ID: \(self.selectedDocID)")
                    }
                }
            }
        }
    }
	
	func setEditLabels() {
		textView.text = selectedQuote?.quote
		sourceTF.text = selectedQuote?.source
		mediumTF.text = selectedQuoteInfo?.medium
		charTF.text = selectedQuoteInfo?.char
		pageNumTF.text = selectedQuoteInfo?.pageNum
        notesView.text = selectedQuoteInfo?.notes
	}

}
