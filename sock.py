#!/usr/bin/env python3

import socket

services = {'drive.google.com': '0.0.0.0', 'mail.google.com':  '0.0.0.0', 'google.com': '0.0.0.0'}

for service in services:
    ipaddr = socket.gethostbyname(service)
    services[service] = ipaddr

print(services)