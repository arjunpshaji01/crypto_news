import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_news/news/bloc/news_bloc.dart';
import 'package:crypto_news/news/data/news_service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:crypto_news/widgets/view/detailed_news.dart';
import 'package:flutter/scheduler.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  ///launch url using launch_url package
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      ///load LoadApiEvent on creation
      create: (context) => NewsBloc(
        RepositoryProvider.of<NewsService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<NewsBloc, NewsState>(
          ///listen state and loads LoadApiEvent periodically using delayed
          listener: (context, state) {
            Future.delayed(const Duration(seconds: 60), () {
              context.read<NewsBloc>().add(LoadApiEvent());
            });
          },
          builder: (context, state) {
            ///if state is loading state, shows circular hud
            if (state is NewsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            if (state is NewsLoadedState) {
              ///wraps listbuilder in RefreshIndicator
              return RefreshIndicator(
                color: Colors.orange,
                onRefresh: () async {
                  ///load LoadApiEvent event
                  context.read<NewsBloc>().add(LoadApiEvent());
                },
                child: ListView.builder(
                  ///sets count as list-length
                  itemCount: state.results!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: Border(
                        ///list tile border
                        top: BorderSide(
                            width: 1,
                            color: Colors.grey.shade600,
                            style: BorderStyle.solid),
                      ),
                      leading: Text(
                        ///formats time into minutes/hours using timeAgo format
                        timeago.format(
                            state.results![index].publishedAt!
                                .subtract(const Duration(minutes: 1)),
                            locale: 'en_short'),
                        style: const TextStyle(
                            fontSize: 13, color: Colors.white70),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      ///routes to NewsDetails screen with data
                                      builder: (context) => NewsDetails(
                                          state.results![index].title,
                                          state.results![index].domain),
                                    ),
                                  );
                                });
                              },
                              child: Text(
                                ///shows slug
                                state.results![index].slug,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: GestureDetector(
                        onTap: (() {
                          ///goes to the domain url by calling __launchUrl function
                          _launchUrl(Uri.parse(
                              'https://${state.results![index].domain}'));
                        }),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.link,
                              size: 15,
                              color: Colors.green,
                            ),
                            Text(
                              ///shows domain
                              state.results![index].domain,
                              style: TextStyle(color: Colors.green.shade300),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container(
              ///return in case of data load failure
              child: const Center(child: Text('Couldn\'t fetch news..!')),
            );
          },

          ///builds widget only when state is NewsLoadedState
          buildWhen: (context, state) {
            if (state is NewsLoadedState) {
              return true;
            }
            return false;
          },
        ),
      ),
    );
    ;
  }
}
