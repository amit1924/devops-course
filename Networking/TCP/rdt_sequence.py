last_received = None

def receiver(packet, seq):
    global last_received

    print(f"\nReceiver got packet: {packet} | seq={seq}")

    if seq == last_received:
        print("Duplicate packet ❌ IGNORE")
        return

    print("New packet 👍 Delivering")
    last_received = seq
