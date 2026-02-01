import socket 

hostname=socket.gethostname()
local_ip=socket.gethostbyname(hostname)

print(f'Your device name is: {hostname}')
print(f'Your local IP address is: {local_ip}')