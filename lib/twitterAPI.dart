import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;


Future<List<String>> TwitterApiData(String twitterSearch) async {

  List<String> tweetsList = [];


  final twitter = v2.TwitterApi(
    bearerToken: '',
    oauthTokens: v2.OAuthTokens(
      consumerKey: '',
      consumerSecret: '',
      accessToken: '',
      accessTokenSecret: '',
    ),
  );

  final tweets = await twitter.tweetsService.searchRecent(
    query: twitterSearch,
    maxResults: 100,

  );


  for(int i = 0; i < tweets.data.length; i++){
    tweetsList.add(tweets.data[i].text);
  }

  return tweetsList;

}
