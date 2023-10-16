import 'package:flutter/material.dart';
import 'package:flutter_get_api/newpage.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Models/posts_model.dart';

class ExampleOne extends StatelessWidget {
  ExampleOne({Key? key}) : super(key: key);

  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final resposne =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(resposne.body.toString());
    if (resposne.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Video',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: const Row(
              children: [
                Expanded(child: Text('Trending')),
                Expanded(child: Text('Trending')),
                Expanded(child: Text('Trending Feature')),
                
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Loading');
                } else {
                  return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 184,
                          height: 242,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(width: 1)),
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () { 
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Detail()));
                             },
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Expanded(
                                child: Text(
                                  postList[index].title.toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/a.jpeg'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ),
                          
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
