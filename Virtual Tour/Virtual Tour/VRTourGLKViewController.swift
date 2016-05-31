//
//  VirtualTourViewController.swift
//  Virtual Tour
//
//  Created by Admin on 5/3/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import GLKit

class VRTourGLKViewController: GLKViewController {
    
    var panoramaView = PanoramaView()
    var index = 0
    
    let panoramaImages = [
        "frontview.jpg",
        "lounge.jpg",
        "livingroom.jpg",
        "kitchen.jpg",
        "bedroom.jpg",
        // "location.jpg",
        ]
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPanorama(index)
    }
    
    override func glkView(view: GLKView, drawInRect rect: CGRect) {
        
        self.panoramaView.draw()
        
    }
    
    func setPanorama(index: Int) {
        
        let panorama = panoramaImages[index]
        
        if let panoramaView = self.panoramaView as PanoramaView! {
            
            panoramaView.setImage(UIImage(named: panorama)) // (4096×2048), 2048×1024, 1024×512, 512×256, 256×128
            panoramaView.touchToPan = false          // Use touch input to pan
            panoramaView.orientToDevice = true     // Use motion sensors to pan
            panoramaView.pinchToZoom = false         // Use pinch gesture to zoom
            panoramaView.showTouches = false         // Show touches

            self.view = panoramaView
            
            let range = panorama.startIndex.advancedBy(0) ..< panorama.endIndex.advancedBy(-4)
            title = panorama.substringWithRange(range).capitalizedString
            
        }
    }
    
    
    @IBAction func navigationPanorama(sender: UIBarButtonItem) {
        
        switch sender.title! {
        case "Next":
            if index >= 0 && index < panoramaImages.count - 1 {
                index += 1
                setPanorama(index)
            }
        case "Previous":
            if index > 0 && index <= panoramaImages.count - 1 {
                index -= 1
                setPanorama(index)
            }
            
        default:
            break
        }
        
        
        
    }
    
    
    
    
    
}
