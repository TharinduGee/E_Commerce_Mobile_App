import 'package:flutter/material.dart';
import 'package:namer_app/services/storage_service.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _MyWidgetState();
}

final Storage store = Storage();
//final Future<List<String>> result = store.fetchImages();

class _MyWidgetState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Gallery",
            style: const TextStyle(
              color: Color(0xFF393939),
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Color(0xFF755DC1),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: FutureBuilder<List<String>>(
            future: store.fetchImages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No image URLs available.'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust the number of columns as needed
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          
                        ),
                        child:
                          Image.network(snapshot.data![index],
                          fit: BoxFit.cover
                          )
                          ,                    
                        
                      );
                    },
                  ),
                );
              }
            },
          ),
  ));
  }
}