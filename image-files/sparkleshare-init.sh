#!/bin/bash

if [ ! -f /etc/dazzle.configured ]; then
	chown -R storage:storage /home/storage
	dazzle setup
	touch /etc/dazzle.configured
fi	

/usr/bin/supervisord
