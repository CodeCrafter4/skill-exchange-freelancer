
import 'package:flutter/material.dart';
import 'package:freelancer_app/addSkill/quiz_resultpage.dart';
import 'package:freelancer_app/quiz/quiz_resultpage.dart';

import '../quiz/quiz_answer.dart';


class backEndquiz extends StatefulWidget {


  String jobtype1;


  backEndquiz(
      this.jobtype1,
      );

  @override
  _backEndquizState createState() => _backEndquizState();



}

class _backEndquizState extends State<backEndquiz> {
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
    'question': '1,What is Node.js?',
    'answers': [
      {'answerText': 'A front-end JavaScript framework.', 'score': true},
      {'answerText': 'A back-end JavaScript runtime built on Chrome’s V8 JavaScript engine.', 'score': false},
      {'answerText': 'A database management system.', 'score': false},
      {'answerText': 'A markup language for web development.', 'score': false},
    ],
  },
  {
    'question': '2, What is a RESTful API?',
    'answers': [
      {'answerText': 'An API that is not reliable.', 'score': true},
      {'answerText': 'An API that uses SOAP to communicate.', 'score': false},
      {'answerText': 'An API that allows developers to use HTTP requests to GET, PUT, POST, and DELETE data.', 'score': false},
      {'answerText': 'An API that is used exclusively for mobile app development.', 'score': false},
    ],
  },
  {
    'question': '3, What is the difference between a PUT and a POST request?',
    'answers': [
      {'answerText': 'There is no difference.', 'score': true},
      {'answerText': 'PUT is used for updating an existing resource, while POST is used for creating a new resource.', 'score': false},
      {'answerText': 'POST is used for updating an existing resource, while PUT is used for creating a new resource.', 'score': false},
      {'answerText': 'PUT is used for retrieving data, while POST is used for sending data.', 'score': false},
    ],
  },
  {
    'question': '4, What is SQL injection?',
    'answers': [
      {'answerText': 'A technique used to inject malicious code into a website.', 'score': true},
      {'answerText': 'A way to optimize SQL queries for better performance.', 'score': false},
      {'answerText': 'A method of encrypting SQL data for increased security.', 'score': false},
      {'answerText': 'A way of testing the speed of an SQL database.', 'score': false},
    ],
  },
  {
    'question': '5, What is ORM?',
    'answers': [
      {'answerText': 'A method for storing and retrieving data from a database.', 'score': true},
      {'answerText': 'An object-relational mapping tool that allows developers to interact with databases using object-oriented programming techniques.', 'score': false},
      {'answerText': 'A programming language that is used to create web applications.', 'score': false},
      {'answerText': 'A database management system that uses object-oriented principles.', 'score': false},
    ],
  },
  {
    'question': '6, What is a NoSQL database?',
    'answers': [
      {'answerText': 'A database that does not use SQL.', 'score': true},
      {'answerText': 'A database that has no data.', 'score': false},
      {'answerText': 'A database that only stores text data.', 'score': false},
      {'answerText': 'A database that is not relational.', 'score': false},
    ],
  },
  {
    'question': '7, What is a connection pool?',
    'answers': [
      {'answerText': 'A way of limiting the number of connections to a database.', 'score': true},
      {'answerText': 'A way of increasing the number of connections to a database.', 'score': false},
      {'answerText': 'A way of connecting to a database using a pool of IP addresses.', 'score': false},
      {'answerText': 'A way of managing sessions in a web application.', 'score': false},
    ],
  },
  {
    'question': '8, What is a web server?',
    'answers': [
      {'answerText': 'A server that only serves web pages.', 'score': true},
      {'answerText': 'A server that can serve any type of file over HTTP.', 'score': false},
      {'answerText': 'A server that only serves JSON data.', 'score': false},
      {'answerText': 'A server that is used for testing web applications.', 'score': false},
    ],
  },
  {
    'question': '9, What is a load balancer?',
    'answers': [
      {'answerText': 'A device that balances the weight of heavy objects.', 'score': true},
      {'answerText': 'A device that balances the load of incoming network traffic across multiple servers.', 'score': false},
      {'answerText': 'A device that balances the load of incoming HTTP requests across multiple endpoints.', 'score': false},
      {'answerText': 'A device that balances the load of incoming database queries across multiple nodes.', 'score': false},
    ],
  },
  {
    'question':'10, What is a middleware?',
    'answers': [
      {'answerText': 'A piece of software that runs on the client side of a web application.', 'score': true},
      {'answerText': 'A piece of software that runs on the server side of a web application, between the request and response.', 'score': false},
      {'answerText': 'A piece of hardware that connects servers in a network.', 'score': false},
      {'answerText': 'A piece of software that manages database queries in a web application.', 'score': false},
    ],
  },
  {
    'question': '11, What is an API gateway?',
    'answers': [
      {'answerText': 'A tool for managing and monitoring API requests.', 'score': true},
      {'answerText': 'A tool for creating APIs.', 'score': false},
      {'answerText': 'A tool for testing APIs.', 'score': false},
      {'answerText': 'A tool for documenting APIs.', 'score': false},
    ],
  },
  {
    'question': '12, What is serverless computing?',
    'answers': [
      {'answerText': 'A way of hosting web applications without a server.', 'score': true},
      {'answerText': 'A way of hosting web applications on a third-party server.', 'score': false},
      {'answerText': 'A way of running code without managing servers or infrastructure.', 'score': false},
      {'answerText': 'A way of running code that requires a dedicated server.', 'score': false},
    ],
  },
  {
    'question': '13, What is a container?',
    'answers': [
      {'answerText': 'A piece of hardware that stores data.', 'score': true},
      {'answerText': 'A virtual environment that can run an application and its dependencies.', 'score': false},
      {'answerText': 'A storage container for files.', 'score': false},
      {'answerText': 'A piece of software that manages database connections.', 'score': false},
    ],
  },
  {
    'question': '14, What is Docker?',
    'answers': [
      {'answerText': 'A containerization platform for building, shipping, and running applications.', 'score': true},
      {'answerText': 'A cloud-based storage service for container images.', 'score': false},
      {'answerText': 'A container management system for Kubernetes.', 'score': false},
      {'answerText': 'A tool for building and testing web applications.', 'score': false},
    ],
  },
  {
    'question': '15,What is a microservice architecture?',
    'answers': [
      {'answerText': 'A way of building web applications using a single, monolithic code base.', 'score': true},
      {'answerText': 'A way of building web applications using multiple, small, independent services that communicate with each other.', 'score': false},
      {'answerText': 'A way of building web applications using a single, large, independent service.', 'score': false},
      {'answerText': 'A way of building web applications using a client-server model.', 'score': false},
    ],
  },

];

