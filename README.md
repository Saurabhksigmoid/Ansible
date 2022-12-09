First change the access key and secret access key as per your login details in terraform.tfvars file and save it.
Then create private and public keys using "keygen" in this case I have added id_rsa and id_rsa.pub keys which is not good practice while uploading on public repository.

Run "terraform init" command

then run "terraform plan" command to check the resources to be created

then run "terraform apply --auto-approve" to create instances.

Now login to your AWS console and check ec2 instances created. 2 instances will be created master and Node1.

Using scp command copy id_rsa key in the master ec2 instance "scp -i id_rsa id_rsa ubuntu@IPaddress:/home/ubuntu/.ssh/"

Also using scp commands copy playbookapache2.yml and mysqlplaybook.yml in master file.

use commands
"scp -i id_rsa playbookapache2.yml ubuntu@IPaddress:/home/ubuntu/"

"scp -i id_rsa mysqlplaybook.yml ubuntu@IPaddress:/home/ubuntu/"

From command line ssh into master using command "ssh -i id_rsa ubuntu@IPaddress"

As both nodes are created using same keys and configured with same public key master can ssh in node1 using id_rsa which is copied already using scp command.

Ansible is installed already using terraform so now we just need to make changes to configure it.

check ansible version using "ansible — version"

Now go to the hosts file of the ansible server and paste Private_IPs of all integrated nodes/servers

use command "sudo vi /etc/ansible/hosts" to enter make changes as below (use name demo only as further files are configured with this name)
# Ex 1: Ungrouped hosts, specify before any group headers.

[demo]

IP_ADD1

Next make changes in ansible.cfg file use command "sudo vi /etc/ansible/ansible.cfg"

    …..# some basic default values…
    # inventory = /etc/ansible/hosts
    # sudo_user = root

>Uncomment # inventory = /etc/ansible/hosts

# sudo_user = root -root privileges

Now make changes in sshd_config file
use command "sudo vi /etc/ssh/sshd_config
Do following changes and save the file

>Uncomment-(permitRootLogin yes)

# Authentication:
permissionRootLogin yes

Next restart sshd using command "sudo service sshd restart"

Check whether ansible is running using ad-hoc command 'ansible demo -a "ls -al"'

Now to run apache2 server using playbook use following command
"ansible-playbook playbookapache2.yml"

after running check its status using 'ansible demo -a "sudo service apache2 status"' or publicip of node1 of server.

Now to setup mysql on node1 run following command
'ansible-playbook mysqlplaybook.yml'

now to check sql installation ssh into node1 using "ssh IPaddress"

once inside the node1 shell
"mysql -u root -h localhost -p"
It will ask for password which is 'password' as per configuration

once inside the mysql command line
run "mysql>use testdb;"
run "mysql>show testdb;"

if output is test its running

if this command runs task completed.
