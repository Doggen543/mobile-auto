# -*- coding: utf-8 -*-
from selenium import webdriver
import socket


def get_ip_and_free_port():
    ip = [(s.connect(('8.8.8.8', 53)), s.getsockname()[0], s.close()) for s in
                    [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1]
    port = webdriver.common.utils.free_port()
    return {'ip': ip, 'port': port}
