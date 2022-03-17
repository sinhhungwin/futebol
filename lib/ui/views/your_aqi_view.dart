import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/your_aqi_model.dart';
import 'package:fimii/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import "package:latlong/latlong.dart" as latLng;

import 'base_view.dart';

class YourAqiView extends StatelessWidget {
  final f = DateFormat('EEEE dd,MMM', "en_US");

  String city, state, country;
  latLng.LatLng coordinates;

  YourAqiView({this.city, this.state, this.country, this.coordinates});

  @override
  Widget build(BuildContext context) {
    return BaseView<YourAqiModel>(
        onModelReady: (model) {
          model.onModelReady(city, state, country, coordinates);
        },
        builder: (context, child, model) => Scaffold(
          body: viewOptions(model, context),
        ));
  }

  Widget viewOptions(YourAqiModel model, context) {
    switch(model.state) {
      case ViewState.Busy:
        return Center(child: CircularProgressIndicator());

      case ViewState.Error:
        return Text(
          model.error.toString(),
          style: TextStyle(color: Colors.red),
        );

      case ViewState.Retrieved:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: setGradient(model.data.data.current.weather.ic),
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // City name
                    Text(
                      model.data.data.city,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      f.format(model.data.data.current.weather.ts),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        setImage(model.data.data.current.weather.ic),
                        scale: 1.5,
                      ),
                    ),
                    Text(
                      '${model.data.data.current.weather.tp}\u2103',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      setWeather(model.data.data.current.weather.ic),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.12,
                expand: true,
                builder: (BuildContext c, s) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      controller: s,
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 8,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: setColor(
                                model.data.data.current.pollution.mainus),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: setColorDark(model.data.data
                                        .current.pollution.mainus),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  width: 80.0,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  padding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Index AQI',
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        '${model.data.data.current.pollution.aqius}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Air Quality Description
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text('Air Quality'),
                                    Text(
                                      setAqi(model.data.data.current
                                          .pollution.aqius),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                            title: Text('Humidity'),
                            trailing: Text(
                                '${model.data.data.current.weather.hu}%')),
                        ListTile(
                            title: Text('Wind'),
                            trailing: Text(
                                '${model.data.data.current.weather.ws} m/s')),
                        ListTile(
                            title: Text('Pressure'),
                            trailing: Text(
                                '${model.data.data.current.weather.pr} mb')),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await Share.share(
                              'Air quality is ' + setAqi(model
                                  .data.data.current.pollution.aqius),
                              subject: 'AQI',
                            );
                          },
                          icon: Icon(Icons.share),
                          label: Text('Share'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
    }

    return Container();
  }
}
