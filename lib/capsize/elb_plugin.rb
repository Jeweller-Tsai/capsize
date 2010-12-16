module Capsize
  module CapsizeELB    
    include Capsize
    
    def connect()

      # Optimized so we don't read the config files six times just to connect.
      # Read once, set it, and re-use what we get back...
      set :aws_access_key_id, get(:aws_access_key_id)
      set :aws_secret_access_key, get(:aws_secret_access_key)

      raise Exception, "You must have an :aws_access_key_id defined in your config." if fetch(:aws_access_key_id).nil? || fetch(:aws_access_key_id).empty?
      raise Exception, "You must have an :aws_secret_access_key defined in your config." if fetch(:aws_secret_access_key).nil? || fetch(:aws_secret_access_key).empty?

      begin
        return amazon_elb = AWS::ELB::Base.new(:access_key_id => get(:aws_access_key_id), :secret_access_key => get(:aws_secret_access_key), :server => get(:elb_url))
      rescue Exception => e
        puts "Your EC2::Base authentication setup failed with the following message : " + e
        raise e
      end
    end
    
    def register_instances_with_load_balancer(params)
       begin
          amazon = connect()
          result = amazon.register_instances_with_load_balancer(params)
        rescue Exception => e
          puts "The attempt to register your instances to the load balancer failed with error : " + e
          raise e
        end
    end
    
    
    def deregister_instances_from_load_balancer(params)
       begin
          amazon = connect()
          result = amazon.deregister_instances_from_load_balancer(params)
        rescue Exception => e
          puts "The attempt to deregister your instances to the load balancer failed with error : " + e
          raise e
        end
    end
    
  end
end
Capistrano.plugin :capsize_elb, Capsize::CapsizeELB

