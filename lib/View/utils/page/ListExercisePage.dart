import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Response/ResGetListExerciseLession.dart';
import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/ExerciseService.dart';
import 'package:Pluralsight/Core/service/LessonService.dart';
import 'package:Pluralsight/View/utils/page/ExercisePage.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListExercisePage extends StatefulWidget {
  final String lessonId;

  const ListExercisePage({Key key, @required this.lessonId}) : super(key: key);

  @override
  _ListExercisePageState createState() => _ListExercisePageState();
}

class _ListExercisePageState extends State<ListExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.Exercise, style: Theme
              .of(context)
              .appBarTheme
              .textTheme
              .headline4,),
        ),
        body: FutureBuilder(
          future: getListExercise(widget.lessonId),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
              ResGetListExercise res=snapshot.data;
              print("ResGetListExercise:${res.data}");
              List<Exercise> list=res.data.exercises;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => makeQuestion(list[index]));
            }else{
              return Container();
            }
          }
        )
    );
  }

  Widget makeQuestion(Exercise exercise) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.grey,
              ))),
      child: ListTile(
        title: Text(exercise.title,style: Theme.of(context).textTheme.subtitle1,),
        trailing: Icon(Icons.menu_book,color: Theme.of(context).iconTheme.color,),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ExercisePage(exerciseId: exercise.id,title: exercise.title,)));
        },
      ),
    );
  }

  Future<ResGetListExercise> getListExercise(String lessonId) async {
    AccountInf accountInf = Provider.of<AccountInf>(context, listen: false);
    if (!accountInf.isAuthorization()) {
      Toast.show(context: context, content: S.current.NotLogin);
      return null;
    }
    else {
      var res = await ExerciseService.getListExerciseLesson(token: accountInf.token,lessonId: lessonId);
      print(res.body);
      if(res.statusCode==200){
        return ResGetListExercise.fromJson(jsonDecode(res.body));
      }else{
        return null;
      }
    }
  }
}
