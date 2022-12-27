//
//  photosListViewController.swift
//  WeatherCamStatus
//
//  Created by Mohamed Makhlouf Ahmed on 19/11/2022.
//

import UIKit

class photosListViewController: UIViewController {
  var statusList = [Status]()
  //  var statusListReversed = statusList.reversed()
  var statusDB = DBManager.sharedInstance
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
    @IBOutlet var emptyView: UIView!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "photosTableViewCell", bundle: nil), forCellReuseIdentifier: "photosCell")
            tableView.rowHeight = 300
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emptyView)
        emptyView.center = view.center
        emptyView.isHidden = true
      //  navigationController?.navigationItem.backBarButtonItem?.tintColor = .white
      //  UITableView.appearance().tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        getStatus()
        tableView.reloadData()
    }
    
    func getStatus(){
        statusList = statusDB.getStatusFromDB(appDelegate: appDelegate)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension photosListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if statusList.isEmpty == true {
            emptyView.isHidden = false
            tableView.isHidden = true
        }
        return statusList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosCell", for: indexPath) as! photosTableViewCell
        cell.getStatusList(statusList.reversed()[indexPath.row])
        
        cell.clickShare = { [weak self] in
            //
            // Setting description
            let firstActivityItem = "Share your photo with "
            
            // Setting url
          //  let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!
            
            // If you want to use an image
            let image : UIImage =  cell.statusImage.image!
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, image], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = (self!.view)
            
            // This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            // Pre-configuring activity items
            activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
            ]
            
            activityViewController.isModalInPresentation = true
            self!.present(activityViewController, animated: true, completion: nil)
            
            
        }
        return cell
    }
    
   
}
    

