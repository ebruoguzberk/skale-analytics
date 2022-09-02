#!/bin/sh
python3 load_node_health_check.py
python3 load_hardware.py
python3 load_node_containers.py
python3 load_node_core.py
python3 load_schain_info.py
python3 load_schain_health_check.py



