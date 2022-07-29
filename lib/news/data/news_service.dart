import 'package:crypto_news/news/model/news_model.dart';
import 'package:http/http.dart';

class NewsService {
  ///cryptopanic API
  final url =
      "https://cryptopanic.com/api/v1/posts/?auth_token=249d42fc0f64643c9b088c3506ea007e17587a2b&public=true";

  Future<Welcome> getCryptoNews() async {
    final response = await get(Uri.parse(url));

    ///decode from json using this WelcomeFromJson (model)
    final cryptoNews = welcomeFromJson(response.body);

    ///returns decoded json body
    return cryptoNews;
  }
}
