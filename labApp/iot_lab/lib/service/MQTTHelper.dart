// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';
// // import android.content.Context;
// // import android.os.Build;
// // import android.util.Log;

// // import org.eclipse.paho.android.service.MqttAndroidClient;
// // import org.eclipse.paho.client.mqttv3.DisconnectedBufferOptions;
// // import org.eclipse.paho.client.mqttv3.IMqttActionListener;
// // import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
// // import org.eclipse.paho.client.mqttv3.IMqttToken;
// // import org.eclipse.paho.client.mqttv3.MqttCallbackExtended;
// // import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
// // import org.eclipse.paho.client.mqttv3.MqttException;
// // import org.eclipse.paho.client.mqttv3.MqttMessage;


// class MQTTHelper {
//     final List<String> arrayTopics = ["cosmic_leon/feeds/iot-lab.sensor1", "cosmic_leon/feeds/iot-lab.sensor2", "cosmic_leon/feeds/iot-lab.sensor3"];

//     final String clientId = "ABCD5678";
//     final String username = "cosmic_leon";
//     final String password = "aio_zRrZ45wf3t06dxHVALk4EuQf5UUG";

//     final String serverUri = "tcp://io.adafruit.com:1883";

//     MQTTHelper(){
//         MqttServerClient client = MqttServerClient(
//         "tcp://io.adafruit.com:1883", 'flutter_client');
//         client.setCallback(new MqttCallbackExtended() {
//             @Override
//             public void connectComplete(boolean b, String s) {
//                 Log.w("mqtt", s);
//             }

//             @Override
//             public void connectionLost(Throwable throwable) {

//             }

//             @Override
//             public void messageArrived(String topic, MqttMessage mqttMessage) throws Exception {
//                 Log.w("Mqtt", mqttMessage.toString());
//             }

//             @Override
//             public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {

//             }
//         });
//         connect();
//     }

//     void setCallback(MqttCallbackExtended callback) {
//         mqttAndroidClient.setCallback(callback);
//     }

//     private void connect(){
//         MqttConnectOptions mqttConnectOptions = new MqttConnectOptions();
//         mqttConnectOptions.setAutomaticReconnect(true);
//         mqttConnectOptions.setCleanSession(false);
//         mqttConnectOptions.setUserName(username);
//         mqttConnectOptions.setPassword(password.toCharArray());

//         try {

//             mqttAndroidClient.connect(mqttConnectOptions, null, new IMqttActionListener() {
//                 @Override
//                 public void onSuccess(IMqttToken asyncActionToken) {

//                     DisconnectedBufferOptions disconnectedBufferOptions = new DisconnectedBufferOptions();
//                     disconnectedBufferOptions.setBufferEnabled(true);
//                     disconnectedBufferOptions.setBufferSize(100);
//                     disconnectedBufferOptions.setPersistBuffer(false);
//                     disconnectedBufferOptions.setDeleteOldestMessages(false);
//                     mqttAndroidClient.setBufferOpts(disconnectedBufferOptions);
//                     subscribeToTopic();
//                 }

//                 @Override
//                 public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
//                     Log.w("Mqtt", "Failed to connect to: " + serverUri + exception.toString());
//                 }
//             });


//         } catch (MqttException ex){
//             ex.printStackTrace();
//         }
//     }

//     private void subscribeToTopic() {
//         for(int i = 0; i < arrayTopics.length; i++) {
//             try {
//                 mqttAndroidClient.subscribe(arrayTopics[i], 0, null, new IMqttActionListener() {
//                     @Override
//                     public void onSuccess(IMqttToken asyncActionToken) {
//                         Log.d("TEST", "Subscribed!");
//                     }

//                     @Override
//                     public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
//                         Log.d("TEST", "Subscribed fail!");
//                     }
//                 });

//             } catch (MqttException ex) {
//                 System.err.println("Exceptionst subscribing");
//                 ex.printStackTrace();
//             }
//         }
//     }

// }