# personal-vpn
set up your own PPTP vpn server so that clients can IP masquerade behind it. 

### Setup Steps
1. start an ubuntu 16.04 host somewhere
2. make sure port 1723 is available to clients that will connect to the vpn host by setting appropriate firewall rules to allow this to pass.
2. copy files from this project to that host
3. on your vpn host make sure you have created ~/.aws/config and ~/aws/credentials

config:
```
[default]
output = json
region = us-east-1
```

credentials:
```
[default]
aws_access_key_id = <your-aws-access-key-id>
aws_secret_access_key = <your-aws-secret-access-key>
```
4. run the following to setup the pptp server and set the hostname for your vpn server on route53
```
sudo ./vpn.sh <vpn-username> <vpn-password>
sudo pip install -r requirements.txt
./sethostname <route53-zone-id> <hostname>
```
4. setup your device as a vpn client, pointing to <hostname> authenticating with <vpn-username> and <vpn-password>

