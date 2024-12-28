
import 'package:flutter/material.dart';
import 'package:freelancer_app/addSkill/quiz_resultpage.dart';
import 'package:freelancer_app/quiz/quiz_resultpage.dart';

import '../quiz/quiz_answer.dart';


class mobileQuiz extends StatefulWidget {


  String jobtype1;


  mobileQuiz(
      this.jobtype1,
      );

  @override
  _mobileQuizState createState() => _mobileQuizState();



}

class _mobileQuizState extends State<mobileQuiz> {
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
    'question': 'What is the difference between native and hybrid mobile app development?',
    'answers': [
      {'answerText': 'Native apps are built for one platform, while hybrid apps can run on multiple platforms.', 'score': true},
      {'answerText': 'Hybrid apps are built for one platform, while native apps can run on multiple platforms.', 'score': false},
      {'answerText': 'Native apps are built using web technologies, while hybrid apps are built using native technologies.', 'score': false},
      {'answerText': 'Hybrid apps are built using web technologies, while native apps are built using native technologies.', 'score': false},
    ],
  },
  {
    'question': 'What is a mobile app prototype?',
    'answers': [
      {'answerText': 'A fully functional version of a mobile app.', 'score': false},
      {'answerText': 'A preliminary version of a mobile app used for testing and feedback.', 'score': true},
      {'answerText': 'A design document outlining the features of a mobile app.', 'score': false},
      {'answerText': 'A marketing document used to promote a mobile app.', 'score': false},
    ],
  },
  {
    'question': 'What is the difference between mobile web apps and native apps?',
    'answers': [
      {'answerText': 'Mobile web apps are accessed through a web browser, while native apps are installed directly on a device.', 'score': true},
      {'answerText': 'Native apps are accessed through a web browser, while mobile web apps are installed directly on a device.', 'score': false},
      {'answerText': 'Mobile web apps are built using native technologies, while native apps are built using web technologies.', 'score': false},
      {'answerText': 'Native apps are built using web technologies, while mobile web apps are built using native technologies.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app testing?',
    'answers': [
      {'answerText': 'To identify and fix bugs in a mobile app.', 'score': true},
      {'answerText': 'To promote a mobile app to potential users.', 'score': false},
      {'answerText': 'To design the user interface of a mobile app.', 'score': false},
      {'answerText': 'To develop new features for a mobile app.', 'score': false},
    ],
  },
  {
    'question': 'What is the difference between iOS and Android app development?',
    'answers': [
      {'answerText': 'iOS apps are built using Java, while Android apps are built using Swift.', 'score': false},
      {'answerText': 'iOS apps are developed using Xcode, while Android apps are developed using Android Studio.', 'score': true},
      {'answerText': 'iOS apps are built using Swift, while Android apps are built using Java.', 'score': false},
      {'answerText': 'iOS apps are developed using Android Studio, while Android apps are developed using Xcode.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app analytics?',
    'answers': [
      {'answerText': 'To identify and fix bugs in a mobile app.', 'score': false},
      {'answerText': 'To design the user interface of a mobile app.', 'score': false},
      {'answerText': 'To track user behavior and app performance.', 'score': true},
      {'answerText': 'To develop new features for a mobile app.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app localization?',
    'answers': [
      {'answerText': 'To optimize a mobile app for faster performance.', 'score': false},
      {'answerText': 'To improve the user interface and user experience of a mobile app.', 'score': false},
      {'answerText': 'To translate a mobile app into multiple languages.', 'score': true},
      {'answerText': 'To promote a mobile app to potential users.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app user testing?',
    'answers': [
      {'answerText': 'To identify and fix bugs in a mobile app.','score': false},
      {'answerText': 'To gather feedback from real users about the user interface and user experience of a mobile app.', 'score': true},
      {'answerText': 'To develop new features for a mobile app.', 'score': false},
      {'answerText': 'To track user behavior and app performance.', 'score': false},
    ],
  },
  {
    'question': 'What is the difference between mobile app design and mobile app development?',
    'answers': [
      {'answerText': 'Mobile app design involves creating the user interface and user experience of a mobile app, while mobile app development involves coding and building the app.', 'score': true},
      {'answerText': 'Mobile app design and mobile app development are the same thing.', 'score': false},
      {'answerText': 'Mobile app design involves testing and optimizing the performance of a mobile app, while mobile app development involves marketing and promoting the app.', 'score': false},
      {'answerText': 'Mobile app design involves translating the app into multiple languages, while mobile app development involves creating new features for the app.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app push notifications?',
    'answers': [
      {'answerText': 'To track user behavior and app performance.', 'score': false},
      {'answerText': 'To promote a mobile app to potential users.', 'score': false},
      {'answerText': 'To send important updates and information to users even when they are not actively using the app.', 'score': true},
      {'answerText': 'To gather feedback from real users about the user interface and user experience of a mobile app.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app security testing?',
    'answers': [
      {'answerText': 'To identify and fix bugs in a mobile app.', 'score': false},
      {'answerText': 'To track user behavior and app performance.', 'score': false},
      {'answerText': 'To test the security vulnerabilities of a mobile app and fix any potential risks.', 'score': true},
      {'answerText': 'To develop new features for a mobile app.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app onboarding?',
    'answers': [
      {'answerText': 'To track user behavior and app performance.', 'score': false},
      {'answerText': 'To promote a mobile app to potential users.', 'score': false},
      {'answerText': 'To guide new users through the features and functionality of a mobile app and help them get started.', 'score': true},
      {'answerText': 'To gather feedback from real users about the user interface and user experience of a mobile app.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app A/B testing?',
    'answers': [
      {'answerText': 'To identify and fix bugs in a mobile app.', 'score': false},
      {'answerText': 'To track user behavior and app performance.', 'score': false},
      {'answerText': 'To test two different versions of a mobile app with a subset of users to see which version performs better.', 'score': true},
      {'answerText': 'To develop new features for a mobile app.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app caching?',
    'answers': [
      {'answerText': 'To track user behavior and app performance.', 'score': false},
      {'answerText': 'To improve the user interface and user experience of a mobile app.', 'score': false},
      {'answerText': 'To store frequently accessed data locally on a device to improve app performance and reduce data usage.', 'score': true},
      {'answerText': 'To promote a mobile app to potential users.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of mobile app crash reporting?',
    'answers': [
      {'answerText': 'To track user behavior and app performance.', 'score': false},
      {'answerText': 'To identify and fix bugs in a mobile app.', 'score': true},
      {'answerText': 'To test the security vulnerabilities of a mobile app and fix any potential risks.', 'score': false},
      {'answerText': 'To develop new features for a mobile app.', 'score': false},
    ],
  },
];

