import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../constants/api.dart';
import '../../../services/locator.dart';
import '../../../services/chat/chat_service.dart';

class ChatScreenViewModel extends ChangeNotifier {
  Socket socket;
  ChatService chatService;

  init() async {
    chatService = locator<ChatService>();

    await chatService.connect();
  }

  initSocket() async {
    socket = await Socket.connect(tcpHost, tcpPort);

    socket.listen((event) {
      print(base64.decode(String.fromCharCodes(event).trim()));

      deferSocket();
    });
  }

  deferSocket() async {
    await chatService.disconnect();
  }
}
