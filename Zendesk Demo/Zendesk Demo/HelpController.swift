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
import ZendeskSDK
import ZDCChat
import AnswerBotProvidersSDK
import AnswerBotSDK

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
        let answerBotUIConfiguration = AnswerBotUIConfiguration()
        let requestUIConfig = RequestUiConfiguration()
        requestUIConfig.subject = "Subject: Answer Bot"
        requestUIConfig.tags = ["Answer_Bot SDK", "SDK", "iOS"]
        guard let answerBotViewController = AnswerBotUI.buildAnswerBotUI(with: [answerBotUIConfiguration, requestUIConfig]) else { return }
        self.navigationController?.show(answerBotViewController, sender: self)
    }
    
    @IBAction func ChatButton(_ sender: UIButton) {
        ZDCChat.start(in: self.navigationController, withConfig: {config in
            config?.preChatDataRequirements.name = .optionalEditable
            config?.preChatDataRequirements.email = .requiredEditable
            config?.preChatDataRequirements.phone = .optional
            config?.preChatDataRequirements.department = .optionalEditable
            config?.preChatDataRequirements.message = .required
        })
    }
    
    @IBAction func RequestButton(_ sender: UIButton) {
        //Create a configuration object
        let config = RequestUiConfiguration()
        config.subject = "SDK Ticket"
        config.tags = ["iOS", "SDK"]
        //Present the SDK
        let requestScreen = RequestUi.buildRequestUi(with: [config])
        self.navigationController?.pushViewController(requestScreen, animated: true)
    }
    
    @IBAction func TicketsButton(_ sender: UIButton) {
        let requestList = RequestUi.buildRequestList(with: [])
        self.navigationController?.pushViewController(requestList, animated: true)
    }
}

/*
/////////////////////////////////////////////////////////////////////////////
// DO NOT CHANGE ANYTHING ON THIS FILE UNLESS YOU KNOW WHAT YOU'RE DOING   //
/////////////////////////////////////////////////////////////////////////////
*/
