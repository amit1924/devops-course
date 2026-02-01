import socket

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server.bind(("0.0.0.0", 6000))

print("UDP Server Running...")

while True:
    data, addr = server.recvfrom(1024)
    print("Client:", data.decode())
    server.sendto("Got your message!".encode(), addr)
