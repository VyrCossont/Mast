//
//  DetailCell.swift
//  mastodon
//
//  Created by Shihab Mehboob on 22/09/2018.
//  Copyright © 2018 Shihab Mehboob. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage

class DetailCell: UITableViewCell {
    
    var profileImageView = UIButton()
    var userName = UILabel()
    var userTag = UILabel()
    var date = UILabel()
    var toot = ActiveLabel()
    var faves = UIButton()
    var fromClient = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImageView.backgroundColor = Colours.white
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userTag.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        toot.translatesAutoresizingMaskIntoConstraints = false
        fromClient.translatesAutoresizingMaskIntoConstraints = false
        faves.translatesAutoresizingMaskIntoConstraints = false
        
        if (UserDefaults.standard.object(forKey: "proCorner") == nil || UserDefaults.standard.object(forKey: "proCorner") as! Int == 0) {
            profileImageView.layer.cornerRadius = 20
        }
        if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 1) {
            profileImageView.layer.cornerRadius = 8
        }
        if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 2) {
            profileImageView.layer.cornerRadius = 0
        }
        profileImageView.layer.masksToBounds = true
        
        userName.numberOfLines = 0
        userTag.numberOfLines = 0
        toot.numberOfLines = 0
        fromClient.numberOfLines = 0
        faves.titleLabel?.textAlignment = .left

        userTag.textColor = Colours.black.withAlphaComponent(0.6)
        date.textColor = Colours.black.withAlphaComponent(0.6)
        fromClient.textColor = Colours.black.withAlphaComponent(0.6)
        faves.titleLabel?.textColor = Colours.tabSelected
        faves.setTitleColor(Colours.tabSelected, for: .normal)

        userTag.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        date.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        fromClient.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        faves.titleLabel?.font = UIFont.systemFont(ofSize: Colours.fontSize3)

        toot.enabledTypes = [.mention, .hashtag, .url]
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(userName)
        contentView.addSubview(userTag)
        contentView.addSubview(date)
        contentView.addSubview(toot)
        contentView.addSubview(fromClient)
        contentView.addSubview(faves)
        
        let viewsDict = [
            "image" : profileImageView,
            "name" : userName,
            "artist" : userTag,
            "date" : date,
            "episodes" : toot,
            "from" : fromClient,
            "faves" : faves,
            ]
        
        
//        if UIApplication.shared.isSplitOrSlideOver || UIDevice.current.userInterfaceIdiom == .phone {
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[image(40)]-13-[name]-(>=5)-[date]-20-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[image(40)]-13-[artist]-(>=5)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[image(40)]-13-[episodes]-20-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[image(40)]-13-[from]-20-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[image(40)]-13-[faves]-(>=20)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[date]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[image(40)]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-15-[episodes]-10-[faves]-10-[from]-12-|", options: [], metrics: nil, views: viewsDict))
//        } else {
//
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[image(40)]-13-[name]-(>=5)-[date]-120-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[image(40)]-13-[artist]-(>=105)-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[image(40)]-13-[episodes]-120-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[image(40)]-13-[from]-120-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[image(40)]-13-[faves]-(>=120)-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[date]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[image(40)]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-15-[episodes]-10-[faves]-10-[from]-12-|", options: [], metrics: nil, views: viewsDict))
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ status: Status) {

        if (UserDefaults.standard.object(forKey: "mentionToggle") == nil || UserDefaults.standard.object(forKey: "mentionToggle") as! Int == 0) {
            userTag.text = "@\(status.reblog?.account.acct ?? status.account.acct)"
        } else {
            userTag.text = "@\(status.reblog?.account.username ?? status.account.username)"
        }
        date.text = status.reblog?.createdAt.toStringWithRelativeTime() ?? status.createdAt.toStringWithRelativeTime()

        if let reblog = status.reblog {
            toot.attributedText = reblog.asRichText(suffix: "\u{21bb} @\(status.account.acct) boosted") ?? RichText.failure
            userName.attributedText = reblog.account.displayNameAsRichText() ?? RichText.failure
        } else {
            toot.attributedText = status.asRichText() ?? RichText.failure
            userName.attributedText = status.account.displayNameAsRichText() ?? RichText.failure
        }
        self.reloadInputViews()
        
        let z = status.reblog?.application?.name ?? status.application?.name ?? ""
        let da = status.reblog?.createdAt.toString(dateStyle: .medium, timeStyle: .medium) ?? status.createdAt.toString(dateStyle: .medium, timeStyle: .medium)
        if z == "" {
            fromClient.text = da
        } else {
            fromClient.text = "\(da), via \(z)"
        }
        
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: status.reblog?.favouritesCount ?? status.favouritesCount))
        
        let numberFormatter2 = NumberFormatter()
        numberFormatter2.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber2 = numberFormatter2.string(from: NSNumber(value: status.reblog?.reblogsCount ?? status.reblogsCount))
        
        var likeText = "likes"
        if formattedNumber == "1" {
            likeText = "like"
        }
        var boostText = "boosts"
        if formattedNumber2 == "1" {
            boostText = "boost"
        }
        
        faves.setTitle("\(formattedNumber ?? "0") \(likeText) and \(formattedNumber2 ?? "0") \(boostText)", for: .normal)
        
        profileImageView.pin_setPlaceholder(with: UIImage(named: "logo"))
        profileImageView.pin_updateWithProgress = true
        profileImageView.pin_setImage(from: URL(string: "\(status.reblog?.account.avatar ?? status.account.avatar)"))
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.borderWidth = 0.2
        if (UserDefaults.standard.object(forKey: "proCorner") == nil || UserDefaults.standard.object(forKey: "proCorner") as! Int == 0) {
            profileImageView.layer.cornerRadius = 20
        }
        if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 1) {
            profileImageView.layer.cornerRadius = 8
        }
        if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 2) {
            profileImageView.layer.cornerRadius = 0
        }
        
        userTag.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        date.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        fromClient.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        faves.titleLabel?.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        
        
    }
    
}

