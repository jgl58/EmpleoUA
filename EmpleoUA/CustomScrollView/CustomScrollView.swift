//
//  CustomScrollView.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 28/05/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//
import UIKit

class CustomScrollView: UIScrollView {

    lazy var contentViewSize = CGSize(width: self.view!.frame.width, height: self.view!.frame.height)
    
    var containerView: UIView?
    var buttonHeight: CGFloat?
    
    var view: UIView?
    var spacing : CGFloat?
    
    init(view: UIView, buttonHeight: CGFloat, spacing : CGFloat = 20.0) {
        super.init(frame: .zero)
        
        self.buttonHeight = buttonHeight
        self.spacing = spacing
        self.view = view
        backgroundColor = .gray
        frame = self.view!.bounds
        contentSize = contentViewSize
        autoresizingMask = .flexibleHeight

        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame.size = contentViewSize
         
        addSubview(containerView)
        
        self.containerView = containerView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateScrollViewSize(_ buttonsStack: [UIView]){
        
        contentViewSize.height = self.buttonHeight! * CGFloat(buttonsStack.count) + (self.spacing! * CGFloat(buttonsStack.count))
        
        containerView!.stack(buttonsStack,axis: .vertical,width: contentViewSize.width,height: contentViewSize.height,spacing: self.spacing!)
        
        contentSize = contentViewSize
        layoutIfNeeded()
        
    }
    
    
}
