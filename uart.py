import serial.tools.list_ports
# import serial

def getPort():
    ports = serial.tools.list_ports.comports()
    N = len(ports)
    commPort = "None"
    for i in range(0, N):
        port = ports[i]
        strPort = str(port)
        if "USB Serial Device" in strPort:
            splitPort = strPort.split(" ")
            commPort = (splitPort[0])
        # print("Port: ", strPort)
    # return commPort
    return "COM16"

# port = getPort()
# if port != "None":
#     # ser = serial.Serial( port=getPort(), baudrate=115200)
#     ser = serial.Serial(port, 115200)
#     print(ser)
if getPort() != "None":
    ser = serial.Serial( port=getPort(), baudrate=115200)
    print(ser)
else:
    print("Getting port failed!")

def processData(client, data):
    # !1:T:43.1##
    data = data.replace("!", "")
    data = data.replace("#", "")
    splitData = data.split(":")
    print("Data: ", splitData)
    if splitData[1] == "T":
        client.publish("sensor1", splitData[2], "iot-lab")
    if splitData[1] == "L":
        client.publish("sensor2", splitData[2], "iot-lab")
    if splitData[1] == "H":
        client.publish("sensor3", splitData[2], "iot-lab")

mess = ""
def readSerial(client):
    bytesToRead = ser.inWaiting()
    if (bytesToRead > 0):
        global mess
        mess = mess + ser.read(bytesToRead).decode("UTF-8")
        while ("#" in mess) and ("!" in mess):
            start = mess.find("!")
            end = mess.find("#")
            processData(client, mess[start:end + 1])
            if (end == len(mess)):
                mess = ""
            else:
                mess = mess[end+1:]

def writeData(data):
    ser.write(str(data).encode("UTF-8"))
    # ser.write(str(data).encode())