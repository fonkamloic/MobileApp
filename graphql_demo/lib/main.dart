import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MaterialApp(
    title: 'GQL App',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: 'https://countries.trevorblades.com/');

    final ValueNotifier<GraphQLClient> client =
        ValueNotifier<GraphQLClient>(GraphQLClient(
            link: httpLink as Link,
            cache: OptimisticCache(
              dataIdFromObject: typenameDataIdFromObject,
            )));
    return GraphQLProvider(
      child: HomePage(),
      client: client,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GraphQL Client'),
        ),
        body: Query(
          options: QueryOptions(document: r"""
      query GetContinent($code: String!){
          continent(code: $code){
               name
               countries{
                name
                }             
           }
        } """, variables: <String, dynamic>{"code": "AS"}),
          builder: (
            QueryResult result, {
            VoidCallback refetch,
            FetchMore fetchMore,
          }) {
            if (result.loading) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(
                        result.data['continent']['countries'][index]['name']));
              },
              itemCount: result.data['continent']['countries'].length,
            );
          },
        ));
  }
}
