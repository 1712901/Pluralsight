import 'package:Pluralsight/View/ui/Account/UpdatePassword.dart';
import 'package:flutter/material.dart';

class OTP extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.grey[400],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.phonelink_ring,
                color: Colors.blue[400],
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'PLEASES ENTER',
                style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'THE VALIDATION CODE THAT GET FROM EMAIL !',
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 50,
                    height: 50,
                    child: TextField(
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 50,
                    height: 50,
                    child: TextField(
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 50,
                    height: 50,
                    child: TextField(
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                      ),
                    )
                  ),Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 50,
                    height: 50,
                    child: TextField(
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                      ),
                    )
                  )
                ],
              ),
              
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blue[400],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdatePassword()));
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
