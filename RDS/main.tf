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
  backup_retention_period = 7
}
