# kubesetup

Install scripts for https://akomljen.com/get-kubernetes-logs-with-efk-stack-in-5-minutes

Thanks for this. I got it working in the end after adding helm, storage class and persistent volumes:

Here's what I did to get it working:
```
install-helm.sh
setup-efk-logging.sh
```
(nb: the setup-efk-logging.sh script will delete the namespace and persistent volumes if they exists)

It turns out centos 7 docker rpm has journald enabled by default and doesn't write logs to /var/log/containers. I just updated /etc/sysconfig/docker to remove the --log-driver=journald option and restarted docker and application logs are now showing up. Awesome, thanks again
```
# /etc/sysconfig/docker

# Modify these options if you want to change the way the docker daemon runs
#OPTIONS='--selinux-enabled --log-driver=journald --signature-verification=false'
OPTIONS='--selinux-enabled --signature-verification=false'
```
