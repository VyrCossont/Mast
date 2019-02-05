//
//  MainFeedCell.swift
//  mastodon
//
//  Created by Shihab Mehboob on 18/09/2018.
//  Copyright © 2018 Shihab Mehboob. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage

class MainFeedCell: SwipeTableViewCell {
    
    var profileImageView = UIButton()
    var profileImageView2 = UIButton()
    var warningB = UIButton()
    var userName = UILabel()
    var userTag = UILabel()
    var date = UILabel()
    var toot = ActiveLabel()
    var moreImage = UIImageView()
    
    var rep1 = UIButton()
    var like1 = UIButton()
    var boost1 = UIButton()
    var more1 = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImageView.backgroundColor = Colours.white
        profileImageView2.backgroundColor = Colours.clear
        warningB.backgroundColor = Colours.clear
        moreImage.backgroundColor = Colours.clear
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView2.translatesAutoresizingMaskIntoConstraints = false
        warningB.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userTag.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        toot.translatesAutoresizingMaskIntoConstraints = false
        moreImage.translatesAutoresizingMaskIntoConstraints = false
        
        if (UserDefaults.standard.object(forKey: "proCorner") == nil || UserDefaults.standard.object(forKey: "proCorner") as! Int == 0) {
            profileImageView.layer.cornerRadius = 20
            profileImageView2.layer.cornerRadius = 13
        }
        if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 1) {
            profileImageView.layer.cornerRadius = 8
            profileImageView2.layer.cornerRadius = 4
        }
        if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 2) {
            profileImageView.layer.cornerRadius = 0
            profileImageView2.layer.cornerRadius = 0
        }
        profileImageView.layer.masksToBounds = true
        profileImageView2.layer.masksToBounds = true
        
        warningB.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        warningB.titleLabel?.textAlignment = .center
        warningB.setTitleColor(Colours.black.withAlphaComponent(0.4), for: .normal)
        warningB.layer.cornerRadius = 7
        warningB.titleLabel?.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        warningB.titleLabel?.numberOfLines = 0
        warningB.layer.masksToBounds = true
        
        userName.numberOfLines = 0
        userTag.numberOfLines = 0
        toot.numberOfLines = 0
        
        userTag.textColor = Colours.black.withAlphaComponent(0.6)
        date.textColor = Colours.black.withAlphaComponent(0.6)
        
        userTag.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        date.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        
        toot.enabledTypes = [.mention, .hashtag, .url]
        toot.mentionColor = Colours.tabSelected
        toot.hashtagColor = Colours.tabSelected
        toot.URLColor = Colours.tabSelected
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileImageView2)
        contentView.addSubview(userName)
        contentView.addSubview(userTag)
        contentView.addSubview(date)
        contentView.addSubview(toot)
        contentView.addSubview(moreImage)
        
        
        rep1.translatesAutoresizingMaskIntoConstraints = false
        rep1.setImage(UIImage(named: "reply3")?.maskWithColor(color: Colours.gray), for: .normal)
        rep1.backgroundColor = UIColor.clear
        rep1.layer.masksToBounds = true
        if (UserDefaults.standard.object(forKey: "tootpl") == nil) || (UserDefaults.standard.object(forKey: "tootpl") as! Int == 0) {
            self.rep1.alpha = 0
        } else {
            self.rep1.alpha = 1
        }
        like1.translatesAutoresizingMaskIntoConstraints = false
        like1.setImage(UIImage(named: "like3")?.maskWithColor(color: Colours.gray), for: .normal)
        like1.backgroundColor = UIColor.clear
        like1.layer.masksToBounds = true
        if (UserDefaults.standard.object(forKey: "tootpl") == nil) || (UserDefaults.standard.object(forKey: "tootpl") as! Int == 0) {
            self.like1.alpha = 0
        } else {
            self.like1.alpha = 1
        }
        boost1.translatesAutoresizingMaskIntoConstraints = false
        boost1.setImage(UIImage(named: "boost3")?.maskWithColor(color: Colours.gray), for: .normal)
        boost1.backgroundColor = UIColor.clear
        boost1.layer.masksToBounds = true
        if (UserDefaults.standard.object(forKey: "tootpl") == nil) || (UserDefaults.standard.object(forKey: "tootpl") as! Int == 0) {
            self.boost1.alpha = 0
        } else {
            self.boost1.alpha = 1
        }
        more1.translatesAutoresizingMaskIntoConstraints = false
        more1.setImage(UIImage(named: "more")?.maskWithColor(color: Colours.gray), for: .normal)
        more1.backgroundColor = UIColor.clear
        more1.layer.masksToBounds = true
        if (UserDefaults.standard.object(forKey: "tootpl") == nil) || (UserDefaults.standard.object(forKey: "tootpl") as! Int == 0) {
            self.more1.alpha = 0
        } else {
            self.more1.alpha = 0
        }
        
        contentView.addSubview(rep1)
        contentView.addSubview(like1)
        contentView.addSubview(boost1)
        contentView.addSubview(more1)
        
        contentView.addSubview(warningB)
        
        let viewsDict = [
            "image" : profileImageView,
            "image2" : profileImageView2,
            "warning" : warningB,
            "name" : userName,
            "artist" : userTag,
            "date" : date,
            "episodes" : toot,
            "more" : moreImage,
            "rep1" : rep1,
            "like1" : like1,
            "boost1" : boost1,
            "more1" : more1,
            ]
        
        
