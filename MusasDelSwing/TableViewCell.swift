//
//  TableViewCell.swift
//  MusasDelSwing
//
//  Created by Fernando Haro Martínez on 16/11/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var apodo: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fondo: UIImageView!
    @IBOutlet weak var fecha: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
