//
//  ViewController.swift
//  Chicking
//
//  Created by sreenima95 on 17/05/20.
//  Copyright © 2020 sreenima95. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    struct BannerDetail: Codable {
        var image: String
    }
    
    var bannerImageArray = [String]()
    var bannerLblArray = [String]()
    var categoriesIDArray = [Int]()
    var foodLblArray = [String]()
    var foodImageArray = [String]()
    var foodPriceArray = [String]()
    var imageTimer  = Timer()
    var counter = 0
    var selectedID = 0
    var highlightedButtonIndex = 0
    
    var vSpinner : UIView?
    
    var activityView: UIActivityIndicatorView?
    var visibleIndexPath: IndexPath? = nil

    @IBOutlet weak var bannerLabelCV: UICollectionView!
    @IBOutlet weak var bannerImageCV: UICollectionView!
    
    @IBOutlet weak var foodCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        selectedID = 7
        Load_bannerImageMethod()
        Load_bannerLblMethod()
        Load_foodCVMethod()
        
        
        
        DispatchQueue.main.async {


            self.imageTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector:#selector(self.changeImage), userInfo: nil, repeats: true)


        }
        
    }
    
    
    
    @objc func changeImage()
    {
        
        if counter < bannerImageArray.count{
            let index = IndexPath.init(item:counter, section:0)
            self.bannerImageCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item:counter, section:0)
            self.bannerImageCV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            counter = 1
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerImageCV{
            
            print("bannerImageArray.count = \(bannerImageArray.count)")
            return bannerImageArray.count
            
        }
        else if collectionView == bannerLabelCV{
            return bannerLblArray.count
        }else if collectionView == foodCV{
            return foodLblArray.count
        }else{
            return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == bannerImageCV{

            let noOfCellsInRow = 1

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((bannerImageCV.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
        else if collectionView == foodCV{

            let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size)

        }
        else{
            let noOfCellsInRow = 4

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((bannerLabelCV.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size)

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerImageCV{
            
            let cell: bannerCVcell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath)as! bannerCVcell

            cell.bannerImage.image = UIImage(url: URL(string: "https://mobileapp.chickinguae.com/images/banners/\(bannerImageArray[indexPath.row])"))

            cell.bannerImage.layer.borderColor = UIColor.clear.cgColor
            cell.bannerImage.layer.borderWidth = 0.1
            cell.bannerImage.layer.cornerRadius = 8 // optional

            cell.bannerImage.layer.masksToBounds = false

            return cell
            
        }else if collectionView == bannerLabelCV{
            
            let cell: bannerLabelCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerLblCell", for: indexPath)as! bannerLabelCVCell
            
            if(indexPath.row == self.highlightedButtonIndex) {
                cell.bannerLblView.backgroundColor = UIColor(hexFromString: "B10903")
                cell.bannerLbel.textColor = UIColor.white
            }else{
                cell.bannerLblView.backgroundColor = UIColor.white
                cell.bannerLbel.textColor = UIColor.darkGray
            }
            cell.bannerLbel.text = bannerLblArray[indexPath.row]
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 0.1
            cell.layer.cornerRadius = 8 // optional
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
            cell.layer.shadowRadius = 0.2
            cell.layer.shadowOpacity = 0.2
            cell.layer.masksToBounds = false
            return cell
        }else {
            
            let cell: foodCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath)as! foodCVCell
            cell.foodImage.image = UIImage(url: URL(string: "https://mobileapp.chickinguae.com/images/cakes/\(foodImageArray[indexPath.row])"))
            cell.foodCostLbl.text = foodPriceArray[indexPath.row]
            cell.foodLbl.text = foodLblArray[indexPath.row]
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 0.1
            cell.layer.cornerRadius = 8 // optional
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
            cell.layer.shadowRadius = 0.2
            cell.layer.shadowOpacity = 0.2
            cell.layer.masksToBounds = false
            cell.addChart.roundCorners(topLeft: 20, topRight: 10, bottomLeft: 10, bottomRight: 20)
            return cell
        }
    }
    

    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if collectionView == bannerLabelCV{
            self.showSpinner(onView: self.view)
            let indexPaths = self.bannerLabelCV.indexPathsForSelectedItems!
            print(indexPaths)
            let indexPath = indexPaths[0] as NSIndexPath
            
            self.highlightedButtonIndex = indexPath.row
            
            
            var passingNumber = 0
            passingNumber = categoriesIDArray[indexPath.row]
            print("passingNumber = \(passingNumber)")
            selectedID = passingNumber
            
            
            foodImageArray.removeAll()
            foodLblArray.removeAll()
            foodPriceArray.removeAll()
            self.Load_foodCVMethod()
            
            self.bannerLabelCV.reloadData()
            self.foodCV.reloadData()
            
            
        }
        
        
    }
    
    
    func Load_bannerImageMethod(){
        
        
        //create the url with NSURL
        let url = URL(string: "https://mobileapp.chickinguae.com/index.php/api/banners/cake")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        //create dataTask using the session object to send data to the server
        self.showSpinner(onView: self.view)
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    
                    
                    
                    
                    if json != nil{
                        
                        let imageArray = json["data"]
                        
                        if  let object = imageArray as? [Any] {
                            for anItem in object as! [Dictionary<String, AnyObject>] {
                                var imageName = ""
                                imageName = anItem["image"] as? String ?? ""
                                
                                self.bannerImageArray.append(imageName)
                                    
                            }
                        } else {
                            print("JSON is invalid")
                        }
                        
                    }
                    
                    DispatchQueue.main.async { // Correct
                        
                        self.bannerImageCV.reloadData()
                        
                    }
                    
                    
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
    
    
    
    
    func Load_bannerLblMethod(){
        
        //create the url with NSURL
        let url = URL(string: "https://mobileapp.chickinguae.com/index.php/api/listAllCakeCategory")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        //create dataTask using the session object to send data to the server
        
        //        self.showSpinner(onView: self.view)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
           
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    
                    
                    
                    
                    if json != nil{
                        
                        let LabelArray = json["data"]
                        
                        if  let object = LabelArray as? [Any] {
                            for anItem in object as! [Dictionary<String, AnyObject>] {
                                var LblName = ""
                                LblName = anItem["title"] as? String ?? ""
                                self.bannerLblArray.append(LblName)
                                var categoriesID = 0
                                categoriesID = anItem["id"] as? Int ?? 0
                                self.categoriesIDArray.append(categoriesID)
                                
                                
                            }
                        } else {
                            print("JSON is invalid")
                        }
                        
                    }

                    
                    DispatchQueue.main.async { // Correct
                        
                        print("categoriesIDArray =\(self.categoriesIDArray)")
                        
                        self.bannerLabelCV.reloadData()
                        
                    }
                    
                    
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
    func Load_foodCVMethod(){
        
        //create the url with NSURL
        let url = URL(string: "https://mobileapp.chickinguae.com/index.php/api/listCakesByCategory/\(selectedID)")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        //create dataTask using the session object to send data to the server
        
        
        //               self.showSpinner(onView: self.view)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            self.removeSpinner()
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    
                    
                    
                    
                    if json != nil{
                        
                        let foodArray = json["data"]
                        
                        if  let object = foodArray as? [Any] {
                            for anItem in object as! [Dictionary<String, AnyObject>] {
                                var LblName = ""
                                LblName = anItem["title"] as? String ?? ""
                                //                                    print("imageName = \(LblName)")
                                self.foodLblArray.append(LblName)
                                
                                var FoodImage = ""
                                FoodImage = anItem["image"] as? String ?? ""
                                
                                self.foodImageArray.append(FoodImage)
                                
                                var FoodPrice = ""
                                FoodPrice = anItem["price"] as? String ?? ""
                                self.foodPriceArray.append(FoodPrice)
                                
                                
                            }
                        } else {
                            print("JSON is invalid")
                        }
                        
                    }
                    
                    DispatchQueue.main.async { // Correct
                        
                        self.foodCV.reloadData()
                        
                    }
                    
                    
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
    
    
    
    
    
    
}
class bannerCVcell : UICollectionViewCell{
    
    @IBOutlet weak var bannerImage: UIImageView!
    
}
class bannerLabelCVCell : UICollectionViewCell{
    
    @IBOutlet weak var bannerLbel: UILabel!
    
    @IBOutlet weak var bannerLblView: UIView!
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? UIColor.blue : UIColor.yellow
            self.bannerLblView.alpha = isSelected ? 0.75 : 1.0
        }
    }
}
class foodCVCell : UICollectionViewCell{
    @IBOutlet weak var addChart: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodLbl: UILabel!
    @IBOutlet weak var foodCostLbl: UILabel!
}
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}
extension UIView{
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
extension ViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.clear
        
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        ai.color = UIColor(hexFromString: "B10903")
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.isHidden = true
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
            
            
            
        }
    }
}
