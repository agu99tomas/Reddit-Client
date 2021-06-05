import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  @override
  List<Widget> buildActions(BuildContext context) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = "",
        ),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => close(context, null),
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    return ListTile(
      title: Text(query),
      onTap: (){
        close(context, null);
        Navigator.pushNamed(context, 'PostsPage', arguments: query);
      },
    );
  }

}