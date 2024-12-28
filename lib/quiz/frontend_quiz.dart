
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_app/quiz/quiz_home.dart';
import 'package:freelancer_app/quiz/quiz_resultpage.dart';

import 'quiz_answer.dart';

class frontEnd_quiz extends StatefulWidget {


  String jobtype1;
  frontEnd_quiz(this.jobtype1);

  @override
  _frontEnd_quizState createState() => _frontEnd_quizState();



}

class _frontEnd_quizState extends State<frontEnd_quiz> {
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
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => QuizHomePage(),
      // ));

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
              jobtype!+" Questions",

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


            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '${_totalScore.toString()}/${_questions.length}',
                style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),

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
                  primary: Colors.lightBlue,
                  fixedSize: const Size(290, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(endOfQuiz ? 'your done Retake Quiz' : 'Next Question',
                  style:TextStyle(fontSize: 18),),
              ),
            ),
            const SizedBox(height: 15,),
            if (endOfQuiz)

              ElevatedButton(
                  onPressed: ()
                  {
                    if (endOfQuiz) {

                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //   builder: (context) => Quiz_resultpage( _totalScore, jobtype),
                      // ));
                      return;
                    }
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "first finish your questions");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    fixedSize: const Size(290, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "check Result",
                    style: TextStyle(fontSize: 18,),
                  )
              ),
          ],
        ),
      ),
    );
  }
}

// const  _questions =[
//   {
//     'question': 'How long is New Zealand’s Ninety Mile Beach?',
//     'answers': [
//       {'answerText': '88km, so 55 miles long.', 'score': false},
//       {'answerText': '55km, so 34 miles long.', 'score': false},
//       {'answerText': '90km, so 56 miles long.', 'score': true},
//     ],
//   },
//   {
//     'question':
//         'In which month does the German festival of Oktoberfest mostly take place?',
//     'answers': [
//       {'answerText': 'January', 'score': false},
//       {'answerText': 'October', 'score': false},
//       {'answerText': 'September', 'score': true},
//     ],
//   },
//   {
//     'question': 'Who composed the music for Sonic the Hedgehog 3?',
//     'answers': [
//       {'answerText': 'Britney Spears', 'score': false},
//       {'answerText': 'Timbaland', 'score': false},
//       {'answerText': 'Michael Jackson', 'score': true},
//     ],
//   },
//   {
//     'question': 'In Georgia (the state), it’s illegal to eat what with a fork?',
//     'answers': [
//       {'answerText': 'Hamburgers', 'score': false},
//       {'answerText': 'Fried chicken', 'score': false},
//       {'answerText': 'Pizza', 'score': true},
//     ],
//   },
//   {
//     'question':
//         'Which part of his body did musician Gene Simmons from Kiss insure for one million dollars?',
//     'answers': [
//       {'answerText': 'His tongue', 'score': false},
//       {'answerText': 'His leg', 'score': false},
//       {'answerText': 'His butt', 'score': true},
//     ],
//   },
//   {
//     'question': 'In which country are Panama hats made?',
//     'answers': [
//       {'answerText': 'Ecuador', 'score': false},
//       {'answerText': 'Panama (duh)', 'score': false},
//       {'answerText': 'Portugal', 'score': true},
//     ],
//   },
//   {
//     'question': 'From which country do French fries originate?',
//     'answers': [
//       {'answerText': 'Belgium', 'score': false},
//       {'answerText': 'France (duh)', 'score': false},
//       {'answerText': 'Switzerland', 'score': true},
//     ],
//   },
//   {
//     'question': 'Which sea creature has three hearts?',
//     'answers': [
//       {'answerText': 'Great White Sharks', 'score': false},
//       {'answerText': 'Killer Whales', 'score': false},
//       {'answerText': 'The Octopus', 'score': true},
//     ],
//   },
//   {
//     'question': 'Which European country eats the most chocolate per capital?',
//     'answers': [
//       {'answerText': 'Belgium', 'score': false},
//       {'answerText': 'The Netherlands', 'score': false},
//       {'answerText': 'Switzerland', 'score': true},
//     ],
//   },
// ];




