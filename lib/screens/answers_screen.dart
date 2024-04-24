import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_session/cubits/app_cubit.dart';
import 'package:quiz_app_session/data/data.dart';


class AnswersScreen extends StatelessWidget {
  const AnswersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Answers",
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          "Question(${index + 1}/10)",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          data[index].title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ListView.separated(
                            itemBuilder: (context, i) {
                              Color backgroundColors = Colors.blueGrey.shade100;
                              Color textColor = Colors.black;
                              if(cubit.savedUserAnswers[data[index].id] == data[index].correctAnswerIndex){
                                if(i == data[index].correctAnswerIndex){
                                  backgroundColors = Colors.green;
                                  textColor = Colors.white;
                                }
                              }
                              else{
                                if(i ==  cubit.savedUserAnswers[data[index].id]){
                                  backgroundColors = Colors.red;
                                  textColor = Colors.white;
                                }
                                else if(i == data[index].correctAnswerIndex){
                                  backgroundColors = Colors.green;
                                  textColor = Colors.white;
                                }
                              }
                              return Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: backgroundColors,
                                  borderRadius: BorderRadius.circular(12.0)
                                ),
                                child: Center(
                                  child: Text(
                                    data[index].answers[i],
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10.0,
                              );
                            },
                            itemCount: data[index].answers.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: data.length, // 10
          );
        },
      ),
    );
  }
}
