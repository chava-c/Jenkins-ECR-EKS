resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Owner = "Scardenas"
    Project = "DevOps Internship"
    Name = "tf_cluster"
  }
}