//
//  CellRow.swift
//  TravelBook
//
//  Created by Muhammet Taha Bilecen on 27.10.2021.
//

import UIKit

class CellRow: UITableViewCell {

    @IBOutlet weak var y: UILabel!
    @IBOutlet weak var x: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
