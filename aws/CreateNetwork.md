* Create VPC(10.0.0.0/16)
  * Enable DNS hostnames
  * Enable DNS resolution
* Create Subnet1(10.0.1.0/24) attach to VPC
* Create Subnet2(10.0.2.0/24) attach to VPC
* Create Internet Gateway(connect to physical network)
* Create Route Table attach to VPC
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
    * Outbound: EC2
  * ELB?
