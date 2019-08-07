//
//  DetailViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/22/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet weak var quoteLabel: UILabel!
	@IBOutlet weak var sourceLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var pageLabel: UILabel!
	
	@IBAction func shareButtonTouched(_ sender: Any) {
		let activityViewController = UIActivityViewController(activityItems: [quoteLabel.text!, sourceLabel.text!], applicationActivities: nil)
		present(activityViewController, animated: true, completion: nil)
	}
	
	var selectedQuote: Quote? = Quote()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		quoteLabel.text = selectedQuote?.quote
		sourceLabel.text = selectedQuote?.source
		//titleLabel.text = selectedQuote.title
		//pageLabel.text = selectedQuote.pageNum

    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is AddViewController {
			let _ = segue.destination as? AddViewController // _ is addVC
			//addVC?.selectedQuote = sender as! Quote
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

}
