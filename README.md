# terraform-module-asg

An opinionated Terraform Module for creating ECS AutoScaling Groups

## Features

- Scheduled up size up and down of the cluster between work hours (6am and 8pm)
- Amazonlinux-2 AMI

## Inputs

| Name                         | Description                                                                                 |  Type  |     Default      | Required |
| ---------------------------- | ------------------------------------------------------------------------------------------- | :----: | :--------------: | :------: |
| name                         |                                                                                             | string |       n/a        |   yes    |
| subnets                      |                                                                                             |  list  |       n/a        |   yes    |
| user\_data\_script           | ASG                                                                                         | string |       n/a        |   yes    |
| vpc\_id                      |                                                                                             | string |       n/a        |   yes    |
| asg\_desired\_capacity       |                                                                                             | string |       n/a        |   yes    |
| asg\_desired\_capacity\_down |                                                                                             | string |       n/a        |   yes    |
| asg\_desired\_capacity\_up   |                                                                                             | string |       n/a        |   yes    |
| asg\_max\_size               |                                                                                             | string |       n/a        |   yes    |
| asg\_max\_size\_down         |                                                                                             | string |       n/a        |   yes    |
| asg\_max\_size\_up           |                                                                                             | string |       n/a        |   yes    |
| asg\_min\_size               | # AutoScalling                                                                              | string |       n/a        |   yes    |
| asg\_min\_size\_down         |                                                                                             | string |       n/a        |   yes    |
| asg\_min\_size\_up           |                                                                                             | string |       n/a        |   yes    |
| load\_balancers              |                                                                                             | string |       n/a        |    no    |
| enabled\_metrics             |                                                                                             |  list  |     `<list>`     |    no    |
| health\_check\_grace\_period |                                                                                             | string |     `"300"`      |    no    |
| health\_check\_type          |                                                                                             | string |     `"EC2"`      |    no    |
| instance\_profile            |                                                                                             | string |       `""`       |    no    |
| instance\_type               |                                                                                             | string |   `"t2.large"`   |    no    |
| key\_name                    |                                                                                             | string |       `""`       |    no    |
| map\_public\_ip              |                                                                                             | string |    `"false"`     |    no    |
| schedule\_recurrence\_down   |                                                                                             | string | `"* 20 * * 1-5"` |    no    |
| schedule\_recurrence\_up     |                                                                                             | string | `"* 6 * * 1-5"`  |    no    |
| security\_groups             |                                                                                             |  list  |     `<list>`     |    no    |
| tags                         |                                                                                             |  map   |     `<map>`      |    no    |
| termination\_policies        | A list of policies to decide how the instances in the auto scale group should be terminated |  list  |     `<list>`     |    no    |
