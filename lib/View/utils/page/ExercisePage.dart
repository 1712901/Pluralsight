import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Response/ResGetExercise.dart';
import 'package:Pluralsight/Core/models/Response/ResSubmitAnswers.dart';
import 'package:Pluralsight/Core/models/SubmitAnswers.dart';
import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/ExerciseService.dart';
import 'package:Pluralsight/View/utils/page/Constant.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  final String exerciseId;
  final String title;

  const ExercisePage({Key key, @required this.exerciseId,@required this.title}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  bool isLoading = true;
  List<ExercisesQuestion> listExercisesQuestion;
  ResGetExercise resGetExercise;
  CountdownTimerController timerController;
  int endTime;
  ResSubmitAnswers resSubmitAnswers;
  SubmitAnswers submitAnswersVar;
  bool submitted = false;

  @override
  void initState() {
    // TODO: implement initState
    initData(widget.exerciseId);
    submitAnswersVar =
        SubmitAnswers(exerciseId: widget.exerciseId, questions: []);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: Theme.of(context).appBarTheme.textTheme.headline4,),
      ),
      body: this.isLoading
          ? Container()
          : Column(
              children: [
                Container(
                  child: CountdownTimer(
                    endTime: endTime,
                    controller: timerController,
                    onEnd: onEnd,
                    widgetBuilder: (_, CurrentRemainingTime currentTime) {
                      if (currentTime == null) {
                        return Text(
                          "00:00",
                          style: Theme.of(context).textTheme.headline5,
                        );
                      }
                      if (currentTime.min == null) {
                        return Text(
                          "00:${currentTime.sec}",
                          style: Theme.of(context).textTheme.headline5,
                        );
                      }
                      return Text(
                        "${currentTime.min}:${currentTime.sec}",
                        style: Theme.of(context).textTheme.headline5,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: listExercisesQuestion.length,
                      itemBuilder: (context, index) =>
                          exerciseWidget(index, listExercisesQuestion[index])),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isDone()) {
            Toast.show(
                context: context, content: "Chưa trả lời tất cả các câu hỏi");
            return;
          }
          if (!submitted) submitAnswersFunc();
        },
        child: Icon(Icons.send),
      ),
    );
  }

  Widget exerciseWidget(int index, ExercisesQuestion exercisesQuestion) {
    if (getQuestion(exercisesQuestion.id) == null) {
      submitAnswersVar.questions
          .add(Question(id: exercisesQuestion.id, answers: []));
    }
    Question question = getQuestion(exercisesQuestion.id);
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Text(
              "${index + 1}. ",
              style: Theme.of(context).textTheme.headline6,
            ),
            title: Text(
              exercisesQuestion.content,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Column(
            children: exercisesQuestion.exercisesAnswers.map((e) {
              if (exercisesQuestion.isMultipleChoice) {
                return CheckboxListTile(
                    title: Text(
                      e.content,
                      style:getStyleMulti(question, e.id)),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: question.answers.contains(e.id),
                    onChanged: (value) {
                      if (!submitted) {
                        setState(() {
                          if (value) {
                            question.answers.add(e.id);
                          } else {
                            question.answers.remove(e.id);
                          }
                        });
                      }
                    });
              }
              String groupId;
              if (question.answers.isEmpty) {
                groupId = question.id;
              } else {
                groupId = question.answers[0];
              }
              return ListTile(
                title: Text(
                  e.content,
                  style: getStyle(exercisesQuestion.id, e.id, groupId),),
                leading: Radio(
                  focusColor: Colors.white,
                  value: e.id,
                  groupValue: groupId,
                  onChanged: (String value) {
                    if (!submitted)
                      setState(() {
                        if (question.answers.isEmpty) {
                          question.answers.add(value);
                        } else {
                          question.answers.clear();
                          question.answers.add(value);
                        }
                      });
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Question getQuestion(String exercisesQuestionId) {
    Question question = submitAnswersVar.questions
        .firstWhere((element) => element.id == exercisesQuestionId, orElse: () {
      return null;
    });
    return question;
  }

  bool isDone() {
    bool isDone = true;
    submitAnswersVar.questions.forEach((element) {
      if (element.answers.isEmpty) return isDone = false;
    });
    return isDone;
  }

  Future<ResGetExercise> getExercise(String exerciseId) async {
    AccountInf accountInf = Provider.of<AccountInf>(context, listen: false);
    if (!accountInf.isAuthorization()) {
      return null;
    }
    var res = await ExerciseService.getQuestion(
        token: accountInf.token, exerciseId: exerciseId);
    print(res.body);
    if (res.statusCode == 200) {
      return ResGetExercise.fromJson(jsonDecode(res.body));
    }
    return null;
  }

  Future<void> initData(String exerciseId) async {
    resGetExercise = await getExercise(exerciseId);
    if (resGetExercise == null) return null;
    setState(() {
      isLoading = false;
      listExercisesQuestion =
          resGetExercise.payload.exercises.exercisesQuestions;
      endTime = DateTime.now().millisecondsSinceEpoch +
          1000 * resGetExercise.payload.exercises.time * 60;
      timerController =
          CountdownTimerController(endTime: endTime, onEnd: onEnd);
    });
  }

  void onEnd() {
    if (!submitted) submitAnswersFunc();
  }

  Future<void> submitAnswersFunc() async {
    timerController.disposeTimer();
    AccountInf accountInf = Provider.of<AccountInf>(context, listen: false);
    var res = await ExerciseService.submitAnswers(
        token: accountInf.token, submitExercise: this.submitAnswersVar);
    print(res.body);
    if (res.statusCode == 200) {
      setState(() {
        this.submitted = true;
        resSubmitAnswers = resSubmitAnswersFromJson(res.body);
      });
    }
  }

  TextStyle getStyle(String questionId, String value, String groupId) {
    if (resSubmitAnswers == null) {
      return Theme.of(context).textTheme.subtitle1;
    }
    if (value == groupId) {
      if (resSubmitAnswers.payload.result.answerSheet[questionId]
          .contains(value)) return TextStyle(color: Colors.green);
      return TextStyle(color: Colors.red);
    }
    if (resSubmitAnswers.payload.result.answerSheet[questionId].contains(value))
      return TextStyle(color: Colors.green);
    return Theme.of(context).textTheme.subtitle1;
  }
  TextStyle getStyleMulti( Question question,String value){
    if (resSubmitAnswers == null) {
      return Theme.of(context).textTheme.subtitle1;
    }
    if (resSubmitAnswers.payload.result.answerSheet[question.id].contains(value))
      return TextStyle(color: Colors.green);

    if(question.answers.contains(value)){
      return TextStyle(color: Colors.red);
    }
    return Theme.of(context).textTheme.subtitle1;
  }
}
