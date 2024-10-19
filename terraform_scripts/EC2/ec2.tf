resource "aws_instance" "dhruvinst" {
    ami           = "ami-04dd23e62ed049936"
    instance_type = "t2.micro"
    tags = {
        Name = "Hello_Dhruv"
    }
}

output "instance_ip" {
    value = aws_instance.dhruvinst.public_ip  # Expose the public IP of the EC2 instance
}
