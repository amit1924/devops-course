import socket

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

msg = "Hello from UDP!"
client.sendto(msg.encode(), ("127.0.0.1", 6000))

data, addr = client.recvfrom(1024)
print("Server says:", data.decode())
