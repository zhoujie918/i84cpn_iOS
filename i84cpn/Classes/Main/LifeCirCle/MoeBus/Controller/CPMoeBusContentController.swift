//
//  CPMoeBusContentController.swift
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/6/13.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CPMoeBusContentController: UICollectionViewController {

    var isFirstPage = false
    var isGotData = false
    var cciId : Int = 0  //漫画集id
    var dataSource = CPMoeBusModel()
    
    init(){
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = WIDTH_DYNAMIC(20)
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-WIDTH_DYNAMIC(70))/4, (SCREEN_WIDTH-WIDTH_DYNAMIC(70))/4*1.618)
//        layout.minimumInteritemSpacing = width
//        layout.minimumLineSpacing = width
        layout.sectionInset = UIEdgeInsetsMake(width, WIDTH_DYNAMIC(15), width, WIDTH_DYNAMIC(15))
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let nib = UINib.init(nibName: "CPMoeBusCotentCell", bundle: NSBundle.mainBundle())
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = Constants.paleBGColor
        
        if isFirstPage == true{
            self.getData()
        }
    }

    override func viewWillAppear(animated: Bool) {
        if isGotData == false{
            self.getData()
        }
    }
    
    
    func getData() {
        weak var weakSelf = self
        CPMoeBusModel.getComicChapData(cciId, successClosure: { (success) in
            
            weakSelf!.dataSource = success!
            weakSelf!.collectionView?.reloadData()
            if weakSelf!.dataSource.list != nil{
                weakSelf!.isGotData = true  //取得数据后不再每次进来都刷新
            }
            }) { (fail) in
                print(fail)
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataSource.list == nil{
            return 0
        }
        return (dataSource.list?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : CPMoeBusCotentCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CPMoeBusCotentCell
        cell.title.text = dataSource.list![indexPath.item].cccName
        cell.imgV.sd_setImageWithURL(Constants.getSDWebImageURLWithImageName(dataSource.list![indexPath.item].img!), placeholderImage: UIImage(named: "comicDefaultCover"))
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let comicVC = CPComicController()
        comicVC.url = dataSource.list![indexPath.item].url
        comicVC.title = dataSource.list![indexPath.item].cccName
        self.navigationController?.pushViewController(comicVC, animated: true)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}