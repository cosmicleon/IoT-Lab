import sys
import time
import random
import cv2
from simple_ai import *
from uart import *

from Adafruit_IO import MQTTClient

AIO_FEED_ID = ["iot-lab.button1", "iot-lab.button2", "iot-lab.save-led"]
AIO_USERNAME = "cosmic_leon"
AIO_KEY = "aio_zRrZ45wf3t06dxHVALk4EuQf5UUG"


def connected(client):
    print("Connect successfully...")
    for topic in AIO_FEED_ID:
        client.subscribe(topic)


def subscribe(client, userdata, mid, granted_qos):
    print("Subscribe successfully...")


def disconnected(client):
    print("Disconnecting...")
    sys.exit(1)


def message(client , feed_id , payload):
    print("Received data: " + payload + ", feed id: " + feed_id)
    if feed_id == "iot-lab.button1":
        if payload == "0":
            writeData("Light off")
        else:
            writeData("Light on")
    if feed_id == "iot-lab.button2":
        if payload == "0":
            writeData("Pump off")
        else:
            writeData("Pump on")


client = MQTTClient(AIO_USERNAME, AIO_KEY)
client.on_connect = connected
client.on_disconnect = disconnected
client.on_message = message
client.on_subscribe = subscribe
client.connect()
client.loop_background()
# getPort()

counter = 10
counterAI = 5
previousAIresult = ""


while True:
    # # Publish sensor data
    # counter = counter - 1
    # if counter <= 0:
    #     counter = 10
    #     print("Random data is publishing...")
        # temp = random.randint(15, 60)
        # client.publish("sensor1", temp, "iot-lab")
    #     lumi = random.randint(100, 500)
    #     client.publish("sensor2", lumi, "iot-lab")
    #     humi = random.randint(50, 70)
    #     client.publish("sensor3", humi, "iot-lab")

    # # Publish AI data
    # counterAI = counterAI - 1
    # if counterAI <= 0:
    #     counterAI = 10
    #     aiResult = imageDectector()
    #     # if previousAIresult == aiResult:
    #     client.publish("ai", aiResult, "iot-lab")
    #     # previousAIresult = aiResult
    #     # print("AI Output: ", aiResult)

    # client.publish("ai", "Có ánh sáng", "iot-lab")

    readSerial(client)

    time.sleep(1)
    # Listen to the keyboard for presses.
    keyboard_input = cv2.waitKey(1)

    # 27 is the ASCII for the esc key on your keyboard.
    if keyboard_input == 27:
        break