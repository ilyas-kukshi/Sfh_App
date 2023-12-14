import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class FeedbackAndSuggestions extends StatefulWidget {
  const FeedbackAndSuggestions({super.key});

  @override
  State<FeedbackAndSuggestions> createState() => _FeedbackAndSuggestionsState();
}

class _FeedbackAndSuggestionsState extends State<FeedbackAndSuggestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: "Feedback & Suggestions", context: context),
          body: Column(
            children: [
              Text("How do you rate the concept of the app?"),
              
            ],
          ),
    );
  }
}
