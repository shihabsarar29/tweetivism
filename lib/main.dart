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
  String openAITweets = "";
  bool isLoading = false;
  List<String> tweetsList = [];
  Set<String> tweetsSet = {};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [

              SizedBox(height: 20),

              Center(child: Text("Tweetivism", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),

              SizedBox(height: 20),

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
                  tweetsList = await TwitterApiData(searchController.text);
                  tweetsSet.addAll(tweetsList);

                  for(int i=0; i<tweetsSet.length; i++){
                    openAITweets += "Tweet: ";
                    openAITweets += tweetsSet.elementAt(i);
                    openAITweets += "\n";
                    if(openAITweets.length > 500)
                      break;
                  }
                  openAITweets += "Summarize about ${searchController.text} from the tweets";
                  String result = await openAIData(openAITweets);
                  setState(() {
                    isLoading = false;
                    openAIResult = result;
                  });
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

              SizedBox(height: 30),

              openAIResult == "" ? Container() : Center(child: Text("Short Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),

              Text(openAIResult),

              SizedBox(height: 30),

              tweetsSet.length == 0 ? Container() : Center(child: Text("Popular Tweets", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),

              SizedBox(height: 20),

              for(int i=0; i<tweetsSet.length && i<10; i++)
                Text(tweetsSet.elementAt(i)+"\n"),

            ],
          ),
        ),
      ),
    );
  }
}
