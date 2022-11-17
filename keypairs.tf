resource "aws_key_pair" "nitesh-key" {
  public_key = file("nitesh-key.pub")
  key_name   = "nitesh-key"
}