//        if UIApplication.shared.isSplitOrSlideOver || UIDevice.current.userInterfaceIdiom == .phone {
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[image(40)]-13-[name]-(>=5)-[date]-20-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[image2(26)]-(>=20)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[image(40)]-13-[artist]-(>=5)-[more(16)]-20-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[image(40)]-13-[episodes]-20-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[date]-2-[more(16)]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[image(40)]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-32-[image2(26)]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
            
            if (UserDefaults.standard.object(forKey: "tootpl") == nil) || (UserDefaults.standard.object(forKey: "tootpl") as! Int == 0) {
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-12-|", options: [], metrics: nil, views: viewsDict))
            } else {
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-15-[rep1(20)]-12-|", options: [], metrics: nil, views: viewsDict))
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-15-[like1(20)]-12-|", options: [], metrics: nil, views: viewsDict))
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-15-[boost1(20)]-12-|", options: [], metrics: nil, views: viewsDict))
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-15-[more1(20)]-12-|", options: [], metrics: nil, views: viewsDict))
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-73-[rep1(20)]-24-[like1(20)]-24-[boost1(14)]-24-[more1(20)]-(>=10)-|", options: [], metrics: nil, views: viewsDict))
            }
            
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-71-[warning]-17-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-54-[warning]-9-|", options: [], metrics: nil, views: viewsDict))
            
