//
//  AddViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/21/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var presetButton: UIButton!
	@IBOutlet weak var sourceLabel: UILabel!
	@IBOutlet weak var sourceText: UITextField!
	@IBOutlet weak var bookLabel: UILabel!
	@IBOutlet weak var bookSwitch: UISwitch!
	@IBOutlet weak var pageLabel: UILabel!
	@IBOutlet weak var pageText: UITextField!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var titleText: UITextField!
	
	@IBAction func presetButtonTouch(_ sender: Any) {
	}
	// changes display based off the quote is from a book
	@IBAction func bookSwitchChanged(_ sender: Any) {
		// quote is from a book, prompt for title and page number
		if bookSwitch.isOn {
			pageLabel.isHidden = false
			pageText.isHidden = false
			titleLabel.isHidden = false
			titleText.isHidden = false
		}
		// quote is not from a book, remove title and page number prompts
		else {
			pageLabel.isHidden = true
			pageText.isHidden = true
			titleLabel.isHidden = true
			titleText.isHidden = true
		}
	}
	
	
	@IBOutlet weak var dateLabel: UILabel!
	
	// shares the quote and source
	@IBAction func shareQuote(_ sender: Any) {
		let activityViewController = UIActivityViewController(activityItems: [textView.text!, sourceLabel.text!], applicationActivities: nil)
		present(activityViewController, animated: true, completion: nil)
	}
	
	var quoteInfo = QuoteInfo()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addDate()
		//updateInfo()
		sourceText.delegate = self
		pageText.delegate = self
		titleText.delegate = self
		
		if quoteInfo.quote != "quote" {
			//quoteLabel.text = quoteInfo.quote
			sourceLabel.text = quoteInfo.source
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
