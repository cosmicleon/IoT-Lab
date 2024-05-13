import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:iot_lab/common/appbar_common.dart';

class FarmDashboard extends StatefulWidget {
  const FarmDashboard({super.key});

  @override
  State<FarmDashboard> createState() => _FarmDashboard();
}

class _FarmDashboard extends State<FarmDashboard> {
  int currentPageIndex = 0;

  // List<bool> _selectedArea = [true, false];
  List<bool> area = [true, false, false];
  int mixer = 0;
  List<bool> pump = [false, false];
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

  // @override
  // void initState() {
  //   super.initState();
  // }

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
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.home),
          //   icon: Icon(Icons.home_outlined),
          //   label: 'Home',
          // ),
          NavigationDestination(
            icon: Icon(Icons.yard),
            label: 'Area',
          ),
          NavigationDestination(
            icon: Icon(Icons.blender),
            label: 'Mixer',
          ),
          NavigationDestination(
            icon: Icon(Icons.shower),
            label: 'Pump',
          ),
        ],
      ),
      body: <Widget>[
        // Page 1: Home page
        // Card(
        //   shadowColor: Colors.transparent,
        //   margin: const EdgeInsets.all(8.0),
        // child: Column(
        //   children: <Widget>[
        //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'Area 1',
        //         style: theme.textTheme.titleLarge,
        //       ),
        //       const SizedBox(
        //         width: 30,
        //       ),
        //       ToggleButtons(
        //         direction: vertical ? Axis.vertical : Axis.horizontal,
        //         onPressed: (int index) {
        //           setState(() {
        //             for (int i = 0; i < pump.length; i++) {
        //               pump[i] = i == index;
        //             }
        //           });
        //         },
        //         borderRadius: const BorderRadius.all(Radius.circular(8)),
        //         selectedBorderColor: Colors.green[700],
        //         selectedColor: Colors.white,
        //         fillColor: Colors.green[200],
        //         color: Colors.green[400],
        //         constraints: const BoxConstraints(
        //           minHeight: 40.0,
        //           minWidth: 80.0,
        //         ),
        //         isSelected: pump,
        //         children: const <Widget>[
        //           Text('OFF'),
        //           Text('ON'),
        //         ],
        //       ),
        //     ]),
        //   ],
        // ),
        //   child: Positioned(
        //     child: Text(
        //       'Home',
        //       style: theme.textTheme.titleLarge,
        //     ),
        //   ),

        // ),

        // Page 2: Area
        Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var i = 0; i < area.length; i++)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        area[i]
                            ? const Icon(Icons.my_location)
                            : const Icon(Icons.location_searching),
                        Text(
                          'Area ${i + 1}',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        ToggleButtons(
                          direction: vertical ? Axis.vertical : Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              area[i] = (index == 1);
                            });
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          selectedBorderColor:
                              area[i] ? Colors.green[700] : Colors.red[700],
                          selectedColor: Colors.white,
                          fillColor:
                              area[i] ? Colors.green[200] : Colors.red[200],
                          color: area[i] ? Colors.green[400] : Colors.red[400],
                          constraints: const BoxConstraints(
                            minHeight: 40.0,
                            minWidth: 80.0,
                          ),
                          isSelected: [(!area[i]), area[i]],
                          children: const <Widget>[
                            Text('OFF'),
                            Text('ON'),
                          ],
                        ),
                      ]),
                const SizedBox(
                  height: 100,
                ),
              ],
            )),

        // Page 3: Mixer
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              for (var index = 1; index < 4; index++)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Mixer $index',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          mixer++;
                          if (mixer > 4) {
                            mixer = 0;
                          }
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: () {
                              if (mixer < index) {
                                return Color.fromARGB(255, 94, 240, 228);
                              } else if (mixer == index) {
                                return Color.fromARGB(255, 138, 240, 94);
                              } else {
                                return Color.fromARGB(255, 240, 199, 94);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: () {
                            if (mixer < index) {
                              return const Text(
                                'FREE',
                                style: TextStyle(
                                  color: Color(0xff46793A),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else if (mixer == index) {
                              return const Text(
                                'MIXING...',
                                style: TextStyle(
                                  color: Color(0xff46793A),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return const Text(
                                'DONE',
                                style: TextStyle(
                                  color: Color(0xff46793A),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }())),
                ]),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      mixer++;
                      if (mixer > 4) {
                        mixer = 0;
                      }
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffF0F05E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'NEXT PHASE',
                        style: TextStyle(
                          color: Color(0xff46793A),
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
            ],
          ),
        ),

        // Page 4: Pump
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var i = 0; i < pump.length; i++)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        pump[i]
                            ? const Icon(Icons.water_drop)
                            : const Icon(Icons.water_drop_outlined),
                        Text(
                          'Pump ${i + 1}',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        ToggleButtons(
                          direction: vertical ? Axis.vertical : Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              pump[i] = (index == 1);
                            });
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          selectedBorderColor:
                              pump[i] ? Colors.green[700] : Colors.red[700],
                          selectedColor: Colors.white,
                          fillColor:
                              pump[i] ? Colors.green[200] : Colors.red[200],
                          color: pump[i] ? Colors.green[400] : Colors.red[400],
                          constraints: const BoxConstraints(
                            minHeight: 40.0,
                            minWidth: 80.0,
                          ),
                          isSelected: [(!pump[i]), pump[i]],
                          children: const <Widget>[
                            Text('OFF'),
                            Text('ON'),
                          ],
                        ),
                      ]),
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       pump2
                //           ? const Icon(Icons.water_drop)
                //           : const Icon(Icons.water_drop_outlined),
                //       Text(
                //         'Pump 2',
                //         style: theme.textTheme.titleLarge,
                //       ),
                //       const SizedBox(
                //         width: 40,
                //       ),
                //       ToggleButtons(
                //         direction: vertical ? Axis.vertical : Axis.horizontal,
                //         onPressed: (int index) {
                //           setState(() {
                //             pump2 = (index == 1);
                //           });
                //         },
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(8)),
                //         selectedBorderColor:
                //             pump2 ? Colors.green[700] : Colors.red[700],
                //         selectedColor: Colors.white,
                //         fillColor: pump2 ? Colors.green[200] : Colors.red[200],
                //         color: pump2 ? Colors.green[400] : Colors.red[400],
                //         constraints: const BoxConstraints(
                //           minHeight: 40.0,
                //           minWidth: 80.0,
                //         ),
                //         isSelected: [(!pump2), pump2],
                //         children: const <Widget>[
                //           Text('OFF'),
                //           Text('ON'),
                //         ],
                //       ),
                //     ]),
                const SizedBox(
                  height: 150,
                ),
              ]),
        ),
      ][currentPageIndex],
    );
  }

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
