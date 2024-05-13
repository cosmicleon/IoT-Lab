import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';

import 'package:iot_lab/common/appbar_common.dart';
import 'package:iot_lab/common/title_selection.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class FarmEnvironment extends StatefulWidget {
  const FarmEnvironment({super.key});

  @override
  State<FarmEnvironment> createState() => _FarmEnvironment();
}

class _FarmEnvironment extends State<FarmEnvironment> {
  int currentPageIndex = 0;
  List<bool> area = [true, false];
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;
  bool vertical = false;

  final List<String> feedId = [
    "cosmic_leon/feeds/iot-lab.button1",
    "cosmic_leon/feeds/iot-lab.button2",
    "cosmic_leon/feeds/iot-lab.save-led"
  ];
  final List<String> topic = [
    "cosmic_leon/feeds/iot-lab.sensor1",
    "cosmic_leon/feeds/iot-lab.sensor2",
    "cosmic_leon/feeds/iot-lab.sensor3"
  ];
  // final MQTTAppState _currentState;
  final String server = 'io.adafruit.com';
  // final String server = "tcp://io.adafruit.com:1883";
  // final String server = "tcp://io.adafruit.com:1883";
  final String username = "cosmic_leon";
  final String key = "aio_zRrZ45wf3t06dxHVALk4EuQf5UUG";
  double temp = 20.0;
  double lumi = 100.0;
  double humi = 50.0;
  // dynamic appClient;

  // Future<void> makeClient() async {
  //   appClient = await connect();
  // }

  // late MqttClient appClient;

  MqttServerClient client =
      MqttServerClient.withPort('io.adafruit.com', "cosmic_leon", 1883);

  // Future<MqttClient> appClient = connect();

  // // MqttServerClient client =
  // //     MqttServerClient.withPort('broker.emqx.io', 'flutterclient', 1883);
  // final MqttServerClient client = MqttServerClient.withPort(
  //     "tcp://io.adafruit.com:1883", 'flutterclient', 1883);
  // // client.keepAlivePeriod(60);
  // final connMessage = MqttConnectMessage()
  //     .authenticateAs('cosmic_leon', 'aio_zRrZ45wf3t06dxHVALk4EuQf5UUG')
  //     .withWillTopic('willtopic')
  //     .withWillMessage('Will message')
  //     .startClean()
  //     .withWillQos(MqttQos.atLeastOnce);

  // void connect() async {
  //   // assert(client != null);
  //   // try {
  //   //   print('EXAMPLE::Mosquitto start client connecting....');
  //   //   _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
  //   //   await client!.connect();
  //   // } on Exception catch (e) {
  //   //   print('EXAMPLE::client exception - $e');
  //   //   disconnect();
  //   // }
  //   try {
  //     print('---------------------> Connecting');
  //     await client.connect();
  //     for (var topic in feedId) client.subscribe(topic, MqttQos.atLeastOnce);
  //   } catch (e) {
  //     print('---------------------> Exception: $e');
  //     client.disconnect();
  //   }
  //   print("---------------------> Connected");
  // }

  // void disconnect() {
  //   print('---------------------> Disconnected');
  //   client!.disconnect();
  // }

  // // void subscribe(topic) async {
  // //   try {
  // //     print('Subscribing');
  // //     // await client.subscribe("topic/test", MqttQos.atLeastOnce);
  // //     await client.subscribe(topic, MqttQos.atLeastOnce);
  // //   } catch (e) {
  // //     print('Exception: Cannot subscribe to $topic $e');
  // //     client.disconnect();
  // //   }
  // // }

  // /// The subscribed callback
  // void onSubscribed(String topic) {
  //   print('---------------------> Subscription confirmed for topic $topic');
  // }

  // /// The unsolicited disconnect callback
  // void onDisconnected() {
  //   print(
  //       '---------------------> OnDisconnected client callback - Client disconnection');
  //   if (client!.connectionStatus!.returnCode ==
  //       MqttConnectReturnCode.noneSpecified) {
  //     print(
  //         '---------------------> OnDisconnected callback is solicited, this is correct');
  //   }
  //   // _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  // }

