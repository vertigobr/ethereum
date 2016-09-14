#!/bin/bash
sudo apt-get install -y cifs-utils
sudo wget https://github.com/Azure/azurefile-dockervolumedriver/releases/download/v0.5.0/azurefile-dockervolumedriver -q -O /usr/bin/azurefile-dockervolumedriver
sudo wget https://raw.githubusercontent.com/Azure/azurefile-dockervolumedriver/master/contrib/init/upstart/azurefile-dockervolumedriver.conf -q -O /etc/init/azurefile-dockervolumedriver.conf
sudo wget https://raw.githubusercontent.com/Azure/azurefile-dockervolumedriver/master/contrib/init/upstart/azurefile-dockervolumedriver.default -q -O /etc/default/azurefile-dockervolumedriver
sudo initctl reload-configuration
sudo initctl start azurefile-dockervolumedriver


