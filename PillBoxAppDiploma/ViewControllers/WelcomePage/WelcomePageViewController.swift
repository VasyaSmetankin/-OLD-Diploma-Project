//
//  WelcomePageViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 19.06.2023.
//

import UIKit

class WelcomePageViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    
    var images: [String] = ["first", "second", "third", "fourth", "fifth", "sixth"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = images.count
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentMode = .scaleAspectFit
        
        
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: images[index])
            
            self.scrollView.addSubview(imgView)
            
            
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        scrollView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let debug = segue.destination as? NavigationViewController else { return }
        guard let db = debug.topViewController as? TabBarViewController else { return }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pagenum = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pagenum)
        
        if pageControl.currentPage == images.count - 1 {
                performSegue(withIdentifier: "end", sender: nil)
            
            }
        
        
    }
    
    
    
}

  
    
