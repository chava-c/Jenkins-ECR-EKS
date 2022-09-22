resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Owner = "Scardenas"
    Project = "DevOps Internship"
    Name = "tf_cluster"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Owner = "Scardenas"
    Project = "DevOps Internship"
    Name = "tf_cluster"
  }

  depends_on = [aws_internet_gateway.igw]
}