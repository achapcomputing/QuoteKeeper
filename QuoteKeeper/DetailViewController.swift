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
	
	var quoteInfo = QuoteInfo()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		quoteLabel.text = quoteInfo.quote
		sourceLabel.text = quoteInfo.source
		titleLabel.text = quoteInfo.title
		pageLabel.text = quoteInfo.pageNum
        // Do any additional setup after loading the view.
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is AddViewController {
			let addVC = segue.destination as? AddViewController
			//addVC?.quoteInfo = sender as! QuoteInfo
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
