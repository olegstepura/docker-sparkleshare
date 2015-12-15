# vim:set ft=dockerfile:
FROM debian:jessie

ENV TERM=xterm

COPY image-files/ /

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		openssh-server \
		build-essential \
		lsb-invalid-mta \
		supervisor \
		rsyslog \
		git && \

	# share log files with host
	mkdir /var/log/host/ && \
	sed -i 's/\/var\/log\/auth\.log/\/var\/log\/host\/auth.log/' /etc/rsyslog.conf && \
	mv /tmp/sshd_config /etc/ssh/ && \
	mv /tmp/supervisord.conf /etc/supervisor/conf.d/ && \

	# openssh wants this
	mkdir /var/run/sshd && \
	chmod 0755 /var/run/sshd && \

	useradd fanout && \
	mkdir /tmp/fanout && \
	git clone https://github.com/travisghansen/fanout.git /tmp/fanout && \

	cd /tmp/fanout && \
	make fanout && \
	cp fanout /usr/local/bin/ && \

	# Commented out since should be done after mounting volume to home dir
	#dazzle setup && \
	apt-get remove -y build-essential && \
	apt-get autoremove -y && \
	apt-get clean -qq && \
  	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22 1986

CMD ["/sparkleshare-init.sh"]
