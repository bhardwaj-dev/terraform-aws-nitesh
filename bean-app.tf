resource "aws_elastic_beanstalk_application" "nitesh-prod" {
  name = "nitesh-prod"
}

#resource "aws_iam_instance_profile" "bean-instance-profile" {
#  name = "bean-instance-profile"
#  role = "aws-elasticbeanstalk-ec2-role"
#}