//        } else {
//
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[image(40)]-13-[name]-(>=5)-[date]-120-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-140-[image2(26)]-(>=120)-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[image(40)]-13-[artist]-(>=5)-[more(16)]-120-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[image(40)]-13-[episodes]-120-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[date]-2-[more(16)]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[image(40)]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-32-[image2(26)]-(>=12)-|", options: [], metrics: nil, views: viewsDict))
//
//            if (UserDefaults.standard.object(forKey: "tootpl") == nil) || (UserDefaults.standard.object(forKey: "tootpl") as! Int == 0) {
//                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-12-|", options: [], metrics: nil, views: viewsDict))
//            } else {
//                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-15-[rep1(20)]-12-|", options: [], metrics: nil, views: viewsDict))
//                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-15-[like1(20)]-12-|", options: [], metrics: nil, views: viewsDict))
//                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-15-[boost1(20)]-12-|", options: [], metrics: nil, views: viewsDict))
//                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[name]-1-[artist]-5-[episodes]-15-[more1(20)]-12-|", options: [], metrics: nil, views: viewsDict))
//                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-173-[rep1(20)]-24-[like1(20)]-24-[boost1(14)]-24-[more1(20)]-(>=10)-|", options: [], metrics: nil, views: viewsDict))
//            }
//
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-171-[warning]-117-|", options: [], metrics: nil, views: viewsDict))
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[warning]-9-|", options: [], metrics: nil, views: viewsDict))
//
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ status: Status) {
        
        rep1.setImage(UIImage(named: "reply3")?.maskWithColor(color: Colours.gray), for: .normal)
        like1.setImage(UIImage(named: "like3")?.maskWithColor(color: Colours.gray), for: .normal)
        boost1.setImage(UIImage(named: "boost3")?.maskWithColor(color: Colours.gray), for: .normal)
        more1.setImage(UIImage(named: "more")?.maskWithColor(color: Colours.gray), for: .normal)
        
        if (UserDefaults.standard.object(forKey: "dmTog") == nil) || (UserDefaults.standard.object(forKey: "dmTog") as! Int == 0) {
            
        } else {
            if status.visibility == .direct {
                self.contentView.backgroundColor = Colours.cellQuote
            } else {
                self.contentView.backgroundColor = Colours.white
            }
        }

        if (UserDefaults.standard.object(forKey: "mentionToggle") == nil || UserDefaults.standard.object(forKey: "mentionToggle") as! Int == 0) {
            userTag.text = "@\(status.reblog?.account.acct ?? status.account.acct)"
        } else {
            userTag.text = "@\(status.reblog?.account.username ?? status.account.username)"
        }
        
        
        if (UserDefaults.standard.object(forKey: "timerel") == nil) || (UserDefaults.standard.object(forKey: "timerel") as! Int == 0) {
            date.text = status.reblog?.createdAt.toStringWithRelativeTime() ?? status.createdAt.toStringWithRelativeTime()
        } else {
            date.text = status.reblog?.createdAt.toString(dateStyle: .short, timeStyle: .short) ?? status.createdAt.toString(dateStyle: .short, timeStyle: .short)
        }
        
        if let reblog = status.reblog {
            self.toot.attributedText = reblog.asRichText(suffix: "\u{21bb} @\(status.account.acct) boosted") ?? RichText.failure
            self.userName.attributedText = reblog.account.displayNameAsRichText() ?? RichText.failure
            
            profileImageView2.pin_setPlaceholder(with: UIImage(named: "logo"))
            profileImageView2.pin_updateWithProgress = true
            profileImageView2.pin_setImage(from: URL(string: "\(status.account.avatar)"))
            profileImageView2.layer.masksToBounds = true
            profileImageView2.layer.borderColor = UIColor.black.cgColor
            profileImageView2.layer.borderWidth = 0.2
            if (UserDefaults.standard.object(forKey: "proCorner") == nil || UserDefaults.standard.object(forKey: "proCorner") as! Int == 0) {
                profileImageView2.layer.cornerRadius = 13
            }
            if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 1) {
                profileImageView2.layer.cornerRadius = 4
            }
            if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 2) {
                profileImageView2.layer.cornerRadius = 0
            }
        } else {
            self.toot.attributedText = status.asRichText() ?? RichText.failure
            self.userName.attributedText = status.account.displayNameAsRichText() ?? RichText.failure
            
            profileImageView2.pin_setPlaceholder(with: UIImage(named: "logo2345"))
            profileImageView2.layer.masksToBounds = true
            profileImageView2.layer.borderColor = UIColor.black.cgColor
            profileImageView2.layer.borderWidth = 0
            profileImageView2.alpha = 0
            if (UserDefaults.standard.object(forKey: "proCorner") == nil || UserDefaults.standard.object(forKey: "proCorner") as! Int == 0) {
                profileImageView2.layer.cornerRadius = 13
            }
            if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 1) {
                profileImageView2.layer.cornerRadius = 4
            }
            if (UserDefaults.standard.object(forKey: "proCorner") != nil && UserDefaults.standard.object(forKey: "proCorner") as! Int == 2) {
                profileImageView2.layer.cornerRadius = 0
            }
        }
        self.reloadInputViews()
        profileImageView2.isUserInteractionEnabled = false

        userTag.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        date.font = UIFont.systemFont(ofSize: Colours.fontSize3)
        
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
        
        self.moreImage.contentMode = .scaleAspectFit
        if (status.reblog?.favourited ?? status.favourited ?? false) && (status.reblog?.reblogged ?? status.reblogged ?? false) {
            self.moreImage.image = UIImage(named: "fifty")
        } else if status.reblog?.reblogged ?? status.reblogged ?? false {
            self.moreImage.image = UIImage(named: "boost")
        } else if (status.reblog?.favourited ?? status.favourited ?? false) || StoreStruct.allLikes.contains(status.reblog?.id ?? status.id) {
            self.moreImage.image = UIImage(named: "like")
        } else {
            
            if status.reblog?.visibility ?? status.visibility == .direct {
                self.moreImage.image = UIImage(named: "direct")
            } else if status.reblog?.visibility ?? status.visibility == .unlisted {
                self.moreImage.image = UIImage(named: "unlisted")
            } else if status.reblog?.visibility ?? status.visibility == .private {
                self.moreImage.image = UIImage(named: "private")
            } else {
                self.moreImage.image = nil
            }
        }
        
        
        if (UserDefaults.standard.object(forKey: "senseTog") == nil) || (UserDefaults.standard.object(forKey: "senseTog") as! Int == 0) {
            
            if status.reblog?.sensitive ?? false || status.sensitive ?? false {
                warningB.backgroundColor = Colours.tabUnselected
                let z = status.reblog?.spoilerText ?? status.spoilerText
                var zz = "Content Warning"
                if z == "" {} else {
                    zz = z
                }
                warningB.setTitle("\(zz)\n\nTap to show toot", for: .normal)
                warningB.setTitleColor(Colours.black.withAlphaComponent(0.4), for: .normal)
                warningB.addTarget(self, action: #selector(self.didTouchWarning), for: .touchUpInside)
                warningB.alpha = 1
            } else {
                warningB.backgroundColor = Colours.clear
                warningB.alpha = 0
            }
            
        } else {
            warningB.backgroundColor = Colours.clear
            warningB.alpha = 0
        }
        
    }
    
    @objc func didTouchWarning() {
        warningB.backgroundColor = Colours.clear
        warningB.alpha = 0
        if (UserDefaults.standard.object(forKey: "hapticToggle") == nil) || (UserDefaults.standard.object(forKey: "hapticToggle") as! Int == 0) {
            let selection = UISelectionFeedbackGenerator()
            selection.selectionChanged()
        }
    }
    
}

let imageCache = NSCache<NSString, AnyObject>()

extension NSTextAttachment {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}
