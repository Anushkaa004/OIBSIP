import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QUIZ APP',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Who is the father of Geometry?',
      'answers': ['Aristotle', 'Euclid', 'Pythagoras', 'Kepler'],
      'correctIndex': 1,
    },
    {
      'question': 'What is common between Kutty, Shankar, Laxman and Sudhir Dar?',
      'answers': ['Film Direction', 'Drawing Cartoons', 'Instrumental Music', 'Classical Dance'],
      'correctIndex': 1,
    },
    {
      'question': 'Who was known as Iron man of India?',
      'answers': ['Govind Ballabh Pant', 'Jawaharlal Nehru', 'Subhash Chandra Bose', 'Sardar Vallabhbhai Patel'],
      'correctIndex': 3,
    },
    {
      'question': 'The Indian to beat the computers in mathematical wizardry is',
      'answers': ['Ramanujam', 'Rina Panigrahi', 'Raja Ramanna', 'Shakunthala Devi'],
      'correctIndex': 3,
    },
    {
      'question': 'Jude Felix is a famous Indian player in which of the fields?',
      'answers': ['hockey', 'Football', 'Tennis', 'Volleyball'],
      'correctIndex': 0,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    int correctIndex = _questions[_questionIndex]['correctIndex'];
    if (selectedIndex == correctIndex) {
      setState(() {
        _score++;
      });
    }
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('Your score: $_score/${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _questionIndex = 0;
                  _score = 0;
                });
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo[600],
        title: Text('QUIZ APP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                _questions[_questionIndex]['question'],
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: (_questions[_questionIndex]['answers'] as List<String>).map(
                    (answer) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[600],
                        // side: BorderSide(color: Colors.yellow, width: 5),
                        textStyle: const TextStyle(
                            color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        _answerQuestion(
                            (_questions[_questionIndex]['answers'] as List<String>).indexOf(answer));
                      },
                      child: Text(answer),
                    ),
                  );
                },
              ).toList(),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Question ${_questionIndex + 1}/${_questions.length}'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                // side: BorderSide(color: Colors.yellow, width: 5),
                textStyle: const TextStyle(
                    color: Colors.white, fontSize: 20, fontStyle: FontStyle.normal),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {
                _showResultDialog();
              },
              child: Text('End Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
