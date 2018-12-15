//
//  ViewController.swift
//  FyyScrollView
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 2016110305. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate{

    var scroll1 : UIScrollView!
    var page : UIPageControl!
    var scroll2 : UIScrollView!
    var selectImageView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        let width = self.view.bounds.width - 20
        let height = width*0.5
        scroll1 = UIScrollView(frame: CGRect(x: 10, y: 100, width: width, height:height))
        //按一页一页的方式滚动
        scroll1.isPagingEnabled = true
        //隐藏水平滚动条
        scroll1.showsHorizontalScrollIndicator = false
        //设置内容大小
        scroll1.contentSize = CGSize(width: width*5, height: height)
        //设置代理
        scroll1.delegate = self
        self.view.addSubview(scroll1)
        
        page = UIPageControl(frame: CGRect(x: 10, y: 100+height, width: width, height: 30))
        //总页数
        page.numberOfPages = 5
        //当前页
        page.currentPage = 0
        //指示器未选中时颜色
        page.pageIndicatorTintColor = UIColor.brown
        //指示器选中时颜色
        page.currentPageIndicatorTintColor = UIColor.red
        //添加事件
        page.addTarget(self, action: #selector(pageChanged(page:)), for: .touchUpInside)
        self.view.addSubview(page)
        
        //我们需要向scrollview中添加图片视图
        for i in 1...5 {
            let image = UIImage(named: "\(i)")
            let imageView = UIImageView(frame: CGRect(x: width*CGFloat(i-1), y: 0, width: width, height: height))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            //给每张照片添加tap手势
//            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
//            imageView.isUserInteractionEnabled = true
//            scroll1.isUserInteractionEnabled = true
//            imageView.addGestureRecognizer(tapRecognizer)
//            //设置单机次数为1
//            tapRecognizer.numberOfTapsRequired = 1
            scroll1.addSubview(imageView)

        }
        //缩放效果
        scroll2 = UIScrollView(frame: CGRect(x: 10, y: 200+height, width: width, height: height))
        scroll2.backgroundColor = UIColor.yellow
        scroll2.contentSize = CGSize(width: width, height: height)
        //最大缩放比例
        scroll2.maximumZoomScale = 10
        //最小缩放比例
        scroll2.minimumZoomScale = 0.1
        scroll2.delegate = self
        self.view.addSubview(scroll2)
        
        let image = UIImage(named: "6")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        scroll2.addSubview(imageView)
        
    }
    
        //实现点击ImageView显示在scroll2中没有成功！！
//    @objc func tap(recognizer: UITapGestureRecognizer) {
//        if recognizer.state == .ended {
//            let sourceImageView = (recognizer.view as! UIImageView)
//            selectImageView = sourceImageView
//            selectImageView!.contentMode = .scaleAspectFill
//            for eachView in scroll2.subviews {
//                eachView.removeFromSuperview()
//            }
//            scroll2.addSubview(selectImageView!)
//        }
//
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / (self.view.bounds.width - 20))
        page.currentPage = currentPage
    }
        
    @objc func pageChanged(page: UIPageControl) {
        let rect = CGRect(x: scroll1.bounds.width*CGFloat(page.currentPage), y: 0, width: scroll1.bounds.width, height: scroll1.bounds.height)
        scroll1.scrollRectToVisible(rect, animated: true)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scroll2.subviews.first
    }

}
