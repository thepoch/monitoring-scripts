# monitoring-scripts

These are just some scripts I use to monitor my servers. I usually put them all in `/usr/local/sbin`.

* `monitorvars.conf` - main configuration file. Set an IP address to exclude, as well as the EMAIL address to send notifications to.
* `monitordisk.sh` - monitors disk usage. Creates a file in /tmp and sends its content to the EMAIL defined above.
* `monitorload.sh` - monitors server load. Creates a file in /tmp and sends its content to the EMAIL defined above.

The scripts above should be have crontab entries for them. I usually set something like:

	#Ansible: monitordisk.sh
	0 7,15,23 * * * /usr/local/sbin/monitordisk.sh
	#Ansible: monitorload.sh
	*/10 * * * * /usr/local/sbin/monitorload.sh

* `ssh-alert.sh` - script to send an email notification whenever someone successfully signs in using ssh. Must be called via pam. Add in `/etc/pam.d/sshd` the following line:

	`session    optional    pam_exec.so seteuid /usr/local/sbin/ssh-alert.sh`
