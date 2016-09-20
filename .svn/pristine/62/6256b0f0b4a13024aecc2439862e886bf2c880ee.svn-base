//
//  CPSuggestionsViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/20.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPSuggestionsViewController: CMBaseViewController, UITableViewDataSource, UITableViewDelegate, SuggestionsLoadDataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "意见反馈"
        view.addSubview(suggestionsView)
        
        suggestionsView.frame = view.frame
        suggestionsView.tableView.registerNib(UINib(nibName: "CPSuggesstionsTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
////        suggestionsView.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
////            self.suggestionModel.getLineList()
////        })
//        let footer = MJRefreshBackStateFooter.init(refreshingBlock: {
//            self.suggestionModel.getLineList()
//        })
//        footer.setTitle("拼命加载数据中...", forState: MJRefreshState.Refreshing)
//        footer.setTitle("上拉加载更多数据", forState: MJRefreshState.Idle)
//        footer.setTitle("已经是最后一条数据咯", forState: MJRefreshState.NoMoreData)
//        footer.setTitle("上拉加载更多数据", forState: MJRefreshState.Pulling)
//        suggestionsView.tableView.mj_footer = footer
        suggestionModel.delegate = self
        suggestionsView.tableView.dataSource = self
        suggestionsView.tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        suggestionModel.getLineList()
        CPPhotoCollectionViewCell.resetCount() // 用于下个页面图片个数重置
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        suggestionsView.button.addTarget(self, action: #selector(newSuggestions), forControlEvents: .TouchUpInside)
    }
    

    // 事件响应
    func newSuggestions(button: UIButton) {
        let vc = CPNewSuggestionViewController()
        self.hidesBottomBarWhenPushed=true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // delegate
    func loadData() {
        suggestionsView.tableView.reloadData()
//        suggestionsView.tableView.mj_footer.endRefreshing()
    }
    
    // datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (suggestionModel.sugesstionsList.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! CPSuggesstionsTableViewCell
        cell.selected = false
        let decodeData = NSData.init(base64EncodedString: self.suggestionModel.sugesstionsList[indexPath.row].totalContent!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        if decodeData != nil {
            cell.titleLabel.text = String(data: decodeData!, encoding: NSUTF8StringEncoding)
        } else {
            cell.titleLabel.text = ""
        }
        
//        cell.titleLabel.text = self.suggestionModel.sugesstionsList[indexPath.row].totalContent
//        Constants.dPrint(content)
        if self.suggestionModel.sugesstionsList[indexPath.row].imgs != nil && self.suggestionModel.sugesstionsList[indexPath.row].imgs?.count != 0 {
            cell.setPhotoArray(self.suggestionModel.sugesstionsList[indexPath.row].imgs!)
            cell.collectionViewHeight.constant = 55
        } else {
            cell.setPhotoArray(NSArray())
            cell.collectionViewHeight.constant = 0
        }
        cell.collectionView.reloadData()    // 需要重新加载数据，否则会因为复用引起数据异常
        cell.answerLabel.text = self.suggestionModel.sugesstionsList[indexPath.row].replyContent == "" ? "客服回复：我们将尽快答复您！" : self.suggestionModel.sugesstionsList[indexPath.row].replyContent
        return cell
    }
    
    
    private let suggestionModel = CPSuggestionsModel()
    private let cellId = "suggestionsCell"
    private var cell: CPSuggesstionsTableViewCell!
    private let suggestionsView = CPSuggestionsView()
}
