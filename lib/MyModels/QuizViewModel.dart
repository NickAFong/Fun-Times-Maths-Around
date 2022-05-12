import 'dart:async';
import 'dart:math';

import 'package:ftma/MyModels/QuestionWrapper.dart';
import 'package:ftma/MyModels/ViewModel.dart';
import 'package:ftma/utils/FirebaseUtil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

class QuizViewModel extends ViewModel {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MMddyyyykkmm');

  final BehaviorSubject<String> _gamerank = BehaviorSubject<String>();
  Stream<String> get gameRank => _gamerank.stream;

  final BehaviorSubject<bool> _checkAnswerBtn = BehaviorSubject();
  Stream<bool> get checkAnswerBtn => _checkAnswerBtn.stream;

  final BehaviorSubject<String> _setRank = BehaviorSubject<String>();
  Stream<String> get setRank => _setRank.stream;

  final BehaviorSubject<QuestionWrapper> _question =
      BehaviorSubject<QuestionWrapper>();
  Stream<QuestionWrapper> get question => _question.stream;

  final BehaviorSubject<bool?> _correctQuestion = BehaviorSubject();
  Stream<bool?> get correctQuestion => _correctQuestion.stream;

  BehaviorSubject<int> mRank = BehaviorSubject();
  Stream<int> get _mRank => mRank.stream;

  int? intRank;
  int timeCountDown = 0;
  List<String> _questions = [];
  int answer = -1;
  late FirebaseUtils firebaseUtils;
  int questionIndex = 0;
  int correctGuessesCount = 0;

  QuizViewModel(this.firebaseUtils) {
    getRank((rank) {
      intRank = rank;
      createQuiz("quiz", rank);
      loadNewQuestion();
    });
  }

  void getRank(Function(int) onSuccess) {
    final snapshot = firebaseUtils.getRank();
    snapshot.listen((event) {
      int? rank = int.tryParse(event.value.toString());
      print("tryParse#1 => $rank");
      if (rank != null) {
        onSuccess.call(rank);
      }
      _gamerank.sink.add(event.value as String);
    }, onError: (error, trace) {
      _gamerank.sink.addError(error);
    });
  }

  void setNewRank(String rank) {
    firebaseUtils.setRank(rank).listen((event) {
      _setRank.sink.add(event);
    }, onError: (error, _) {
      _setRank.sink.addError(error);
    });
  }

  Random createRNG() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMddyyyykkmm');
    final String seed = formatter.format(now);

    print(seed);

