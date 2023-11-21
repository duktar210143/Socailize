import 'package:discussion_forum/app/routes/app_routes.dart';
import 'package:discussion_forum/widgets/questions_text.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is home screen"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.loginRoute);
            },
            child: const Text(
              'SignOut',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      height: 200,
                      width: 200,
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1669951867704-a78fd21fbbd2?q=80&w=3164&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Flexible(
                      child: Text(
                        "Alberto deniria",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    // Text will be added later from an api end point
                    QuestionText(
                      question:
                          "What is web 3 and why are people so much invested into the space of web 3",
                    ),
                    QuestionText(
                      question:
                           '''I have a folder with a lot of sub-directories,
                            each with a .diff file that I want to perform a 
                            search in for a specific string using a batch script. Because of our IT requirements, 
                            I do not have access to powershell. I am trying to search for a specific string in the .
                           diff file, and summarize if it is found or not a summary file. ''',
                    ),
                    QuestionText(
                      question:
                          '''How can I center-align the TextInput
                           label from the TextInput component 
                          that comes with the React Native Paper library?''',
                    ),
                     QuestionText(
                      question:
                          '''I have a list of object that I want update. 
                          Basically I have created my object using spring but the content of the object is empty.
                           update the List of objects from a json file using Jackson parser.
                          The json file is compatible with the object. that means that 
                          I am letting the mapper to auto-detect the setters.''',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
