//
//  ZendeskChat.swift
//  Zendesk Demo
//
//  Created by Marcelo De Bortoli  on 07/10/2020.
//  Copyright © 2020 EMEA Presales. All rights reserved.
//

import Foundation
import MessagingSDK
import MessagingAPI
import ChatSDK
import ChatProvidersSDK

final class ZendeskChat {
    static let instance = ZendeskChat()

    func initialize() {
        setChatLogging(isEnabled: true, logLevel: .verbose)
        Chat.initialize(accountKey: config.chatKey)
    }

    func setChatLogging(isEnabled: Bool, logLevel: LogLevel) {
        Logger.isEnabled = isEnabled
        Logger.defaultLevel = logLevel
    }

    var messagingConfiguration: MessagingConfiguration {
        let messagingConfiguration = MessagingConfiguration()
        messagingConfiguration.name = "Chat Bot"
        messagingConfiguration.isMultilineResponseOptionsEnabled = true
        return messagingConfiguration
    }

    var chatConfiguration: ChatConfiguration {
        let chatConfiguration = ChatConfiguration()
        chatConfiguration.isAgentAvailabilityEnabled = false
        chatConfiguration.isPreChatFormEnabled = true
        return chatConfiguration
    }

    var chatAPIConfig: ChatAPIConfiguration {
        let chatAPIConfig = ChatAPIConfiguration()
        chatAPIConfig.tags = ["iOS", "chat_v2"]
        return chatAPIConfig
    }

    // MARK: View Controllers
    func buildMessagingViewController() throws -> UIViewController {
        Chat.instance?.configuration = chatAPIConfig
        return try Messaging.instance.buildUI(engines: engines,
                                              configs: [messagingConfiguration, chatConfiguration])
    }
}

extension ZendeskChat {

    var engines: [Engine] {
        let engineTypes: [Engine.Type] = [ChatEngine.self]
        return engines(from: engineTypes)
    }

    func engines(from engineTypes: [Engine.Type]) -> [Engine] {
        engineTypes.compactMap { type -> Engine? in
            switch type {
            case is ChatEngine.Type:
                return try? ChatEngine.engine()
            default:
                fatalError("Unhandled engine of type: \(type)")
            }
        }
    }
}
