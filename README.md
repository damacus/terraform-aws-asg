# terraform-module-asg

An opinionated Terraform Module for creating ECS AutoScaling Groups

## Features

- Scheduled up size up and down of the cluster between work hours (6am and 8pm)
- Amazonlinux-2 AMI

## Inputs

| Name                           | Description                                                                                              |  Type  |     Default      | Required |
| ------------------------------ | -------------------------------------------------------------------------------------------------------- | :----: | :--------------: | :------: |
| asg\_desired\_capacity         | Desired number of instances during standard operation                                                    | string |       n/a        |   yes    |
| asg\_desired\_capacity\_down   | Desired number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)          | string |       n/a        |   yes    |
| asg\_desired\_capacity\_up     | Desired number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)              | string |       n/a        |   yes    |
| asg\_max\_size                 | Maximum number of instances during standard operation                                                    | string |       n/a        |   yes    |
| asg\_max\_size\_down           | Maximum number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)          | string |       n/a        |   yes    |
| asg\_max\_size\_up             | Maximum number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)              | string |       n/a        |   yes    |
| asg\_min\_size                 | Minimum number of instances during standard operation                                                    | string |       n/a        |   yes    |
| asg\_min\_size\_down           | Minimum number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)          | string |       n/a        |   yes    |
| asg\_min\_size\_up             | Minimum number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)              | string |       n/a        |   yes    |
| associate\_public\_ip\_address | Associate a public ip address with an instance in a VPC                                                  | string |    `"false"`     |    no    |
| enabled\_metrics               | A list of metrics to collect. By default all are collected                                               |  list  |     `<list>`     |    no    |
| health\_check\_grace\_period   | Time (in seconds) after instance comes into service before checking health                               | string |     `"300"`      |    no    |
| health\_check\_type            | EC2 or ELB. Controls how health checking is done                                                         | string |     `"EC2"`      |    no    |
| instance\_profile              | IAM instance profile to attach to the ASG                                                                | string |       `""`       |    no    |
| instance\_type                 | A EC2 instance type for the ASG                                                                          | string |   `"t2.large"`   |    no    |
| key\_name                      | The key name that should be used for the instance                                                        | string |       `""`       |    no    |
| name                           | Name for the ASG                                                                                         | string |       n/a        |   yes    |
| schedule\_recurrence\_down     | Schedule time in Unix cron syntax format for the DOWN action                                             | string | `"* 20 * * 1-5"` |    no    |
| schedule\_recurrence\_up       | Schedule time in Unix cron syntax format for the UP action                                               | string | `"* 6 * * 1-5"`  |    no    |
| security\_groups               | A list of additional securiyy groups to attach to the ASG                                                |  list  |     `<list>`     |    no    |
| subnets                        | A list of subnets for the autoscaling_group vpc_zone_identifier                                          |  list  |       n/a        |   yes    |
| tags                           |                                                                                                          |  map   |     `<map>`      |    no    |
| termination\_policies          | A list of policies to decide how the instances in the auto scale group should be terminated              |  list  |     `<list>`     |    no    |
| user\_data\_script             | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument | string |       n/a        |   yes    |