    Random random = Random(int.parse(seed));
    return random;
  }

  int getRandomNumber(Random rng, int max) {
    return rng.nextInt(max);
  }

  void checkAnswer(int guess) {
    print("checkAnswer $guess");
    final isAnswerCorrect = guess == answer;

    // Display green/red bar
    _correctQuestion.sink.add(isAnswerCorrect);

    // Wait for 350 millisecs
    Future.delayed(const Duration(milliseconds: 350), () {
      if (isAnswerCorrect) {
        //Hide red/success bar
        _correctQuestion.sink.add(null);
        correctGuessesCount += 1;
        loadNewQuestion();

        // Delay for 5
      } else {
        Future.delayed(const Duration(seconds: 5), () {
          //Hide red/success bar
          _correctQuestion.sink.add(null);
          // Delay for 5
          loadNewQuestion();
        });
      }
    });

    _checkAnswerBtn.sink.add(false);
  }

  void loadNewQuestion() {
    if (questionIndex < 37) {
      _checkAnswerBtn.sink.add(true);
      answer = int.tryParse(_questions[questionIndex + 3].toString()) ??
          -1; //Get the answer
      String question =
          "${_questions[questionIndex].toString()} ${_questions[questionIndex + 1].toString()}"
          " ${_questions[questionIndex + 2].toString()} =";

      _question.sink.add(QuestionWrapper(
          question: question,
          correctAnswer: answer.toString(),
          correctGuessesCount: correctGuessesCount,
          rank: "$intRank"));
      questionIndex += 4;
    } else if (questionIndex == 36) {
      _checkAnswerBtn.sink.add(true);
      answer = int.tryParse(_questions[questionIndex + 3].toString()) ??
          -1; //Get the answer
      String question =
          "${_questions[questionIndex].toString()} ${_questions[questionIndex + 1].toString()}"
          " ${_questions[questionIndex + 2].toString()} =";

      _question.sink.add(QuestionWrapper(
          question: question,
          correctAnswer: answer.toString(),
          correctGuessesCount: correctGuessesCount));
      questionIndex = 100;
    } else {
      int addPoints = correctGuessesCount * 2;
      int subtractPoints = (10 - correctGuessesCount) * 4;

      int newRank = (addPoints - subtractPoints) + (intRank ?? 0);
      int firstRank = correctGuessesCount * 100;

      if (intRank == -1) {
        newRank = firstRank;
        setNewRank("$firstRank");
      } else if (newRank <= 0) {
        newRank = 0;
        setNewRank("$newRank");
      } else {
        setNewRank("$newRank");
      }

      _question.sink.add(QuestionWrapper(
          question: null,
          hasEnded: true,
          correctAnswer: answer.toString(),
          correctGuessesCount: correctGuessesCount,
          rank: "$newRank"));
    }
  }

  void createQuiz(String answer, int rank) {
    Random generator = createRNG();

    if (rank == -1) {
      List<int> pools = [];
      pools.add(1);
      pools.add(1);
      pools.add(2);
      pools.add(2);
      pools.add(3);
      pools.add(4);
      pools.add(5);
      pools.add(6);
      pools.add(7);
      pools.add(8);

      _questions = getQuestions(generator, pools);
    }
    //one digit addition
    else if (rank > 0 && rank < 100) {
      List pools = poolBuilder(generator, 1);
      _questions = getQuestions(generator, pools);
    }
    //one digit addition, one digit subtraction
    else if (rank >= 100 && rank < 200) {
      List pools = poolBuilder(generator, 2);
      _questions = getQuestions(generator, pools);
    }
    //one digit addition, one digit subtraction, one digit multiplication
    else if (rank >= 200 && rank < 300) {
      List pools = poolBuilder(generator, 3);
      _questions = getQuestions(generator, pools);
    }
    //one digit addition, one digit subtraction, one digit multiplication, easy division
    else if (rank >= 300 && rank < 400) {
      List pools = poolBuilder(generator, 4);
      _questions = getQuestions(generator, pools);
    }
    //one digit addition, one digit subtraction, one digit multiplication, easy division, 3 digit addition
    else if (rank >= 400 && rank < 500) {
      List pools = poolBuilder(generator, 5);
      _questions = getQuestions(generator, pools);
    }
    //one digit addition, one digit subtraction, one digit multiplication, easy division, 3 digit addition, 3 digit subtraction
    else if (rank >= 500 && rank < 600) {
      List pools = poolBuilder(generator, 6);
      _questions = getQuestions(generator, pools);
    }
    //one digit addition, one digit subtraction, one digit multiplication, easy division, 3 digit addition, 3 digit subtraction, harder multiplication
    else if (rank >= 700 && rank < 800) {
      List pools = poolBuilder(generator, 7);
      _questions = getQuestions(generator, pools);
    }
    //one digit addition, one digit subtraction, one digit multiplication, easy division, 3 digit addition, 3 digit subtraction, harder multiplication, and harder division
    else {
      List pools = poolBuilder(generator, 8);
      _questions = getQuestions(generator, pools);
      //_questions.add();

    }
    print(_questions);
  }

  List<String> getQuestions(Random rng, List pools) {
    List<String> questions = [];

    for (int i = 0; i < 10; i++) {
      if (pools[i] == 1) {
        List pool = getQuestionPool1(
          rng,
        );
        pool.forEach((i) {
          questions.add(i);
        });
      } else if (pools[i] == 2) {
        List pool = getQuestionPool2(rng);
        pool.forEach((i) {
          questions.add(i);
        });
      } else if (pools[i] == 3) {
        List pool = getQuestionPool3(rng);
        pool.forEach((i) {
          questions.add(i);
        });
      } else if (pools[i] == 4) {
        List pool = getQuestionPool4(rng);
        pool.forEach((i) {
          questions.add(i);
        });
      } else if (pools[i] == 5) {
        List pool = getQuestionPool5(rng);
        pool.forEach((i) {
          questions.add(i);
        });
      } else if (pools[i] == 6) {
        List pool = getQuestionPool6(rng);
        pool.forEach((i) {
          questions.add(i);
        });
      } else if (pools[i] == 7) {
        List pool = getQuestionPool7(rng);
        pool.forEach((i) {
          questions.add(i);
        });
      } else {
        List pool = getQuestionPool8(rng);
        pool.forEach((i) {
          questions.add(i);
        });
      }
    }
    return questions;
  }

  List getQuestionPool1(Random rng) {
    List<String> question = [];

    int first = rng.nextInt(11);
    question.add(first.toString());
    question.add('+');
    int second = rng.nextInt(11);
    question.add(second.toString());
    int answer = first + second;
    question.add(answer.toString());
    return question;
  }

  List getQuestionPool2(Random rng) {
    List<String> question = [];
    int first = rng.nextInt(10) + 1;
    int second = rng.nextInt(11);

    if (first > second) {
      int answer = first - second;
      question.add(first.toString());
      question.add('-');
      question.add(second.toString());
      question.add(answer.toString());
      return question;
    } else if (second > first) {
      int answer = second - first;
      question.add(second.toString());
      question.add('-');
      question.add(first.toString());
      question.add(answer.toString());
      return question;
    } else {
      int answer = first - second;
      question.add(first.toString());
      question.add('-');
      question.add(second.toString());
      question.add(answer.toString());
      return question;
    }
  }

  List getQuestionPool3(Random rng) {
    List<String> question = [];

    int first = rng.nextInt(11);
    int second = rng.nextInt(11);

    int answer = first * second;

    question.add(first.toString());
    question.add('*');
    question.add(second.toString());
    question.add(answer.toString());

    return question;
  }

  List<String> getQuestionPool4(Random rng) {
    List<String> question = [];

    int second = rng.nextInt(90) + 11;
    int answer = rng.nextInt(11);
    int first = second * answer;

    question.add(first.toString());
    question.add('/');
    question.add(second.toString());
    question.add(answer.toString());

    return question;
  }

  List getQuestionPool5(Random rng) {
    List<String> question = [];

    int first = rng.nextInt(100);
    question.add(first.toString());
    question.add('+');
    int second = rng.nextInt(100);
    question.add(second.toString());
    int answer = first + second;
    question.add(answer.toString());

    return question;
  }

  List getQuestionPool6(Random rng) {
    List<String> question = [];
    int first = rng.nextInt(100);
    int second = rng.nextInt(100);

    if (first > second) {
      int answer = first - second;
      question.add(first.toString());
      question.add('-');
      question.add(second.toString());
      question.add(answer.toString());
      return question;
    } else if (second > first) {
      int answer = second - first;
      question.add(second.toString());
      question.add('-');
      question.add(first.toString());
      question.add(answer.toString());
      return question;
    } else {
      int answer = first - second;
      question.add(first.toString());
      question.add('-');
      question.add(second.toString());
      question.add(answer.toString());
      return question;
    }
  }

  List getQuestionPool7(Random rng) {
    List<String> question = [];

    int first = rng.nextInt(100);
    int second = rng.nextInt(10) + 1;

    int answer = first * second;

    question.add(first.toString());
    question.add('*');
    question.add(second.toString());
    question.add(answer.toString());

    return question;
  }

  List getQuestionPool8(Random rng) {
    List<String> question = [];

    int second = rng.nextInt(90) + 11;
    int answer = rng.nextInt(11);
    int first = second * answer;

    question.add(first.toString());
    question.add('/');
    question.add(second.toString());
    question.add(answer.toString());

    return question;
  }

  List poolBuilder(Random rng, int range) {
    List<int> pools = [];

    for (int i = 0; i < 10; i++) {
      pools.add((rng.nextInt(range) + 1));
    }
    return pools;
  }

  @override
  void dispose() {
    _gamerank.close();
  }
}
