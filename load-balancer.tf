
#creating application load balancer
resource "aws_lb" "test-lb" {
    load_balancer_type = "application"
    internal = false
    enable_deletion_protection = true
    subnet_mapping {
      subnet_id = aws_subnet.testsubnet-1.id
    }

    subnet_mapping {
      subnet_id = aws_subnet.testsubnet-2.id
    }

    security_groups = [aws_security_group.test-sg.id]

    tags = {
      "Name" = "test-lb"
    }
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
resource "aws_lb_target_group_attachment" "test" {
    target_group_arn = aws_lb_target_group.test-tg.arn
    target_id = aws_lb_target_group.test-tg.id
    port = 80

}

