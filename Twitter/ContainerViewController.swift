//
//  ContainerViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/31/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

enum SlideOutState {
    case Collapsed
    case Expanded
}

class ContainerViewController: UIViewController {

    var centerNavigationController: UINavigationController!
    var centerViewController: TweetsViewController!
    
    // for shadow
    var currentState: SlideOutState = .Collapsed {
        didSet {
            let shouldShowShadow = currentState != .Collapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var sideMenuViewController: SideMenuViewController?
    let centerPanelExpandedOffset: CGFloat = 60

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("container view in the house")
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMoveToParentViewController(self)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)

    }
}

extension ContainerViewController: CenterViewControllerDelegate, SideMenuViewControllerDelegate {
    func addSideMenuViewController() {
        if (sideMenuViewController == nil) {
            sideMenuViewController = UIStoryboard.sideMenuViewController()
            addChildSidePanelController(sideMenuViewController!)
        }
    }
    
    // check this
    func addChildSidePanelController(smvc: SideMenuViewController) {
        view.insertSubview(smvc.view, atIndex: 0)
        addChildViewController(smvc)
        smvc.didMoveToParentViewController(self)
        println("addchildsidepanelcontroller")
    }
    
    
    func animateSideMenu(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .Expanded
            
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
            println("animating")
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .Collapsed
                self.sideMenuViewController?.view.removeFromSuperview()
                self.sideMenuViewController = nil;
                println("collapsing")
            }
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow){
            self.view.layer.shadowOpacity = 0.8
        } else {
            self.view.layer.shadowOpacity = 0.0
        }
    }
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        println("panning")
        switch(recognizer.state) {
        case .Began:
            if (currentState == .Collapsed) {
                if (gestureIsDraggingFromLeftToRight) {
                    addSideMenuViewController()
                    println("adding side menu view controller")
                }
                showShadowForCenterViewController(true)
            }
        case .Changed:
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
            
        case .Ended:
            // animate the side panel open or closed based on whether the view has moved more or less than halfway
            let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
            animateSideMenu(shouldExpand: hasMovedGreaterThanHalfway)
        default:
            break
        }
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func sideMenuViewController() -> SideMenuViewController? {
        println("sidemenuthinginstatiated")
        return mainStoryboard().instantiateViewControllerWithIdentifier("SideMenuViewController") as? SideMenuViewController
    }
    
    class func centerViewController() -> TweetsViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("TweetsViewController") as? TweetsViewController
    }
    
}


