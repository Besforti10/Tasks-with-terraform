resource "aws_db_instance" "rds-db" {
  identifier           = "rds-db"
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "adminbesfort"
  password             = "password"
  backup_retention_period = 2
  backup_window        = "03:00-06:00"
  skip_final_snapshot  = true
  tags = {
    Name = "rds-instance"
  }
}