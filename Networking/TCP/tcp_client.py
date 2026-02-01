import socket

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(("127.0.0.1", 5000))

client.send("Hello Server, TCP Works!".encode())

reply = client.recv(1024).decode()
print("Server replied:", reply)

client.close()
