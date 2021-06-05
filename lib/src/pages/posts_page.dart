import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reddit_client_7_3_21/src/models/post_model.dart';

import 'package:reddit_client_7_3_21/src/providers/post_provider.dart';
import 'package:reddit_client_7_3_21/src/widgets/post.dart';
import 'package:reddit_client_7_3_21/src/search/search_delegate.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostProvider _postProvider = new PostProvider();
  Future<List<PostModel>> _posts;
  String subreddit;
  
  @override
  Widget build(BuildContext context) {
    subreddit = 'r/ProgrammerHumor';
    String argumentSubreddit = ModalRoute.of(context).settings.arguments;
    if (argumentSubreddit != null) {
      subreddit = 'r/' + argumentSubreddit;
    }

    _posts = _postProvider.fetchPosts(subreddit);
  
    return Scaffold(
      appBar: _appBar(),
      body: _getAllPosts(),
    );
  }

  Widget _appBar() {
    return AppBar(
      toolbarHeight: kToolbarHeight + 10.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reddit client',
            style: TextStyle(color: Colors.black87),
          ),
          Text(
            subreddit,
            style: TextStyle(color: Colors.grey[600], fontSize: 15.0),
            overflow: TextOverflow.fade,
          )
        ],
      ),
      leading: Container(
        margin: EdgeInsets.all(3.0),
        child: Image(
          image: AssetImage('assets/img/logo.png'),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => showSearch(context: context, delegate: DataSearch()),
          color: Colors.black54,
        )
      ],
      backgroundColor: Colors.white,
    );
  }

  Widget _getAllPosts() {
    return FutureBuilder(
      future: _posts,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          final posts = asyncSnapshot.data;
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Post(
                    post: posts[index],
                  );
                }),
          );
        } else {
          return SpinKitPulse(
            color: Colors.orange[900],
            size: 50.0,
          );
        }
      },
    );
  }

  Future<void> _refresh() async {
    List<PostModel> newPosts = await _postProvider.fetchPosts(subreddit);
    setState(() {
      _posts = Future.value(newPosts);
    });
  }

}
