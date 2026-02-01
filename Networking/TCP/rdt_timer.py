import time
import random

def send_packet():
    print("\nSender: sending packet...")
    return random.choice(["ACK", "LOST"])

def sender():
    result = send_packet()
    start = time.time()

    while True:
        if result == "ACK":
            print("Sender: ACK received 👍")
            break

        if time.time() - start > 2:
            print("Sender: timeout ⏳ — retransmitting...")
            return sender()

sender()
