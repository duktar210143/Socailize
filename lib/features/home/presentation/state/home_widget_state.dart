import 'package:discussion_forum/features/authentication/presentation/view/user_detail_view.dart';
import 'package:discussion_forum/features/question/presentation/view/add_question_view.dart';
import 'package:discussion_forum/features/home/presentation/view/dummy_dashboard_view.dart';
import 'package:discussion_forum/features/question/presentation/view/public_question_view.dart';
import 'package:flutter/material.dart';

class HomeState {
  final int index;
  final List<Widget> lstWidgets;

  HomeState({required this.index, required this.lstWidgets});

 
  HomeState.initialState()
      : index = 0,
        lstWidgets =  [
          const PublicQuestionView(),
          const StackOverflowDashboard(),
           const AddQuestionView(),
         const UserDetailView(),
         const StackOverflowDashboard(),
        ];
  // copyWith function to chnage the index no

  HomeState copywith({
    int? index
  }){
    return HomeState(index: index??this.index, lstWidgets: lstWidgets);
  }

}
