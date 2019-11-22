//
//  IMUITextMessageCell.swift
//  IMUIChat
//
//  Created by oshumini on 2017/4/1.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit

open class IMUIRTCMessageCell: IMUIBaseMessageCell {

//    @objc public static var outGoingTextColor = UIColor(netHex: 0x7587A8)
//    @objc public static var inComingTextColor = UIColor.white

//    public static let screenW = UIScreen.main.bounds.size.width

//    @objc public static var outGoingTextFont = screenW < 375 ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: (screenW * 16 / 375))
//    @objc public static var inComingTextFont = screenW < 375 ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: (screenW * 16 / 375))


    fileprivate var conentLable = UILabel()
    fileprivate var callTypeImg = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bubbleView.addSubview(callTypeImg)
        self.bubbleView.addSubview(conentLable)

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
    }

    override func presentCell(with message: IMUIMessageModelProtocol, viewCache: IMUIReuseViewCache, delegate: IMUIMessageMessageCollectionViewDelegate?) {
        super.presentCell(with: message, viewCache: viewCache, delegate: delegate)
//        print("(message.customDict)")
//        let contentKey = message.isOutGoing ? "outgoing" : "incoming"
//        let strContent = message.customDict.object(forKey: contentKey) as! String

        var strContent = message.customDict.object(forKey: "content");
        if ( strContent == nil || !(strContent is String)) {
            let contentKey = message.isOutGoing ? "outgoing" : "incoming"
            strContent = message.customDict.object(forKey: contentKey) as! String
        }

        let callType = message.customDict.object(forKey: "callType") as! Int

        self.layoutToText(with: strContent as! String, isOutGoing: message.isOutGoing)
        self.layoutToVoice(with: callType, isOutGoing: message.isOutGoing)

    }


    func layoutToText(with text: String, isOutGoing: Bool) {

        let tmpLabel = YYLabel()
        tmpLabel.setupYYText(text, andUnunderlineColor: UIColor.white)
        tmpLabel.font = IMUITextMessageCell.inComingTextFont
        let bubbleContentSize = tmpLabel.getTheLabelBubble(CGSize(width: IMUIMessageCellLayout.bubbleMaxWidth, height: 40))

        conentLable.adjustsFontSizeToFitWidth = true

        if isOutGoing {
            conentLable.textColor = IMUITextMessageCell.inComingTextColor
            conentLable.text = text
//            conentLable.textAlignment = NSTextAlignment.right;
            conentLable.frame = CGRect(x: 0, y: 0, width: bubbleContentSize.width, height: 20)
            let xC = (bubbleContentSize.width / 2) + (bubbleView.frame.width - 30 - bubbleContentSize.width)
            conentLable.center = CGPoint(x: xC, y: bubbleView.frame.height / 2)
        } else {
            conentLable.textColor = IMUITextMessageCell.outGoingTextColor
            conentLable.text = text
            conentLable.frame = CGRect(x: 0, y: 0, width: bubbleContentSize.width, height: 20)
            conentLable.center = CGPoint(x: (bubbleContentSize.width / 2) + 35, y: bubbleView.frame.height / 2)
        }

    }


    func layoutToVoice(with callType: Int, isOutGoing: Bool) {
        let imgName = callType == 0 ? "video" : "voice"
        if isOutGoing {
            self.callTypeImg.image = UIImage.imuiImage(with: "outgoing_rtccall_" + imgName)
            self.callTypeImg.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
            self.callTypeImg.center = CGPoint(x: bubbleView.frame.width - 20, y: bubbleView.frame.height / 2)
        } else {
            self.callTypeImg.image = UIImage.imuiImage(with: "incoming_rtccall_" + imgName)
            self.callTypeImg.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
            self.callTypeImg.center = CGPoint(x: 20, y: bubbleView.frame.height / 2)
        }
    }

}
