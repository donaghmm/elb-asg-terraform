# elb-asg-terraform


Shows how to launch instances using Auto Scaling Groups.

This creates launch configuration, auto scaling group and an ELB. The user data for launch configuration installs apache and tomcat and configure AJP on them.

We are using Ubuntu(14.04) AMIs.
The desired number of servers/host on each AZ's are 3.

Usage :

```
terraform plan -var 'key_name={your_key_name}'
```

```
terraform apply -var 'key_name={your_key_name}'
```

Once the stack is created, wait for few minutes and test the stack by launching a browser with ELB url.

To remove the stack

```
 terraform destroy -var 'key_name={your_key_name}'
```
