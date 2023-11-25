import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'BEBEBEBABABA',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/marix': (context) => Marix(),
        '/time': (context) => Time(),
      },
    ),
  );
}

List<Offset> list = [];

class Time extends StatelessWidget {
  const Time({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(arguments),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();

  int checkBorder(int? x1, int? y1, int? x2, int? y2) {
    if(x1 == null || x2 == null || y1 == null || y2 == null)
      return 2;
    if (x1 == null ? true : (x1 > 15) || x1 < -15 || y1 == null ? true : (y1 < -15) || y1 > 15 || x2 == null ? true : (x2 < -15) || x2 > 15 || y2 == null ? true : (y2 < -15) || y2 > 15)
      return 3;
    else
      return 1;
  }
  int checkBorderR(int? x1, int? y1, int? r)
  {
    if(x1 == null || y1 == null || r == null)
      return 2;
    if (x1 == null ? true : (x1 > 15) || x1 < -15 || y1 == null ? true : (y1 < -15) || r == null ? true : (r < 0) || r > 15)
      return 3;
    else
      return 1;
  }


  Future<void> _showMyDialog(int flag, String time) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выход за пределы / не введены все данные '),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                flag == 2 ? Text('Не все данные введены. :/') : Text('Поменяйте данные, если хотите увидеть график, данные должны быть -15 <= x <= 15, а пока что посмотрите за сколько выполнился алгоритм ))))'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Окич'),
              onPressed: () {
                if(flag == 2)
                  Navigator.of(context).pop();
                if(flag == 3) {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/time', arguments: time);
                }
              },
            ),
          ],
        );
      },
    );
  }

  double Naive(int? x1, int? y1, int? x2, int? y2, int flag) {
    if(flag == 2) {
      _showMyDialog(flag, '');
      return 2;
    }
    if (x1 != null && x2 != null && y1 != null && y2 != null) {
      int startTime = DateTime
          .now()
          .microsecondsSinceEpoch;
      double dx = (x2.toDouble() - x1.toDouble());
      double dy = (y2.toDouble() - y1.toDouble());
      if (dx == 0 && dy == 0) {
        list.add(Offset(300, 280));
        int endTime = DateTime
            .now()
            .microsecondsSinceEpoch;
        double elapsedTime = (endTime - startTime).toDouble();
        return elapsedTime;
      }
      if (dx.abs() >= dy.abs()) {
        double a = dy / dx;
        double x, y;
        if (x1 <= x2) {
          x = x1.toDouble();
          y = y1.toDouble();
        } else {
          x = x2.toDouble();
          y = y2.toDouble();
          x2 = x1;
          y2 = y1;
        }
        while (x.abs() <= x2.abs()) {
          list.add(Offset(((x).roundToDouble() + 15) * 20, (14 - (y).roundToDouble()) * 20));
          x++;
          y = y + a;
        }
      } else {
        double a = dx / dy;
        double x, y;
        if (y1 <= y2) {
          x = x1.toDouble();
          y = y1.toDouble();
        } else {
          x = x2.toDouble();
          y = y2.toDouble();
          x2 = x1;
          y2 = y1;
        }
        while (y.abs() <= y2.abs()) {
          list.add(Offset(((x).roundToDouble() + 15) * 20, (14 - (y).roundToDouble()) * 20));
          y++;
          x = x + a;
        }
      }
      int endTime = DateTime
          .now()
          .microsecondsSinceEpoch;
      double elapsedTime = (endTime - startTime).toDouble();
      print('$elapsedTime - время работы алгоритма');
      if (flag == 1)
        Navigator.pushNamed(context, '/marix');
      else
        _showMyDialog(flag, '$elapsedTime - время работы алгоритма в микросекундах');
      return elapsedTime;
    }
    return 2;
  }

  double Dda(int? x1, int? y1, int? x2, int? y2, int flag) {
    if(flag == 2) {
      _showMyDialog(flag, '');
      return 2;
    }
    if(x1 != null && x2 != null && y1 != null && y2 != null) {
      int startTime = DateTime
          .now()
          .microsecondsSinceEpoch;
      int step;
      int deltaX = x2 - x1;
      int deltaY = y2 - y1;
      if (deltaX == 0 && deltaY == 0) {
        list.add(Offset(300, 280));
        int endTime = DateTime
            .now()
            .microsecondsSinceEpoch;
        double elapsedTime = (endTime - startTime).toDouble();
        return elapsedTime;
      }
      if (deltaX.abs() >= deltaY.abs()) {
        step = deltaX;
      } else {
        step = deltaY;
      }
      double dX = deltaX / step.toDouble().abs();
      double dY = deltaY / step.toDouble().abs();
      double x = x1.toDouble();
      double y = y1.toDouble();
      for (int i = 1; i <= step.abs(); i++) {
        list.add(Offset(((x).roundToDouble() + 15) * 20, (14 - (y).roundToDouble()) * 20));
        x = x + dX;
        y = y + dY;
      }
      int endTime = DateTime
          .now()
          .microsecondsSinceEpoch;
      double elapsedTime = (endTime - startTime).toDouble();
      print('$elapsedTime - время работы алгоритма');
      if (flag == 1)
        Navigator.pushNamed(context, '/marix');
      else
        _showMyDialog(flag, '$elapsedTime - время работы алгоритма в микросекундах');
      return elapsedTime;
    }
    return 2;
  }

  double BrForCircle(int? x0, int? y0, int? radius, int flag) {
    if(flag == 2) {
      _showMyDialog(flag, '');
      return 2;
    }
    if(x0 != null && y0 != null && radius != null) {
      int startTime = DateTime
          .now()
          .microsecondsSinceEpoch;
      int x = radius;
      int y = 0;
      int radiusError = 1 - x;
      while (x >= y) {
        list.add(Offset(((x + x0 + 15) * 20).toDouble(), ((14 - (y + y0)) * 20).toDouble()));
        list.add(Offset(((y + x0 + 15) * 20).toDouble(), ((14 - (x + y0)) * 20).toDouble()));
        list.add(Offset(((-x + x0 + 15) * 20).toDouble(), ((14 - (y + y0)) * 20).toDouble()));
        list.add(Offset(((-y + x0 + 15) * 20).toDouble(), ((14 - (x + y0)) * 20).toDouble()));
        list.add(Offset(((-x + x0 + 15) * 20).toDouble(), ((14 - (-y + y0)) * 20).toDouble()));
        list.add(Offset(((-y + x0 + 15) * 20).toDouble(), ((14 - (-x + y0)) * 20).toDouble()));
        list.add(Offset(((x + x0 + 15) * 20).toDouble(), ((14 - (-y + y0)) * 20).toDouble()));
        list.add(Offset(((y + x0 + 15) * 20).toDouble(), ((14 - (-x + y0)) * 20).toDouble()));
        ++y;
        if (radiusError < 0) {
          radiusError += 2 * y + 1;
        } else {
          --x;
          radiusError += 2 * (y - x + 1);
        }
      }
      int endTime = DateTime
          .now()
          .microsecondsSinceEpoch;
      double elapsedTime = (endTime - startTime).toDouble();
      print('$elapsedTime - время работы алгоритма');
      if (flag == 1)
        Navigator.pushNamed(context, '/marix');
      else
        _showMyDialog(flag, '$elapsedTime - время работы алгоритма в микросекундах');
      return elapsedTime;
    }
    return 2;
  }

  double BrForSegment(int? x1, int? y1, int? x2, int? y2, int flag) {
    if(flag == 2) {
      _showMyDialog(flag, '');
      return 2;
    }
    if(x1 != null && x2 != null && y1 != null && y2 != null) {
      int startTime = DateTime
          .now()
          .microsecondsSinceEpoch;
      int deltaX = (x2 - x1).abs();
      int deltaY = (y2 - y1).abs();
      int signX = x1 < x2 ? 1 : -1;
      int signY = y1 < y2 ? 1 : -1;
      int error = deltaX - deltaY;

      list.add(Offset((x2.toDouble() + 15) * 20, (14 - y2.toDouble()) * 20));
      while (x1 != x2 || y1 != y2) {
        if(x1 != null && y1 != null) {
          list.add(Offset((x1.toDouble() + 15) * 20, (14 - y1.toDouble()) * 20));
          int error2 = error * 2;
          if (error2 > -deltaY) {
            error -= deltaY;
            x1 += signX;
          }
          if (error2 < deltaX) {
            error += deltaX;
            y1 += signY;
          }
        }
      }
      int endTime = DateTime
          .now()
          .microsecondsSinceEpoch;
      double elapsedTime = (endTime - startTime).toDouble();
      print('$elapsedTime - время работы алгоритма');
      if (flag == 1)
        Navigator.pushNamed(context, '/marix');
      else
        _showMyDialog(flag, '$elapsedTime - время работы алгоритма в микросекундах');
      return elapsedTime;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  list.clear();
                  int u = checkBorder(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text),
                      int.tryParse(textController4.text));
                  if (u == 1)
                    Naive(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text),
                        int.tryParse(textController4.text), u);
                  else
                    Naive(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text),
                        int.tryParse(textController4.text), u);
                },
                child: Text('Пошаговый'),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () {
                  list.clear();
                  int u = checkBorder(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text),
                      int.tryParse(textController4.text));
                  if (u == 1)
                    Dda(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text),
                        int.parse(textController4.text), u);
                  else
                    Dda(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text),
                        int.tryParse(textController4.text), u);
                },
                child: Text('ЦДА'),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () {
                  list.clear();
                  int u = checkBorder(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text),
                      int.tryParse(textController4.text));
                  if (u == 1)
                    BrForSegment(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text,),
                        int.parse(textController4.text), u);
                  else
                    BrForSegment(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController3.text),
                        int.tryParse(textController4.text), u);
                },
                child: Text('Брезенхема'),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () {
                  list.clear();
                  int u = checkBorderR(int.tryParse(textController1.text), int.tryParse(textController2.text),
                      int.tryParse(textController5.text));
                  if (u == 1)
                    BrForCircle(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController5.text), u);
                  else
                    BrForCircle(int.tryParse(textController1.text), int.tryParse(textController2.text), int.tryParse(textController5.text), u);
                },
                child: Text('Брезенхема окружность'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: textController1,
                decoration: InputDecoration(
                  labelText: 'X0',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: textController2,
                decoration: InputDecoration(
                  labelText: 'Y0',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: textController3,
                decoration: InputDecoration(
                  labelText: 'X1',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: textController4,
                decoration: InputDecoration(
                  labelText: 'Y1',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: textController5,
                decoration: InputDecoration(
                  labelText: 'R',
                ),
              ),
            ],
          ),
        )
        /* child: CustomPaint(
              size: Size(600,600),
              painter: MyPainter(),
            ),*/
        );
  }
}

