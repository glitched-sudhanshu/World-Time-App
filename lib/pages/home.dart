import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    //to set bg image
    String bgImage = data['isDayTime'] ? 'day.gif' : 'night.jfif';

    //to set safe area color
    //why ? mark
    Color? bgColor = data['isDayTime'] ? Colors.blue[300] : Colors.purple[900];

    //to set text color
    Color? textColor = data['isDayTime'] ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/$bgImage'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: textColor,
                  ),
                  label: Text(
                    'Edit location',
                    style: TextStyle(
                      color: textColor,
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        color: textColor, fontSize: 25, letterSpacing: 1.5),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                data['time'],
                style: TextStyle(
                    color: textColor, fontSize: 80, letterSpacing: 1.5),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
