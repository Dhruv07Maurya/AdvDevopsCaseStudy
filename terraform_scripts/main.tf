provider "aws" {
    access_key = "ASIA2LNKVMF5MOYQJGEA"
    secret_key = "+VDWb8lJCsrrODjR71SW0f+lZrTKP0uRLx285You"
    token      = "IQoJb3JpZ2luX2VjEPz//////////wEaCXVzLXdlc3QtMiJIMEYCIQD/ppf9gkyUPZYfk73xavBSxjyYi9ATxP70hqKoX6cjjwIhANt4C7XwED8eXDTRI0Oer/f74RRKbOSgYiseu8IE7RIfKrUCCGUQABoMNzExNzExODc1NDUwIgz5dxWCHM60oK1RLz4qkgLvl4iYOu6OIg9aJaw2Tbijw67fdo1+fIzP2tTHmCENsRqvSAam1FBNGhJ0Q1Ami/xeW+CqKKrlE1slF7pbEZa22OInnILUgOp3YKdLoZ/CY4y3QGNVtBMurbRgNuxrUJCrYTvbXNkJyNZ/UWFo+r3tokJ5QfBeiZaRzzf8VJwC9oqUAiORMaxzf/AGaBr338vSNYk2nL4jktLGsI/NbQYHEsFVx0J7X5OdWnB86SwWVt1GXLzEx6pl1VIBOsf1wt9XVPIEAEtEDRenHYFnunhY5oNc4yvOzVdNlzR8nqAuIktSzlYz50meG3HirufGlJCs+fMWpnewdEnGQN3PquDiFuoqm9+67y9qojKGaM6Z12MtMKiQ0LgGOpwBkIURD4rC3kXDuJn3Jp1abj7s7rcuVdQs+8O33isROkiu3FqJ/Ch6szmj8BkA8CSA6QShJv0x0nZWSw9982mp/3hPsY4JYUxs9lPluXVD8xLXmWzDANhrbdXeVuVHjlwHIOTPF9xtR8n/4PE1ThPhc86LBfsbSxzisUSt9MheG8CBQeoFvee3U7YRum7XEd0oZvK1yNN0IkO6b5lR"
    region      = "us-west-2"
}

module "ec2_instance" {
    source = "./EC2"
}

module "s3_bucket" {
    source = "./s3"
}

resource "local_file" "ip_address" {
    content  = module.ec2_instance.instance_ip
    filename = "${path.module}/ip_address.txt"  
}

resource "aws_s3_object" "ip_address_file" {  
    bucket = module.s3_bucket.bucket_name 
    key    = "ip_address.txt"
    source = local_file.ip_address.filename
}
