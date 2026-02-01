import socket

website = input("Enter website name: ")

# If user forgets .com , .in etc, we can auto-fix by assuming .com
if "." not in website:
    website += ".com"

try:
    ip = socket.gethostbyname(website)

    print(f"Website: {website}")
    print(f"IP Address: {ip}")

    try:
        host_info = socket.gethostbyaddr(ip)
        print(f"Host Information: {host_info}")
    except socket.herror:
        print("Host Information: Not available")

except socket.gaierror:
    print("❌ Invalid website name. Please enter a valid domain (example: google.com)")
