import random

def rdt_send(data):
    print("\nSender: sending ->", data)
    packet = data
    udt_send(packet)

def udt_send(packet):
    # randomly corrupt
    if random.choice([True, False]):
        packet = "CORRUPTED"
    rdt_rcv(packet)

def rdt_rcv(packet):
    if packet == "CORRUPTED":
        print("Receiver: Packet corrupted ❌")
        send_NAK()
    else:
        print("Receiver: Packet OK 👍")
        send_ACK(packet)

def send_ACK(packet):
    print("Receiver: Sending ACK")
    deliver_data(packet)

def send_NAK():
    print("Receiver: Sending NAK — resend needed")

def deliver_data(data):
    print("DATA DELIVERED:", data)


for _ in range(4):
    rdt_send("HELLO")
