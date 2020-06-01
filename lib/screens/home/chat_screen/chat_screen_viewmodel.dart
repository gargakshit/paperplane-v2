import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../constants/api.dart';

class ChatScreenViewModel extends ChangeNotifier {
  Socket socket;

  initSocket() async {
    socket = await Socket.connect(tcpHost, tcpPort);

    socket.listen((event) {
      print(base64.decode(String.fromCharCodes(event).trim()));

      deferSocket();
    });
  }

  deferSocket() async {
    await socket.close();
  }
}
