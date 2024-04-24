import 'package:flutter/material.dart';

import 'answers_screen.dart';

class ResultsScreen extends StatelessWidget {
  final int grade;
  const ResultsScreen({Key? key, required this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Results",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getTextGrade(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            Text(
              "$grade/100",
              style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnswersScreen(),
                  ),
                );
              },
              child: Text(
                "Check correct answers",
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTextGrade() {
    if (grade < 50) {
      return "Failure";
    } else if (grade >= 50 && grade < 60) {
      return "Pass";
    } else if (grade >= 60 && grade < 70) {
      return "Good";
    } else if (grade >= 70 && grade < 90) {
      return "Very Good";
    } else {
      return "Excellent";
    }
  }
}
