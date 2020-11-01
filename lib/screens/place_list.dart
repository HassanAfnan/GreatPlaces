import 'package:flutter/material.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/screens/place_add.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AddPlace.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context,listen: false).fetchAndSetPlaces(),
        builder: (ctx,snapshot) => snapshot.connectionState == ConnectionState.waiting ?Center(child: CircularProgressIndicator()): Consumer<GreatPlaces>(
          child: Center(child: Text('No places yet'),),
          builder: (ctx2, greatPlaces, ch) => ListView.builder(
              itemCount: greatPlaces.items.length,
              itemBuilder: (ctx3,i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(greatPlaces.items[i].image),
                ),
                title: Text(greatPlaces.items[i].title),
                subtitle: Text(greatPlaces.items[i].location.address),
                onTap: (){
                },
              ),
          ),
        ),
      ),
    );
  }
}
