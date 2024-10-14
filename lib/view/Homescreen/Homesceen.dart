import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/Dummydb.dart';
import 'package:quiz_app/utils/animation_constant.dart';
import 'package:quiz_app/view/Resultscreen/Resultscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  dynamic currentindex = 0;
  int rightanswercount = 0;
  int? selectedanswerindex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("${currentindex + 1} / ${Dummydb.Questionlist.length}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: Center(
                          child: Text(
                        Dummydb.Questionlist[currentindex]["questions"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                    ),
                    if (selectedanswerindex ==
                        Dummydb.Questionlist[currentindex]["answerindex"])
                      Center(
                        child: Lottie.asset(
                            AnimationConstant.rightansweranimation,
                            fit: BoxFit.cover),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
                children: List.generate(
                    Dummydb.Questionlist[currentindex]["options"].length,
                    (optionindex) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    if (selectedanswerindex == null) {
                      selectedanswerindex = optionindex;
                      setState(() {
                        if (optionindex ==
                            Dummydb.Questionlist[currentindex]["answerindex"]) {
                          rightanswercount++;
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: getColor(optionindex), width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                              Dummydb.Questionlist[currentindex]["options"]
                                  [optionindex],
                              style: TextStyle(color: Colors.white)),
                          Spacer(),
                          Icon(Icons.circle_outlined, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
            SizedBox(
              height: 20,
            ),
            if (selectedanswerindex != null)
              InkWell(
                onTap: () {
                  setState(() {});

                  selectedanswerindex = null;
                  if (currentindex < Dummydb.Questionlist.length - 1) {
                    currentindex++;
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resultscreen(
                            rightanswercount: rightanswercount,
                          ),
                        ));
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color getColor(int currentoptionindex) {
    if (selectedanswerindex != null &&
        currentoptionindex ==
            Dummydb.Questionlist[currentindex]["answerindex"]) {
      return Colors.green;
    }
    if (selectedanswerindex == currentoptionindex) {
      if (selectedanswerindex ==
          Dummydb.Questionlist[currentindex]["answerindex"]) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.grey;
    }
  }
}
