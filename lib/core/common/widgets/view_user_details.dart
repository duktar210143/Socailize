import 'package:flutter/material.dart';

class UserDetailsDialogBox {
  static void showUserNameDialog(BuildContext context, String firstName, String lastName, String userName, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 16,
          backgroundColor: Colors.transparent,
          child: _buildDialogContent(firstName, lastName, userName, email, context),
        );
      },
    );
  }

  static Widget _buildDialogContent(String firstName, String lastName, String userName, String email, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Information',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20.0),
          _buildUserDetail('First Name', firstName),
          _buildUserDetail('Last Name', lastName),
          _buildUserDetail('Username', userName),
          _buildUserDetail('Email', email),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildUserDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
