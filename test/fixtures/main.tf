locals {
  tags {
    cost_cost = "1234"
  }

  user_data_script = <<EOF
Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0

--==BOUNDARY==
Content-Type: text/cloud-boothook; charset="us-ascii"

# Install nfs-utils
cloud-init-per once yum_update yum update -y
cloud-init-per once install_nfs_utils yum install -y nfs-utils

# Create /efs folder
cloud-init-per once mkdir_efs mkdir /efs

# Mount /efs
cloud-init-per once mount_efs echo -e 'availability-zone.file-system-id.efs.aws-region.amazonaws.com:/ /efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0' >> /etc/fstab
mount -a

--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
# Set any ECS agent configuration options
echo "ECS_CLUSTER=default" >> /etc/ecs/ecs.config

--==BOUNDARY==--
EOF
}

module "ecs" {
  source = "../../"
  name   = "asg-test"

  load_balancers   = ""
  user_data_script = "#!/bin/bash\necho ECS_CLUSTER=default >> /etc/ecs/ecs.config"

  subnets = "${module.vpc.private_subnets}"
  vpc_id  = "${module.vpc.vpc_id}"

  # security_groups = ["${aws_security_group.ecs_cluster.id}"]

  key_name = ""
  # instance_profile = "${aws_iam_instance_profile.ecs.id}"
  map_public_ip = false
  # Starting capacity
  asg_desired_capacity = 1
  asg_max_size         = 1
  asg_min_size         = 1
  # Day schedule
  asg_desired_capacity_up = 1
  asg_min_size_up         = 1
  asg_max_size_up         = 1
  # Night Schedule
  asg_min_size_down         = 1
  asg_max_size_down         = 1
  asg_desired_capacity_down = 1

  # schedule_recurrence_up   = "${var.schedule_recurrence_up}"
  # schedule_recurrence_down = "${var.schedule_recurrence_down}"

  tags = "${local.tags}"
}

provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source  = "damacus/vpc/module"
  version = "2.0.0"
  tags    = "${local.tags}"
}
