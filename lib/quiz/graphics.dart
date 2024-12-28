
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_app/quiz/quiz_home.dart';
import 'package:freelancer_app/quiz/quiz_resultpage.dart';

import 'quiz_answer.dart';

class graphicsQuiz extends StatefulWidget {


  String jobtype1;
  graphicsQuiz(this.jobtype1);

  @override
  _graphicsQuizState createState() => _graphicsQuizState();



}

class _graphicsQuizState extends State<graphicsQuiz> {
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







const _questions = [
  {
    'question': 'What is the difference between serif and sans-serif fonts?',
    'answers': [
      {'answerText': 'Serif fonts have serifs, while sans-serif fonts do not.', 'score': true},
      {'answerText': 'Serif fonts are more modern than sans-serif fonts.', 'score': false},
      {'answerText': 'Serif fonts are better for web design than sans-serif fonts.', 'score': false},
      {'answerText': 'There is no difference between serif and sans-serif fonts.', 'score': false},
    ],
  },
  {
    'question': 'What is the rule of thirds in photography?',
    'answers': [
      {'answerText': 'The subject should be centered in the frame.', 'score': false},
      {'answerText': 'The frame should be divided into three equal parts.', 'score': true},
      {'answerText': 'The background should be blurred.', 'score': false},
      {'answerText': 'The photo should be taken at a 45-degree angle.', 'score': false},
    ],
  },
  {
    'question': 'What is a raster image?',
    'answers': [
      {'answerText': 'An image made up of pixels.', 'score': true},
      {'answerText': 'An image made up of vectors.', 'score': false},
      {'answerText': 'An image made up of lines and curves.', 'score': false},
      {'answerText': 'An image made up of text.', 'score': false},
    ],
  },
  {
    'question': 'What is a vector image?',
    'answers': [
      {'answerText': 'An image made up of pixels.', 'score': false},
      {'answerText': 'An image made up of vectors.', 'score': true},
      {'answerText': 'An image made up of lines and curves.', 'score': false},
      {'answerText': 'An image made up of text.', 'score': false},
    ],
  },
  {
    'question': 'What is negative space in design?',
    'answers': [
      {'answerText': 'The space between letters in a word.', 'score': false},
      {'answerText': 'The space between lines of text in a paragraph.', 'score': false},
      {'answerText': 'The unused space around and between objects in a design.', 'score': true},
      {'answerText': 'The space between paragraphs.', 'score': false},
    ],
  },
  {
    'question': 'What is the golden ratio in design?',
    'answers': [
      {'answerText': 'A mathematical ratio that is aesthetically pleasing in design.', 'score': true},
      {'answerText': 'A ratio used to determine the size of fonts in a design.', 'score': false},
      {'answerText': 'A ratio used to determine the spacing between objects in a design.', 'score': false},
      {'answerText': 'A ratio used to determine the color palette in a design.', 'score': false},
    ],
  },
  {
    'question': 'What is a moodboard in design?',
    'answers': [
      {'answerText': 'A board used to display a design in progress.', 'score': false},
      {'answerText': 'A board used to display a finished design.', 'score': false},
      {'answerText': 'A board used to collect inspiration and ideas for a design.', 'score': true},
      {'answerText': 'A board used to display the client’s feedback on a design.', 'score': false},
    ],
  },
  {
    'question': 'What is contrast in design?',
    'answers': [
      {'answerText': 'The difference between the size of objects in a design.', 'score': false},
      {'answerText': 'The difference between the color of objects in a design.', 'score': true},
      {'answerText': 'The difference between the shape of objects in a design.', 'score': false},
      {'answerText': 'The difference between the texture of objects in a design.', 'score': false},
    ],
  },
  {
    'question': 'What is the difference between a JPEG and a PNG image?',
    'answers': [
      {'answerText': 'JPEGs are smaller in file sizethan PNGs.', 'score': true},
      {'answerText': 'PNGs are smaller in file size than JPEGs.', 'score': false},
      {'answerText': 'JPEGs are better for images with transparency.', 'score': false},
      {'answerText': 'PNGs are better for photographs.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of a style guide in design?',
    'answers': [
      {'answerText': 'To showcase a designer’s portfolio.', 'score': false},
      {'answerText': 'To provide guidelines for consistent branding in a design project.', 'score': true},
      {'answerText': 'To display the client’s feedback on a design.', 'score': false},
      {'answerText': 'To provide a platform for collaboration between designers.', 'score': false},
    ],
  },
  {
    'question': 'What is the difference between a font and a typeface?',
    'answers': [
      {'answerText': 'There is no difference between a font and a typeface.', 'score': false},
      {'answerText': 'A font is a digital file, while a typeface is a physical design.', 'score': false},
      {'answerText': 'A font is a specific size and weight of a typeface.', 'score': true},
      {'answerText': 'A typeface is a specific size and weight of a font.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of white space in design?',
    'answers': [
      {'answerText': 'To add visual interest to a design.', 'score': false},
      {'answerText': 'To fill empty space in a design.', 'score': false},
      {'answerText': 'To provide breathing room and improve readability in a design.', 'score': true},
      {'answerText': 'To add color to a design.', 'score': false},
    ],
  },
  {
    'question': 'What is the difference between a wireframe and a mockup in design?',
    'answers': [
      {'answerText': 'A wireframe is a detailed design, while a mockup is a simple sketch.', 'score': false},
      {'answerText': 'A wireframe is a black and white design, while a mockup is a full-color design.', 'score': false},
      {'answerText': 'A wireframe is a basic visual representation of a design, while a mockup is a more detailed representation.', 'score': true},
      {'answerText': 'A wireframe is a digital design, while a mockup is a physical design.', 'score': false},
    ],
  },
  {
    'question': 'What is the purpose of a gradient in design?',
    'answers': [
      {'answerText': 'To add texture to a design.', 'score': false},
      {'answerText': 'To add color to a design.', 'score': true},
      {'answerText': 'To add contrast to a design.', 'score': false},
      {'answerText': 'To add depth to a design.', 'score': false},
    ],
  },
  {
    'question': 'What is a bleed in print design?',
    'answers': [
      {'answerText': 'A mistake in the printing process.', 'score': false},
      {'answerText': 'The area around the design that is trimmed off after printing.', 'score': false},
      {'answerText': 'The extra area around the design that extends beyond the final trim size.', 'score': true},
      {'answerText': 'The alignment of text and images in a design.', 'score': false},
    ],
  },
];


