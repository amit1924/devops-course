import socket

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(("0.0.0.0", 5000))
server.listen()

print("Server listening on port 5000...")

while True:
    conn, addr = server.accept()
    print("Connected:", addr)
    conn.send("Hello, you reached the right SOCKET!".encode())
    conn.close()