class Marix extends StatelessWidget {
  const Marix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('aboba',style: TextStyle(fontSize: 100,),),
          ),
          Zoom(
          child: Center(
            child: CustomPaint(
              size: Size(650, 650),
              painter: MyPainter(),
            ),
          ),
        ),
    ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    for (double i = 0; i < 600; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, 600), Paint());
    }
    for (double i = 0; i < 600; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(600, i), Paint());
    }
    canvas.drawLine(Offset(0, 300), Offset(600, 300), Paint()..strokeWidth = 4);
    canvas.drawLine(Offset(300, 0), Offset(300, 600), Paint()..strokeWidth = 4);
    TextStyle textStyle1 = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    TextSpan textSpan = TextSpan(
      text: "X",
      style: textStyle1,
    );
    TextPainter textPainter1 = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter1.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter1.paint(canvas, Offset(600, 300));
    TextSpan textSpan1 = TextSpan(
      text: "Y",
      style: textStyle1,
    );
    TextPainter textPainter2 = TextPainter(
      text: textSpan1,
      textDirection: TextDirection.ltr,
    );
    textPainter2.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter2.paint(canvas, Offset(270, 0));
    for (double i = 0; i < 600; i += 20) {
      TextStyle textStyle = TextStyle(
        color: Colors.black,
        fontSize: 10,
      );
      TextSpan textSpan = TextSpan(
        text: ((i / 20) - 15).toInt().toString(),
        style: textStyle,
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(canvas, Offset(i, 300));
    }
    for (double i = 0; i < 600; i += 20) {
      TextStyle textStyle = TextStyle(
        color: Colors.black,
        fontSize: 10,
      );
      TextSpan textSpan = TextSpan(
        text: (15 - (i / 20)).toInt().toString(),
        style: textStyle,
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(canvas, Offset(300, i));
    }
    for (dynamic it in list) {
      canvas.drawRect(Rect.fromPoints(it, Offset(it.dx + 20, it.dy + 20)), Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
