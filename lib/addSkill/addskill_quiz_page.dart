
import 'package:flutter/material.dart';
import 'package:freelancer_app/addSkill/quiz_resultpage.dart';
import 'package:freelancer_app/quiz/quiz_resultpage.dart';

import '../quiz/quiz_answer.dart';


class addSkillQuizpage extends StatefulWidget {


  String jobtype1;


  addSkillQuizpage(
      this.jobtype1,
      );

  @override
  _addSkillQuizpageState createState() => _addSkillQuizpageState();



}

class _addSkillQuizpageState extends State<addSkillQuizpage> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  bool isVisible=true;
  String? jobtype;


  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
      isVisible=false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => addskill_quiz_resultpage(
          _totalScore,
          jobtype),
      ));

    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    jobtype=widget.jobtype1;


    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Relax and take the Quiz',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Center(

        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  const SizedBox(
                    height: 25.0,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            Text(
             " ${jobtype!} Questions ",

              style: const TextStyle(
                fontSize: 28.0,
                fontFamily: "Quando",
              ),
            ),
            const SizedBox(height: 13,),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'] as String,

                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),


            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, dynamic>>)
                .map(
              (answer) => Quiz_Answer(
                answerText: answer['answerText'],
                 answerColor:Colors.green,


                answerTap: () {
                  // if answer was already selected then nothing happens onTap
                  if (answerWasSelected) {

                    return;
                  }
                  //answer is being selected
                  _questionAnswered(answer['score']);
                  isVisible=true;
                },
              ),
            ),


            const SizedBox(height: 20.0),




            Visibility(
              visible: isVisible,
              child: ElevatedButton(
                  onPressed: ()
                  {
                    if (!answerWasSelected) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please select an answer before going to the next question'),
                      ));
                      return;
                    }
                    _nextQuestion();

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    fixedSize: const Size(290, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                child: Text(endOfQuiz ? 'Check result' : 'Next Question',
                  style:TextStyle(fontSize: 18),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}






const _questions = [
  {
    'question': '1,What is the difference between a relational database and a non-relational database?',
    'answers': [
      {
        'answerText': 'A.A relational database is a database that stores data in tables, while a non-relational database does not.',
        'score': false
      },
      {
        'answerText': 'B.A relational database is a database that stores data in columns and rows, while a non-relational database does not.',
        'score': false
      },
      {
        'answerText': 'C.A relational database is a database that is easy to query, while a non-relational database is not.',
        'score': false
      },
      {
        'answerText': 'D.A relational database is a database that uses a relational model, while a non-relational database does not.',
        'score': true
      },
    ],
  },
  {
    'question': '2,What is a primary key?',
    'answers': [
      {
        'answerText': 'A.A primary key is a unique identifier for a row in a table.',
        'score': true
      },
      {
        'answerText': 'B.A primary key is a column in a table that cannot contain NULL values.',
        'score': false
      },
      {
        'answerText': 'C.A primary key is a column in a table that cannot be updated.',
        'score': false
      },
      {
        'answerText': 'D.A primary key is a column in a table that cannot be deleted.',
        'score': false
      },
    ],
  },
  {
    'question': '3,What is a foreign key?',
    'answers': [
      {
        'answerText': 'A.A foreign key is a column in a table that references a primary key in another table.',
        'score': true
      },
      {
        'answerText': 'B.A foreign key is a column in a table that cannot contain NULL values.',
        'score': false
      },
      {
        'answerText': 'C.A foreign key is a column in a table that cannot be updated.',
        'score': false
      },
      {
        'answerText': 'D.A foreign key is a column in a table that cannot be deleted.',
        'score': false
      },
    ],
  },
  {
    'question': '4,What is a database index?',
    'answers': [
      {
        'answerText': 'A.A database index is a data structure that improves the performance of queries on a database.',
        'score': true
      },
      {
        'answerText': 'B.A database index is a data structure that stores the location of data in a database.',
        'score': false
      },
      {
        'answerText': 'C.A database index is a data structure that prevents duplicate data from being stored in a database.',
        'score': false
      },
      {
        'answerText': 'D.A database index is a data structure that allows for faster data retrieval.',
        'score': true
      },
    ],
  },
  {
    'question': 'E5,What is a database normalization?',
    'answers': [
      {
        'answerText': 'A.A database normalization is a process of organizing data in a database to improve its performance and to reduce the risk of errors.',
        'score': true
      },
      {
        'answerText': 'B.A database normalization is a process of adding data to a database to improve its performance.',
        'score': false
      },
      {
        'answerText': 'C.A database normalization is a process of removing data from a database to improve its performance.',
        'score': false
      },

      {
        'answerText': 'D.A database normalization is a process of restructuring data in a database to improve its performance and to reduce the risk of errors.',
        'score':false
      },
    ],
  },
  {
    "question": "6,What is a relational database?",
    "answers": [
      {
        "answerText": "A.A database that stores data in tables.",
        "score": false
      },
      {
        "answerText": "B.A database that stores data in columns and rows.",
        "score": false
      },
      {
        "answerText": "C.A database that uses a relational model.",
        "score": true
      },
      {
        "answerText": "D.A database that is easy to query.",
        "score": false
      },
    ],
  },
  {
    "question": "7,What is a primary key?",
    "answers": [
      {
        "answerText": "A.A column in a table that cannot contain NULL values.",
        "score": false
      },
      {
        "answerText": "B.A column in a table that cannot be updated.",
        "score": false
      },
      {
        "answerText": "C.A column in a table that cannot be deleted.",
        "score": false
      },
      {
        "answerText": "D.A unique identifier for a row in a table.",
        "score": true
      },
    ],
  },
  {
    "question": "8,What is a foreign key?",
    "answers": [
      {
        "answerText": "A.A column in a table that cannot contain NULL values.",
        "score": false
      },
      {
        "answerText": "B.A column in a table that cannot be updated.",
        "score": false
      },
      {
        "answerText": "C.A column in a table that cannot be deleted.",
        "score": false
      },
      {
        "answerText": "D.A column in a table that references a primary key in another table.",
        "score": true
      },
    ],
  },
  {
    "question": "9,What is a database index?",
    "answers": [
      {
        "answerText": "A.A data structure that stores the location of data in a database.",
        "score": false
      },
      {
        "answerText": "B.A data structure that prevents duplicate data from being stored in a database.",
        "score": false
      },
      {
        "answerText": "C.A data structure that allows for faster data retrieval.",
        "score": true
      },
      {
        "answerText": "D.A data structure that improves the performance of queries on a database.",
        "score": false
      }
    ],
  },
  {
    "question": "10,What is a database normalization?",
    "answers": [
      {
        "answerText": "A.A process of adding data to a database to improve its performance.",
        "score": false
      },
      {
        "answerText": "B.A process of removing data from a database to improve its performance.",
        "score": false
      },
      {
        "answerText": "C.A process of restructuring data in a database to improve its performance and to reduce the risk of errors.",
        "score": true
      },
      {
        "answerText": "D.A process of organizing data in a database to improve its performance and to reduce the risk of errors.",
        "score": false
      },
    ],
  },


];

