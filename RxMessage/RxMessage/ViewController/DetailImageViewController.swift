//
//  ImageDetailViewController.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/12/22.
//

import UIKit
import SnapKit
import Then
import RxSwift

class DetailImageViewController: UIViewController, ViewModelBindableType {
    private var imageView: UIImageView = DetailImageViewController.makeImageView()
    private var navBar: UINavigationBar = DetailImageViewController.makeNavBar()
    private var backButton: UIBarButtonItem? {
        get {
            return navBar.items?.first?.leftBarButtonItem
        }
        set {
            navBar.items?.first?.leftBarButtonItem = newValue
        }
    }
    
    private let bag: DisposeBag = DisposeBag()
    
    
    var viewModel: DetailImageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setupImageView()
        setupNavBar()
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.image
            .bind(to: imageView.rx.image)
            .disposed(by: bag)
        
        rx.viewDidDisappear
            .bind(to: viewModel.dismissAction.inputs)
            .disposed(by: bag)
        
        backButton?.rx.action = viewModel.dismissAction
    }
}


extension DetailImageViewController {
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .brown
        }
        
        return imageView
    }
    
    static func makeNavBar() -> UINavigationBar {
        let button = UIBarButtonItem().then {
            $0.image = UIImage(systemName: "chevron.left")
            $0.style = .plain
        }
        
        let navItem = UINavigationItem().then {
            $0.leftBarButtonItem = button
        }
        
        let navBar = UINavigationBar().then {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            $0.tintColor = .brown
            $0.setItems([navItem], animated: false)
            
            $0.standardAppearance = appearance
        }
        
        return navBar
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupNavBar() {
        view.addSubview(navBar)
        
        navBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}




#if DEBUG
import SwiftUI

struct DetailImageVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return DetailImageViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct DetailImagePreviewProvider: PreviewProvider {
    static var previews: some View {
        DetailImageVCRepresentable()
    }
}
#endif
