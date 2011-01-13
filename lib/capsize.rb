# Require all necessary libraries
%w[
  ostruct
  yaml
  fileutils
  builder
  capistrano
  AWS
  sqs
  capsize/version
  capsize/capsize
  capsize/meta_tasks
  capsize/ec2
  capsize/ec2_plugin
  capsize/elb
  capsize/elb_plugin
  capsize/sqs
  capsize/sqs_plugin
  capsize/configuration
].each { |lib|
    require lib
}

include AWS
