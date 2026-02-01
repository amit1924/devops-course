import socket

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(("0.0.0.0", 8000))
server.listen()

print("Web Server running on port 8080...")

while True:
    conn, addr = server.accept()
    print("Connected:", addr)

    request = conn.recv(1024).decode()
    print(request)

    response = "HTTP/1.1 200 OK\r\nContent-Type:text/plain\r\n\r\nHello Amit!"
    conn.send(response.encode())
    conn.close()
