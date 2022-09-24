import 'package:activism/openAiAPI.dart';
import 'package:activism/twitterAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Activism App',
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}



class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  TextEditingController searchController = TextEditingController();
  String openAIResult = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              // Text("Hello World"),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: searchController,
              ),

              SizedBox(height: 20),

              isLoading ? CupertinoActivityIndicator()
              : InkWell(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  String result = await openAIData(searchController.text);
                  setState(() {
                    isLoading = false;
                    openAIResult = result;
                  });
                  TwitterApiData(searchController.text);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                  ),
                    child: Center(
                        child: Text("Search", style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                    ),
                ),
              ),

              Text(openAIResult),

            ],
          ),
        ),
      ),
    );
  }
}
