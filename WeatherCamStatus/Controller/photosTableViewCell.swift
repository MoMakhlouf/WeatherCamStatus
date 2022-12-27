//
//  photosTableViewCell.swift
//  WeatherCamStatus
//
//  Created by Mohamed Makhlouf Ahmed on 19/11/2022.
//

import UIKit

class photosTableViewCell: UITableViewCell {

    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    var clickShare: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusImage.layer.cornerRadius = 12
        shareButton.clipsToBounds = true
        shareButton.layer.cornerRadius = shareButton.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
       clickShare?()
    }
    
    
    func getStatusList (_ s : Status){
        cityName.text = s.city
        descLabel.text = s.weatherStatus
        tempLabel.text =  "\(s.degree) °C"
       // statusImage.image = s.photo

       
        statusImage!.image = UIImage(data: s.photo!)
        
    }
}
