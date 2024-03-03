import 'package:flutter/material.dart';

class UserDetailsDialogBox {
  static void showUserNameDialog(BuildContext context, String firstName,
      String lastName, String userName, String image, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 16,
          backgroundColor: Colors.transparent,
          child: _buildDialogContent(
              firstName, lastName, userName, email, image, context),
        );
      },
    );
  }

  static Widget _buildDialogContent(String firstName, String lastName,
      String userName, String email, String image, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'User Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(image),
            ),
          ),
          const SizedBox(height: 20.0),
          _buildUserDetail('First Name', firstName, context),
          _buildUserDetail('Last Name', lastName, context),
          _buildUserDetail('Username', userName, context),
          _buildUserDetail('Email', email, context),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildUserDetail(
      String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
