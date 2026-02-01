def rdt_send(data):
    print("Sender: Sending data ->", data)
    packet = data
    udt_send(packet)

def udt_send(packet):
    print("Channel: Delivering packet safely")
    rdt_rcv(packet)

def rdt_rcv(packet):
    print("Receiver: Received ->", packet)
    deliver_data(packet)

def deliver_data(data):
    print("Delivered to application:", data)


rdt_send("HELLO AMIT")
