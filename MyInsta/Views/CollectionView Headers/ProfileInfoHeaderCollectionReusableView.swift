//
//  ProfileInfoHeaderCollectionReusableView.swift
//  MyInsta
//
//  Created by Nam on 12/17/20.
//

import UIKit
import Stevia

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfilesButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView = UIImageView()
    private let nameLabel = UILabel()
    private let bioLabel = UILabel()
    private let postsButton = UIButton()
    private let followersButton = UIButton()
    private let followingButton = UIButton()
    private let editProfleButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        
        clipsToBounds = true
    }
    
    private func addSubviews() {
        sv(
            profilePhotoImageView, postsButton, followersButton, followingButton, nameLabel, bioLabel, editProfleButton
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configLayout()
        addActions()
    }
    
    private func configLayout() {
        layout(
            32,
            alignHorizontally(|-profilePhotoImageView.size(80)-postsButton-followingButton-followersButton-|),
            12,
            |-nameLabel,
            |-bioLabel ,
            32,
            |-editProfleButton-|
        )
        
        equalSizes(postsButton, followingButton, followersButton)
        
        profilePhotoImageView.backgroundColor = .yellow
        postsButton.backgroundColor = .secondarySystemBackground
        followingButton.backgroundColor = .secondarySystemBackground
        followersButton.backgroundColor = .secondarySystemBackground
        editProfleButton.backgroundColor = .secondarySystemBackground
        
        // content
        postsButton.setTitle("Post", for: .normal)
        followingButton.setTitle("Following", for: .normal)
        followersButton.setTitle("Followers", for: .normal)
        nameLabel.text = "Namdeeptry"
        bioLabel.text = "hoa mi on the mic"
        editProfleButton.setTitle("Edit Profile", for: .normal)
        
        profilePhotoImageView.layer.borderWidth = 1
        profilePhotoImageView.layer.borderColor = UIColor.white.cgColor
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.height/2
        profilePhotoImageView.layer.masksToBounds = false
        profilePhotoImageView.clipsToBounds = true
        
    }
    
    private func addActions() {
        postsButton.addTarget(self, action: #selector(didTabPostButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTabFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTabFollowingButton), for: .touchUpInside)
        editProfleButton.addTarget(self, action: #selector(didTabEditProfileButton), for: .touchUpInside)
    }
    
    // MARK: - Action
    
    @objc private func didTabPostButton() {
        print("didtappost")
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTabFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTabFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTabEditProfileButton() {
        print("didtapEdit")
        delegate?.profileHeaderDidTapEditProfilesButton(self)
    }
}