  // /// The successful connect callback
  // void onConnected() {
  //   // _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
  //   print('---------------------> Client connected....');
  //   // client!.subscribe(_topic2, MqttQos.atLeastOnce);
  //   client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
  //     // ignore: avoid_as
  //     final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

  //     // final MqttPublishMessage recMess = c![0].payload;
  //     final String pt =
  //         MqttPublishPayload.bytesToStringAsString(recMess.payload.message!);
  //     // _currentState.setReceivedText(pt);
  //     print(
  //         '---------------------> Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
  //     print('');
  //   });
  //   print(
  //       '---------------------> OnConnected client callback - Client connection was sucessful');
  // }

  // // client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
  // //     final recMessage = c![0].payload as MqttPublishMessage;
  // //     final payload = MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);

  // //     print('Received message:$payload from topic: ${c[0].topic}');
  // //   });

  // //   return client;
  // // }

  // // client.onConnected = onConnected;
  // // client.onDisconnected = onDisconnected;
  // // client.onUnsubscribed = onUnsubscribed;
  // // client.onSubscribed = onSubscribed;

  // // client.connectionMessage = connMessage;

  // // List<bool> _selectedArea = [true, false];

  Future<void> publish(String topic, String message) async {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    try {
      client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    } catch (e) {
      print('Exception: Cannot subscribe to $topic $e');
      // await appClient!.disconnect();
    }
  }