const _questions = [
{
'question': 'What is the most common programming language for front-end development?',
'answers': [
{'answerText': 'JavaScript', 'score': true},
{'answerText': 'Python', 'score': false},
{'answerText': 'Java', 'score': false},
{'answerText': 'C++', 'score': false},
],
},
{
'question': 'What is the most popular framework for front-end development?',
'answers': [
{'answerText': 'React', 'score': true},
{'answerText': 'Angular', 'score': false},
{'answerText': 'Vue.js', 'score': false},
{'answerText': 'Ember.js', 'score': false},
],
},
{
'question': 'What is the difference between a component and a directive in Angular?',
'answers': [
{'answerText': 'A component is a reusable piece of code that can be used to create a user interface, while a directive is a piece of code that can be used to modify the behavior of an existing element.', 'score': true},
{'answerText': 'A component is a type of directive, while a directive is not a type of component.', 'score': false},
{'answerText': 'A component is a more complex piece of code than a directive.', 'score': false},
{'answerText': 'A directive is a more complex piece of code than a component.', 'score': false},
],
},
{
'question': 'What is the difference between a class component and a functional component in React?',
'answers': [
{'answerText': 'A class component is a more traditional way of creating a React component, while a functional component is a newer way of creating a React component that uses the power of JavaScript functions.', 'score': true},
{'answerText': 'A class component is a more complex piece of code than a functional component.', 'score': false},
{'answerText': 'A functional component is a more complex piece of code than a class component.', 'score': false},
{'answerText': 'A class component is not supported by React, while a functional component is.', 'score': false},
],
},
{
'question': 'What is the difference between an event handler and a lifecycle hook in React?',
'answers': [
{'answerText': 'An event handler is a function that is called when an event occurs, while a lifecycle hook is a function that is called at a specific point in the life cycle of a component.', 'score': true},
{'answerText': 'An event handler is a more complex piece of code than a lifecycle hook.', 'score': false},
{'answerText': 'A lifecycle hook is a more complex piece of code than an event handler.', 'score': false},
{'answerText': 'Event handlers and lifecycle hooks are the same thing.', 'score': false},
],
},
{
'question': 'What is the difference between a state variable and a prop in React?',
'answers': [
{'answerText': 'A state variable is a variable that is local to a component, while a prop is a variable that is passed to a component from its parent.', 'score': true},
{'answerText': 'A state variable is a more complex piece of code than a prop.', 'score': false},
{'answerText': 'A prop is a more complex piece of code than a state variable.', 'score': false},
{'answerText': 'State variables and props are the same thing.','score': false},
],
},


{
'question': 'What is the purpose of a state variable?',
'answers': [
{'answerText': 'To store data that is local to a component.', 'score': true},
{'answerText': 'To store data that is passed to a component from its parent.', 'score': false},
{'answerText': 'To store data that is shared between components.', 'score': false},
{'answerText': 'To store data that is not used by the component.', 'score': false},
],
},
{
'question': 'What is the purpose of a prop?',
'answers': [
{'answerText': 'To store data that is local to a component.', 'score': false},
{'answerText': 'To store data that is passed to a component from its parent.', 'score': true},
{'answerText': 'To store data that is shared between components.', 'score': false},
{'answerText': 'To store data that is not used by the component.', 'score': false},
],
},
{
'question': 'How do you update the state of a component?',
'answers': [
{'answerText': 'Use the setState() method.', 'score': true},
{'answerText': 'Use the setProps() method.', 'score': false},
{'answerText': 'Use the update() method.', 'score': false},
{'answerText': 'Use the change() method.', 'score': false},
],
},
{
'question': 'What is the difference between a class component and a functional component in terms of state management?',
'answers': [
{'answerText': 'Class components use the this.state property to store state, while functional components use the useState() hook to store state.', 'score': true},
{'answerText': 'Class components use the this.props property to store props, while functional components use the useProps() hook to store props.', 'score': false},
{'answerText': 'Class components are more complex than functional components in terms of state management.', 'score': false},
{'answerText': 'Functional components are more complex than class components in terms of state management.', 'score': false},
],
},
{
'question': 'What is the purpose of the useState() hook?',
'answers': [
{'answerText': 'To store state in a functional component.', 'score': true},
{'answerText': 'To store props in a functional component.', 'score': false},
{'answerText': 'To update the state of a functional component.', 'score': false},
{'answerText': 'To create a new functional component.', 'score': false},
],
},
{
'question': 'What is the difference between the useState() hook and the this.state property in a class component?',
'answers': [
{'answerText': 'The useState() hook is more concise and easier to use than the this.state property.', 'score': true},
{'answerText': 'The useState() hook is more powerful than the this.state property.', 'score': false},
{'answerText': 'The useState() hook is more flexible than the this.state property.', 'score': false},
{'answerText': 'The useState() hook is more efficient than the this.state property.', 'score': false},
],
},
{
'question': 'What is the purpose of the useEffect() hook?',
'answers': [
{'answerText': 'To perform side effects in a functional component.', 'score': true},
{'answerText': 'To store state in a functional component.', 'score': false},
{'answerText': 'To update the state of a functional component.', 'score': false},
{'answerText': 'To create a new functional component.', 'score': false},
],
},
{
'question': 'What is the difference between the useEffect() hook and the componentDidMount() and componentDidUpdate() lifecycle methods in a class component?',
'answers': [
{'answerText': 'The useEffect() hook is more concise and easier to use than the componentDidMount() and componentDidUpdate() lifecycle methods.', 'score': true},
{'answerText': 'The useEffect() hook is more powerful than the componentDidMount() and componentDidUpdate() lifecycle methods.', 'score': false},
{'answerText': 'The useEffect() hook is more flexible than the componentDidMount() and componentDidUpdate() lifecycle methods.', 'score': false},
{'answerText': 'The useEffect() hook is more efficient than the componentDidMount() and componentDidUpdate() lifecycle methods.', 'score': false},
],
},
{
'question': 'What are some of the benefits of using functional components instead of class components?',
'answers': [
{'answerText': 'Functional components are more concise and easier to read.', 'score': true},
{'answerText': 'Functional components are more flexible and reusable.', 'score': true},
{'answerText': 'Functional components are more efficient and performant.', 'score': true},
{'answerText:': 'Functional components are easier to test.', 'score': true},
],
},
];


