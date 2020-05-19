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
import AnswerBotProvidersSDK
import AnswerBotSDK
import MessagingSDK
import MessagingAPI
import SDKConfigurations
import SupportSDK
import ChatSDK
import ChatProvidersSDK

class HelpController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        let chatAPIConfiguration = ChatAPIConfiguration()
        chatAPIConfiguration.visitorInfo = VisitorInfo(name: config.identityName, email: config.identityEmail, phoneNumber: config.identityPhone)
        Chat.instance?.configuration = chatAPIConfiguration
        
        let chatConfiguration = ChatConfiguration()
        chatConfiguration.isAgentAvailabilityEnabled = false
        chatConfiguration.chatMenuActions = [.emailTranscript, .endChat]
        
        do {
          let chatEngine = try ChatEngine.engine()
          let viewController = try Messaging.instance.buildUI(engines: [chatEngine], configs: [chatConfiguration])

          self.navigationController?.pushViewController(viewController, animated: true)
        } catch {
            print("ERROR")
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
        guard let number = URL(string: "tel://" + config.identityPhone) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
}

/*
/////////////////////////////////////////////////////////////////////////////
// DO NOT CHANGE ANYTHING ON THIS FILE UNLESS YOU KNOW WHAT YOU'RE DOING   //
/////////////////////////////////////////////////////////////////////////////
*/
