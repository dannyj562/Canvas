//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Danny on 10/22/18.
//  Copyright © 2018 Danny Rivera. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    @IBOutlet var trayGestureRecognizer: UIPanGestureRecognizer!
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 20
        
        trayUp = CGPoint(x: trayView.center.x, y: view.frame.height/2.0 + trayView.frame.height/2.0 + 50)
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
    
        print("UI Height \(view.frame.height)")
        print("TrayUp value \(trayUp)")
        print("TrayDown value \(trayDown)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            NSLog("Gesture began");
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            NSLog("Gesture changed")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.3, options: [], animations: {
                    self.trayView.center = self.trayDown
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.3, options: [], animations: {
                    self.trayView.center = self.trayUp
                }, completion: nil)
            }
            NSLog("Gesture ended")
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            let imageView = sender.view as! UIImageView
            self.newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            self.newlyCreatedFace.center = imageView.center
            self.newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 3, y: 3)
        }
        else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
            self.newlyCreatedFace.transform = CGAffineTransform.identity
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