  @override
  void initState() {
    super.initState();
    // appClient = await connect();
    // makeClient();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBarCommon(
        topTitle: 'Farm Dashboard',
        navBack: false,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.yard),
            label: 'Switch',
          ),
        ],
      ),
      body: <Widget>[
        // Page 1: Home page
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TitleSelection(
                  name: "Temperature: $temp °C",
                  type: 0,
                  status: 0,
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TitleSelection(
                  name: "Luminity: $lumi lux",
                  type: 0,
                  status: 1,
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TitleSelection(
                  name: "Humidity: $humi %",
                  type: 0,
                  status: 2,
                ),
              ]),
            ]),

        // Page 2: Switch
        Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // for (var i = 0; i < area.length; i++)
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      switch1
                          ? const Icon(Icons.my_location)
                          : const Icon(Icons.location_searching),
                      Text(
                        'Light',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      ToggleButtons(
                        direction: vertical ? Axis.vertical : Axis.horizontal,
                        onPressed: (int index) {
                          publish(feedId[0], index.toString());
                          setState(() {
                            switch1 = (index == 1);
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor:
                            switch1 ? Colors.green[700] : Colors.red[700],
                        selectedColor: Colors.white,
                        fillColor:
                            switch1 ? Colors.green[200] : Colors.red[200],
                        color: switch1 ? Colors.green[400] : Colors.red[400],
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: [(!switch1), switch1],
                        children: const <Widget>[
                          Text('OFF'),
                          Text('ON'),
                        ],
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      switch2
                          ? const Icon(Icons.my_location)
                          : const Icon(Icons.location_searching),
                      Text(
                        'Pump',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      ToggleButtons(
                        direction: vertical ? Axis.vertical : Axis.horizontal,
                        onPressed: (int index) {
                          setState(() {
                            switch2 = (index == 1);
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor:
                            switch2 ? Colors.green[700] : Colors.red[700],
                        selectedColor: Colors.white,
                        fillColor:
                            switch2 ? Colors.green[200] : Colors.red[200],
                        color: switch2 ? Colors.green[400] : Colors.red[400],
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: [(!switch2), switch2],
                        children: const <Widget>[
                          Text('OFF'),
                          Text('ON'),
                        ],
                      ),
                    ]),
                // Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         area[i]
                //             ? const Icon(Icons.my_location)
                //             : const Icon(Icons.location_searching),
                //         Text(
                //           'Switch ${i + 1}',
                //           style: theme.textTheme.titleLarge,
                //         ),
                //         const SizedBox(
                //           width: 40,
                //         ),
                //         ToggleButtons(
                //           direction: vertical ? Axis.vertical : Axis.horizontal,
                //           onPressed: (int index) {
                //             setState(() {
                //               area[i] = (index == 1);
                //             });
                //           },
                //           borderRadius:
                //               const BorderRadius.all(Radius.circular(8)),
                //           selectedBorderColor:
                //               area[i] ? Colors.green[700] : Colors.red[700],
                //           selectedColor: Colors.white,
                //           fillColor:
                //               area[i] ? Colors.green[200] : Colors.red[200],
                //           color: area[i] ? Colors.green[400] : Colors.red[400],
                //           constraints: const BoxConstraints(
                //             minHeight: 40.0,
                //             minWidth: 80.0,
                //           ),
                //           isSelected: [(!area[i]), area[i]],
                //           children: const <Widget>[
                //             Text('OFF'),
                //             Text('ON'),
                //           ],
                //         ),
                //       ]),
                const SizedBox(
                  height: 100,
                ),
              ],
            )),
      ][currentPageIndex],
    );
  }

//------------------------------------------------//
  Future<void> connect() async {
// MqttClient connect() {
    final String server = 'io.adafruit.com';
    // final String server = "tcp://io.adafruit.com:1883";
    final String username = "cosmic_leon";
    final String key = "aio_zRrZ45wf3t06dxHVALk4EuQf5UUG";
    final List<String> feedId = [
      "iot-lab.button1",
      "cosmic_leon/feeds/iot-lab.button2",
      "cosmic_leon/feeds/iot-lab.save-led"
    ];
    final List<String> topic = [
      "cosmic_leon/feeds/iot-lab.sensor1",
      "cosmic_leon/feeds/iot-lab.sensor2",
      "cosmic_leon/feeds/iot-lab.sensor3"
    ];
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    // Security context
//  SecurityContext context = new SecurityContext()
//    ..useCertificateChain('path/to/my_cert.pem')
//    ..usePrivateKey('path/to/my_key.pem', password: 'my_key_password')
//    ..setClientAuthorities('path/to/client.crt', password: 'password');
//  client.secure = true;
//  client.securityContext = context;

    final connMess = MqttConnectMessage()
        .authenticateAs(username, key)
        .withWillTopic('cosmic_leon/feeds/iot-lab.button1')
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;
    try {
      print('Connecting');
      await client.connect();
      try {
        print('---------------------> Connecting');
        await client.connect();
        for (var top in (feedId + topic)) {
          try {
            client.subscribe(top, MqttQos.atLeastOnce);
          } catch (e) {
            print('---------------------> Fail to subscibe $top');
          }
          print('---------------------> Subscribe to $top');
        }
      } catch (e) {
        print('---------------------> Exception: $e');
        print('---------------------> Disconnect when subscibe');
        client.disconnect();
      }
      print("---------------------> Topic Connected");
    } catch (e) {
      print('Exception: $e');
      print('---------------------> Disconnect when connect');
      client.disconnect();
    }
    print("connected");

    try {
      client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMessage = c![0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(
            recMessage.payload.message);

        print('Received message:$payload from topic: ${c[0].topic}');
      });
    } catch (e) {
      print('Exception: $e');
      // client.disconnect();
    }
    // print("New message!!!");

    // return client;
  }
}

//--------------------------------------//

// Connected callback
void onConnected() {
  print('Connected');
}

// Disconnected callback
void onDisconnected() {
  print('Disconnected');
}

// Subscribed callback
void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

// Subscribed failed callback
void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

// Unsubscribed callback
void onUnsubscribed(String? topic) {
  print('Unsubscribed topic: $topic');
}

// Ping callback
void pong() {
  print('Ping response client callback invoked');
}
