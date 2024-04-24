import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_session/cubits/app_cubit.dart';
import 'package:quiz_app_session/data/data.dart';
import 'package:quiz_app_session/screens/results_screen.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<int,int> userChoices = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: Colors.white,
       title: const Text(
         "Quiz 1",
         style: TextStyle(
           color: Colors.black,
           fontWeight: FontWeight.bold,
           fontSize: 24.0
         ),
       ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    itemBuilder: (context, i) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              "Question(${i + 1}/10)",
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              data[i].title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 38.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ListView.separated(
                              //0 , 1 , 2 , 3
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    userChoices[data[i].id] = index;
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: userChoices[data[i].id] == null ? Colors.grey.shade200:
                                      userChoices[data[i].id] ==index ? Colors.black:Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          data[i].answers[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 29.0,
                                            color: userChoices[data[i].id] == null ? Colors.black:
                                            userChoices[data[i].id] ==index ? Colors.white:Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20.0,
                                );
                              },
                              itemCount: data[i].answers.length,
                              // List is not scrollable
                              physics: const NeverScrollableScrollPhysics(),
                              // config the space only for choice
                              shrinkWrap: true,
                            ),
                          ],
                        ),
                      );
                    },
                  itemCount: data.length,
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    if(userChoices.length < data.length){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Complete all quiz questions"),backgroundColor: Colors.red,),
                      );
                    }
                    else{
                      int finalGrade = 0;
                      for(var element in data){
                        int userAnswer = userChoices[element.id]!;
                        if(userAnswer == element.correctAnswerIndex){
                          finalGrade += 10;
                        }
                      }
                      cubit.saveUserAnswers(screenResult: userChoices);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return ResultsScreen(grade: finalGrade);
                              },
                          ),
                      );
                    }
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity,55),
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                  child: const Text("Confirm Answers"),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
