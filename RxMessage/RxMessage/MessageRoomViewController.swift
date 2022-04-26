//
//  MessageRoomViewController.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/26/22.
//

import UIKit

class MessageRoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}



#if DEBUG
import SwiftUI

struct MessageRoomVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return MessageRoomViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct MessageRoomPreviewProvider: PreviewProvider {
    static var previews: some View {
        MessageRoomVCRepresentable()
    }
}
#endif

