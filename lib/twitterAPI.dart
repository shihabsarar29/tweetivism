import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;


Future<List<String>> TwitterApiData(String twitterSearch) async {

  List<String> tweetsList = [];


  final twitter = v2.TwitterApi(
    bearerToken: 'AAAAAAAAAAAAAAAAAAAAAODIhQEAAAAA%2BlRdcOXVM2M6ug%2BVdi1F%2FfFUr5k%3Dmn1NPbcpZzKh97Xfd9E02lXub0RGLnmFutNF37wcRcYQaxJkbm',
    oauthTokens: v2.OAuthTokens(
      consumerKey: 'ywrubwrvhPDyBEuX78Jzd6R4E',
      consumerSecret: 'XviH7JC7IrrDBloQ84eBLhvVFrwISkD43OFzgkNTGF4jvJYOqY',
      accessToken: '1573543285313904640-9NNa9h0o5CNITOQEa2Fs7BaeV0lFRr',
      accessTokenSecret: 'SYZtozNjojPFMshPzyetwkeAl7O66UxFSQwkpO4MAA4GS',
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