//
//  SettingViewController.swift
//  MyInsta
//
//  Created by Nam on 12/15/20.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureModels() {
        
        data.append([
            SettingCellModel(title: "Edit Profile") { [ weak self] in
                self?.didTabEditProfile()
                
            },
            SettingCellModel(title: "Invite Friends") { [ weak self] in
                self?.didTabInviteFriends()
                
            },
            SettingCellModel(title: "Save Original Posts") { [ weak self] in
                self?.didTabSaveOriginalPost()
                
            },
        ])
        
        data.append([
            SettingCellModel(title: "Terms or Service") { [ weak self] in
                self?.openURL(type: SettingsURLType.terms)
                
            }
        ])
        
        data.append([
            SettingCellModel(title: "Privacy Policy") { [ weak self] in
                self?.openURL(type: SettingsURLType.privacy)
                
            }
        ])
        
        data.append([
            SettingCellModel(title: "Help / Feedback") { [ weak self] in
                self?.openURL(type: SettingsURLType.help)
                
            }
        ])
        
        data.append([
            SettingCellModel(title: "Log Out") { [ weak self] in
                self?.didTabLogOut()
                
            }
        ])
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type{
        case .terms : urlString = "https://www.facebook.com/help/instagram/termsofuse"
        case .privacy : urlString = "https://help.instagram.com/519522125107875"
        case .help : urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTabEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTabInviteFriends() {
        // show share sheet to invite friends
    }
    
    private func didTabSaveOriginalPost() {
        
    }
    
    private func didTabLogOut() {
        
        let actionSheet =  UIAlertController(title: "Log Out", message: "Are you sure you want to Log Out", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        // present login
                        
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                        print("logout success")
                    } else {
                        // error occured
                        fatalError("Could not log out user")
                    }
                }
            })
        }))
        
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
}
