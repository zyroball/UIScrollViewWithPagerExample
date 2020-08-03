//
//  ImageDisplayView.swift
//  UIScrollViewExample
//
//  Created by yu_ookubo on 2020/08/03.
//  Copyright © 2020 yu_ookubo. All rights reserved.
//

import UIKit

class ImageDisplayView:
    UIView,
    UIScrollViewDelegate
{
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainContentView: UIView!
    @IBOutlet var contentSizeWidth: NSLayoutConstraint!
    @IBOutlet var pagerLabel: UILabel!
    
    
    public func updateView()
    {
        mainScrollView.delegate     = self
        mainScrollView.contentSize  = CGSize(width: UIScreen.main.bounds.size.width*10,
                                             height: UIScreen.main.bounds.size.height)
        //スクロールサイズを指定
        contentSizeWidth.constant   = mainScrollView.contentSize.width
        
        var count = 0
        while count < 10
        {
            if let zoomView: ZoomingView = Bundle.main.loadNibNamed("ImageDisplayView",
                                                                    owner: self,
                                                                    options: nil)?[1] as? ZoomingView
            {
                print(zoomView)
                zoomView.imageView.image = UIImage(named: "image")
                zoomView.frame = CGRect(x: (CGFloat)(count)*UIScreen.main.bounds.size.width,
                                        y: 0,
                                        width: UIScreen.main.bounds.size.width,
                                        height: UIScreen.main.bounds.size.height)
                mainContentView.addSubview(zoomView)
            }
            count += 1
        }
        updatePager(scrollView: mainScrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        updatePager(scrollView: scrollView)
    }
    
    private func updatePager(scrollView: UIScrollView)
    {
        pagerLabel.text = "\(Int(scrollView.contentOffset.x/UIScreen.main.bounds.size.width)+1)" + "/" + "10"
    }
}

class ZoomingView: UIView
{
    @IBOutlet var imageView: UIImageView!
}
