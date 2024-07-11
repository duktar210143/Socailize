// // appwrite_service.dart

// import 'package:appwrite/appwrite.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final appwriteServiceProvider = Provider<AppwriteService>((ref) {
//   return AppwriteService();
// });

// class AppwriteService {
//   late Client client;
//   late Account account;
//   late Storage storage;
//   late  users;

//   AppwriteService() {
//     client = Client()
//         .setEndpoint('YOUR_ENDPOINT') // Your Appwrite Endpoint
//         .setProject('YOUR_PROJECT_ID') // Your project ID
//         .setSelfSigned(status: true); // For self-signed certificates

//     account = Account(client);
//     storage = Storage(client);
//     users = users(client);
//   }
// }