import 'package:flutter/material.dart';
import 'package:quiz_app/Dummydb.dart';
import 'package:quiz_app/view/Homescreen/Homesceen.dart';

class Resultscreen extends StatefulWidget {
  const Resultscreen({super.key, required this.rightanswercount});
  final int rightanswercount;

  @override
  State<Resultscreen> createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  int starcount = 0;
  calculatestarcount() {
    var percentage =
        (widget.rightanswercount / Dummydb.Questionlist.length) * 100;

    if (percentage >= 80) {
      starcount = 3;
    } else if (percentage >= 50) {
      starcount = 2;
    } else if (percentage >= 30) {
      starcount = 1;
    } else {
      starcount = 0;
    }
  }

  @override
  void initState() {
    calculatestarcount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
                3,
                (index) => Icon(
                      Icons.star,
                      color: index < starcount ? Colors.amber : Colors.grey,
                      size: index == 1 ? 80 : 40,
                    )),
          ),
          SizedBox(height: 20),
          Text("Congratulations",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Your Score",
              style: TextStyle(color: Colors.white, fontSize: 15)),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                "${widget.rightanswercount} / ${Dummydb.Questionlist.length}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber)),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homescreen(),
                      ));
                });
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.replay, color: Colors.white)),
                        SizedBox(width: 20),
                        Text("Retry", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
