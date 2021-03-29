//
//  AppDelegate.swift
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
import WebKit
import ZendeskCoreSDK
import SupportProvidersSDK
import AnswerBotProvidersSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initialize SupportSDK - Change it accordingly to your demo instance (go to the "Mobile SDK" link on your Support panel and paste the Swift code below)
        Zendesk.initialize(appId: config.appId,
                           clientId: config.clientId,
                           zendeskUrl: config.zendeskUrl)
        Support.initialize(withZendesk: Zendesk.instance)

        // Initialize Answer Bot with instances of Zendesk and Support singletons
        guard let support = Support.instance else { return false }
        AnswerBot.initialize(withZendesk: Zendesk.instance, support: support)

        // Set Fake Identity
        let identity = Identity.createAnonymous(name: config.identityName, email: config.identityEmail)
        Zendesk.instance?.setIdentity(identity)

        ZendeskChat.instance.initialize()

        return true
    }

}

/*
/////////////////////////////////////////////////////////////////////////////
// DO NOT CHANGE ANYTHING ON THIS FILE UNLESS YOU KNOW WHAT YOU'RE DOING   //
/////////////////////////////////////////////////////////////////////////////
*/
