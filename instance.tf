resource "aws_key_pair" "name" {
key_name = "testkey"
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdMgU/JE6BFRNHbYvGD9L2RHR08LvGL6Msd0QJx9A0Qu2lzizV9R44CE5aeRml+Aux2tanaGMFurofgXk6QTT7ZcJt6XwWcpXzdgCqJnQXjdxKaKguM/H6bTzDB4euFqHTDBsEX0yKe2RsTXsl6+G5VS7iGTvPYGyH56xz5WjgzEk6/0CX4aX0AY9iqLcvqdtAeHPKcblby1STOv/vgHFTWqjCOKCbnYaAodVS8k9RoiULDUDH0mpyqqQWXrlz/LDlbsWqLyh2YhnUFgY7bPZ8ebyZVDgZsuj+10uNN6fbcauxQvFJ+UXfCqUxjjBPFVr6Y0jXX0AoiejSj9Pn53mXEDMIz+4UGQ5hj67EmVULy8Hly73SxZYUrQbzV7VfNnkIKvAx/MSVGHAtQKoXgAsmzBlIdN5xomYRHzXZJwpjrE9uWa72byQo21lAsxYC5G4c3STm+ZOvlDX39A7EgYL63Br9bDrcOYd+f74p80m/MpqQ7lM6B3X0cRElinUSDh8= kottapallysaiteja@kottapallysaitejas-MacBook-Air.local"  
}

resource "aws_instance" "this" {
  ami                       = "ami-017c001a88dd93847"
  instance_type             = "t2.micro"
  subnet_id =  "subnet-08b9bcf806e1de691"
  security_groups = ["sg-095067e2061bba82f"]
  key_name = aws_key_pair.name.id
    tags = {
    Name = "value"
  }
}

