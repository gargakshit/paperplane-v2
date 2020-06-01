import 'dart:io';

import 'chat_service.dart';
import '../locator.dart';

import '../../constants/api.dart';

class ChatServiceTcp extends ChatService {
  Socket socket;

  @override
  Future<void> connect() async {
    socket = await Socket.connect(tcpHost, tcpPort);
  }

  @override
  Future<void> disconnect() async {
    await socket.close();
  }
}
