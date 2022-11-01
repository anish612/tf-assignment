
#creating application load balancer
resource "aws_lb" "test-lb" {
    name = "test-lb"
    load_balancer_type = "application"
    internal = false
    security_groups = [aws_security_group.test-sg.id]
    subnets = [aws_subnet.testsubnet-1.id,aws_subnet.testsubnet-2.id]
}



#creating target group
resource "aws_lb_target_group" "test-tg" {
    name = "test-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.testvpc.id
}


#creating listener group

resource "aws_lb_listener" "test-listener" {
    load_balancer_arn = aws_lb.test-lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.test-tg.arn
    }

}


#target group attachment with ec2 instances
resource "aws_lb_target_group_attachment" "tg-1" {
    target_group_arn = aws_lb_target_group.test-tg.arn
    target_id = aws_instance.test-instance1.id
    port = 80

}

resource "aws_lb_target_group_attachment" "tg-2" {
    target_group_arn = aws_lb_target_group.test-tg.arn
    target_id = aws_instance.test-instance2.id
    port = 80

}

