Capistrano::Configuration.instance.load do
  
  namespace :elb do
    task :register_instances do
      elb_params = {
        :load_balancer_name => capsize.get(:load_balancer_name),
        :instances => capsize.get(:instance_ids).split(",")
      }
      capsize_elb.register_instances_with_load_balancer(elb_params)
    end
    
    task :deregister_instances do
      elb_params = {
        :load_balancer_name => capsize.get(:load_balancer_name),
        :instances => capsize.get(:instance_ids).split(",")
      }
      capsize_elb.deregister_instances_from_load_balancer(elb_params)
    end
    
  end
  
end