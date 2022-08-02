resource "aws_security_group" "gmgu_sg" {
    name = "gmgu-sg"
    description = "Allow 21,22,80,3306,icmp"
    vpc_id = aws_vpc.gmgu_vpc.id

    #들어오는 트래픽
    ingress = [ 
    #FTP
    {
        description = "FTP"
        from_port = 21
        to_port = 21
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = null
        security_groups = null
        self = null
    },
    #FTP-DATA
    {
        description = "FTP-DATA"
        from_port = 65000
        to_port = 65100
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = null
        security_groups = null
        self = null
    },
    #HTTP
    {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = null
        security_groups = null
        self = null
    },
    #MYSQL
    {
        description = "MYSQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = null
        security_groups = null
        self = null
    },
    #ICMP
    {
        description = "ICMP"
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = null
        security_groups = null
        self = null
    },
    #SSH
    {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = null
        security_groups = null
        self = null
    },
    ]


    #나가는 트래픽
    egress = [ 
    {
        description = "All Traffic"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = null
        security_groups = null
        self = null       
    } 
    ]

    tags = {
      "Name" = "gmgu-sg"
    }
}