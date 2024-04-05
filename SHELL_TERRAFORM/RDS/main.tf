resource "aws_db_instance" "test" {
  allocated_storage   = var.storage
  identifier          = var.dbname
  db_name             = "greenbox"
  engine              = var.dbtype
  engine_version      = var.dbversion
  instance_class      = var.instance_type
  password            = var.password
  username            = var.username
  skip_final_snapshot = true
  multi_az            = false
  storage_type        = "gp3"
  storage_encrypted   = true
  db_subnet_group_name = aws_db_subnet_group.example_db_subnet_group.name
}

resource "aws_db_subnet_group" "example_db_subnet_group" {
  name       = "example-db-subnet-group"
  subnet_ids = [data.aws_subnet.public_subnet.id,  data.aws_subnet.public_subnet_2.id]

  tags = {
    Name = "Example DB Subnet Group"
  }
}
