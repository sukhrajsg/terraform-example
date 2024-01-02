// EC2
# EC2 that runs a script that will perform the diff checking operation
# This has been mainly imported from existing architecture (hence the slightly odd formatting)

resource "aws_instance" "mirror_ec2" {
  ami                         = "EXAMPLE"
  associate_public_ip_address = false
  availability_zone           = "eu-west-2a"
  disable_api_stop            = false
  disable_api_termination     = false
  ebs_optimized               = false
  get_password_data           = false
  hibernation                 = false
  iam_instance_profile        = aws_iam_role.ssm_role.id

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.medium"
  key_name                             = "EXAMPLE"
  monitoring                           = false
  placement_partition_number           = 0
  private_ip                           = "EXAMPLE"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "EXAMPLE"
  tags                                 = merge(var.tags, { Name = "SAI-DIP-REP-MIRROR" })
  tenancy                              = "default"
  vpc_security_group_ids = [
    "EXAMPLE",
  ]

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 2
    threads_per_core = 1
  }

  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 100
    tags                  = {}
    throughput            = 0
    volume_size           = 16
    volume_type           = "gp2"
  }
  lifecycle {
    prevent_destroy = true
  }
}