* Create VPC(10.0.0.0/16)
  * Enable DNS hostnames
  * Enable DNS resolution
* Create Subnet1(10.0.1.0/24) attach to VPC
* Create Subnet2(10.0.2.0/24) attach to VPC
* Create Internet Gateway(connect to physical network)
* Edit Route Table which attached to VPC
  * Routes
    * Destination: 0.0.0.0/0
    * Target: Internet Gateway
  * Subnet Associations
    * Add Subnet1 Associate
    * Add Subnet2 Associate
* Design security group
  * Internet access
  * EC2
    * Inbound: ELB
    * Outbound: 0.0.0.0/0
  * RDS
    * Inbound: EC2
    * Outbound: 0.0.0.0/0
  * ELB
    * Inbound: 0.0.0.0/0
* Create RDS subnet group
* Create/Restore RDS
  * config VPC
  * config subnet
  * config security group when created
* Create EC2 from beanstalk
  * config VPC
  * config Environment Variable
  * config security group after created
* Create Target Group
  * add instance to target group
* Create ELB
  * after provisioning test traffic
