resource "aws_backup_vault" "default" {
  name = "default"
}
resource "aws_backup_plan" "rds_backup" {
  name = "rds-backup-plan"
  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.default.name
    schedule          = "cron(0 5 * * ? *)"  # Daily at 5AM
    lifecycle {
      delete_after = 30
    }
  }
}
resource "aws_backup_selection" "rds_backup_selection" {
  iam_role_arn = aws_iam_role.besfort_backup_role.arn
  name         = "rds-backup-selection"
  plan_id      = aws_backup_plan.rds_backup.id

  resources = [
    "arn:aws:rds:eu-west-3:620453548539:db:rds-db"
  ]
}
