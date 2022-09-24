import 'dart:convert';
import "package:http/http.dart" as http;



Future<String> openAIData(String searchData) async {

  String summary = "Please Try Again";

  try {
    Map<String, dynamic> apiBody = {
      "model": "text-davinci-002",
      "prompt": "Write something about" + searchData,
      "temperature": 0.7,
      "max_tokens": 64,
      "top_p": 1.0,
      "frequency_penalty": 0.0,
      "presence_penalty": 0.0,
    };

    final Uri completionsEndpoint = Uri.parse(
        'https://api.openai.com/v1/completions');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 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',
    };

    http.Response response = await http.post(
      completionsEndpoint,
      headers: headers,
      body: json.encode(apiBody),
    );

    // print('Received OpenAI API response: ${response.body}');

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      summary = result['choices'][0]['text'];
    }
  }
  catch (error) {
    print("Error in OpenAI Api: $error");
  }

  return summary;
}