resource "aws_iam_role" "besfort_backup_role" {
  name = "besfort_backup_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "backup.amazonaws.com"
      }
    }]
  })
}
resource "aws_iam_role_policy_attachment" "besfort_backup_role_attachment" {
  role       = aws_iam_role.besfort_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}
