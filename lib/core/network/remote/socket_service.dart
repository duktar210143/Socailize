import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../../config/constants/api_end_points.dart';

final socketServiceProvider = Provider<SocketService>((ref) {
  return SocketService();
});

class SocketService {
  final io.Socket socket;

  SocketService()
      : socket = io.io(ApiEndPoints.socketUrl, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });

  void connect() {
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }

  void setup(dynamic user) {
    socket.emit('setup', user);
  }

  void sendNewReply(dynamic replyData) {
    socket.emit('new reply', replyData);
  }

void addEventListener(String event, Function(dynamic) callback) {
  socket.on(event, callback);
}

void removeEventListener(String event) {
  socket.off(event);
}


  void dispose() {
    socket.dispose();
  }
}
