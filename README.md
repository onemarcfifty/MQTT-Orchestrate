# MQTT-Orchestrate

![language](https://img.shields.io/github/languages/top/onemarcfifty/MQTT-Orchestrate)    ![License](https://img.shields.io/github/license/onemarcfifty/MQTT-Orchestrate)    ![Last Commit](https://img.shields.io/github/last-commit/onemarcfifty/MQTT-Orchestrate)     ![FileCount](https://img.shields.io/github/directory-file-count/onemarcfifty/MQTT-Orchestrate)    ![Stars](https://img.shields.io/github/stars/onemarcfifty/MQTT-Orchestrate)    ![Forks](https://img.shields.io/github/forks/onemarcfifty/MQTT-Orchestrate)

**WORK IN PROGRESS**

## What is it?

This repo provides a simple framework to synchronize or rather orchestrate workflows on multiple nodes using MQTT.

Sometimes I need to synchronize actions on multiple nodes, e.g. when I test Wi-fi routers. a test might look like this:

1. Run 3 instances of iperf3 server on a node
2. Run iperf3 for 10 seconds on node 1 in client mode
3. Run it for 20 seconds on node 2 and 1

and so on...

## How does that work?

As I said, we are using MQTT for this. I could of course use something a bit more sophisticated, like a Redis Server or Apache ZooKeeper. But for what I need to do, that's simply overkill. Here is how it works:

1. All nodes subscribe to the same root topic on the same MQTT Server
2. One node is the control node and orchestrates the tasks
3. The control node publishes instructions which the other nodes execute immediately once they receive the message

## How to use this

1. clone the repo to your control node.

``` bash
git clone https://github.com/onemarcfifty/MQTT-Orchestrate.git
cd MQTT-Orchestrate
```

2. Now edit the config file (you may want to specify the MQTT Server and topic as well as the client names) There is a sample file called `global.config.sample`
3. adapt the client scripts to your needs
4. adapt the playbooks to your need. There is a `playbook.sample` file as well
5. (optional) use ansible to distribute everything to the clients and start the scripts on the clients
6. launch the `./orchestrate.sh` script

## Why not use Ansible for everything?

Ansible is great for automation. I use it to distribute files and/or software or to run backups etc. However, the use case here is to have tasks be started _synchronously_ (within the possible jitter of the mqtt subscribe which is below 100 ms in my case). The choice for MQTT was quickly made because I have it running already in my environment and it serves the purpose with no additional cost. Furthermore, mosquitto is very lightweight (the alternative solutions may use java or python etc...)

## Pre-requisites and requirements

You need the following environment and/or software installed

- (optional) Ansible if you want to deploy using ansible-playbook
- (required) an MQTT Server such as mosquitto
- (required) mosquitto_sub and mosquitto_pub to communicate with MQTT

