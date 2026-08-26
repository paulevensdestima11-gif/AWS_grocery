resource "aws_sns_topic" "user_registration" {
  name = "${var.project_name}-user-registration"
}

resource "aws_sns_topic_subscription" "user_registration_email" {
  topic_arn = aws_sns_topic.user_registration.arn
  protocol  = "email"
  endpoint  = var.sns_notification_email
}

