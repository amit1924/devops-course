import socket

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(("0.0.0.0", 5000))
server.listen()

print("Server is listening on port 5000...")

conn,addr=server.accept()
print(f"Connection established with {addr}")

data=conn.recv(1024).decode()
print(f"Client says: {data}")

conn.send("Hello from server!".encode())
conn.close()
server.close()

