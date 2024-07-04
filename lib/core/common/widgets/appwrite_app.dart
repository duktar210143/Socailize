import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

const streamKey = '3aqm9b2nkupq';
var logger = log.Logger();

// extensions can be used to add functionality to existing classes
extension StreamChatContext on BuildContext {
  // fetches the current user image
  String? get currentUserImage => StreamChatCore.of(this).currentUser?.image;

  // fetches the currentuser user
  User? get currentUser => StreamChatCore.of(this).currentUser;
}