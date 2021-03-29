//
//  HelpController.swift
//  Zendesk Demo
//
//  Created by Marcelo De Bortoli  on 13/01/2020.
//  Copyright © 2020 EMEA Presales. All rights reserved.
//

/*
/////////////////////////////////////////////////////////////////////////////
// DO NOT CHANGE ANYTHING ON THIS FILE UNLESS YOU KNOW WHAT YOU'RE DOING   //
/////////////////////////////////////////////////////////////////////////////
*/

import UIKit
import ZendeskCoreSDK
import AnswerBotProvidersSDK
import AnswerBotSDK
import MessagingSDK
import SDKConfigurations
import SupportSDK
import ChatSDK
import ChatProvidersSDK
import TalkSDK

class HelpController: UIViewController, UINavigationControllerDelegate {
    
    var talk: Talk?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        talk = Talk(zendesk: Zendesk.instance!)
    }

    @IBAction func HcButton(_ sender: UIButton) {
        let helpCenter = HelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [])
        self.navigationController?.pushViewController(helpCenter, animated: true)
    }

    @IBAction func BotButton(_ sender: UIButton) {
        do {
            let messagingConfiguration = MessagingConfiguration()
            let answerBotEngine = try AnswerBotEngine.engine()
            let supportEngine = try SupportEngine.engine()
            let chatEngine = try ChatEngine.engine()
            let viewController = try Messaging.instance.buildUI(engines: [answerBotEngine, supportEngine, chatEngine],
                                configs: [messagingConfiguration])

            self.navigationController?.pushViewController(viewController, animated: true)
        } catch {
            print("ERROR")
        }

    }

    @IBAction func ChatButton(_ sender: UIButton) {
        do {
            let viewController = try ZendeskChat.instance.buildMessagingViewController()
            presentModally(viewController)
        } catch {
            print(error)
        }
    }

    @IBAction func RequestButton(_ sender: UIButton) {
         let config = RequestUiConfiguration()
         config.subject = "SDK Ticket"
         config.tags = ["iOS", "SDK"]

         let requestScreen = RequestUi.buildRequestUi(with: [config])
         self.navigationController?.pushViewController(requestScreen, animated: true)
    }

    @IBAction func TicketsButton(_ sender: UIButton) {
        let requestList = RequestUi.buildRequestList(with: [])
        self.navigationController?.pushViewController(requestList, animated: true)
    }

    @IBAction func CallUs(_ sender: UIButton) {
        guard let talk = talk else { return }

        talk.startCall(to: config.digitalLine)
    }



    /* Custom Chat Functions (add rating)                                      //
    ////////////////////////////////////////////////////////////////////////// */

    private func pushViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentModally(_ viewController: UIViewController,
                                presenationStyle: UIModalPresentationStyle = .automatic) {

        // Positive vote button
        let thumbsUp = UIBarButtonItem(image: UIImage(systemName: "hand.thumbsup.fill"), style: .plain, target: self, action: #selector(chatPositiveVote))

        // Negative vote button
        let thumbsDown = UIBarButtonItem(image: UIImage(systemName: "hand.thumbsdown.fill"), style: .plain, target: self, action: #selector(chatNegativeVote))

        // End chat button
        let endChat = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(chatEnd))

        // If custom chat rating is enable, add the three buttons above to the top of the modal window
        if (config.chatRating) {
            viewController.navigationItem.leftBarButtonItems = [endChat, thumbsUp, thumbsDown]
        }
        else {
            viewController.navigationItem.leftBarButtonItems = [endChat]
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = presenationStyle
        present(navigationController, animated: true)
    }

    // Chat - Positive vote
    @objc private func chatPositiveVote() {
        Chat.chatProvider?.sendChatRating(.good)
    }

    // Chat - Negative vote
    @objc private func chatNegativeVote() {
        Chat.chatProvider?.sendChatRating(.bad)
    }

    // End chat
    @objc private func chatEnd() {
        Chat.chatProvider?.endChat()
        navigationController?.dismiss(animated: true, completion: nil)
    }

}

/*
/////////////////////////////////////////////////////////////////////////////
// DO NOT CHANGE ANYTHING ON THIS FILE UNLESS YOU KNOW WHAT YOU'RE DOING   //
/////////////////////////////////////////////////////////////////////////////
*/
