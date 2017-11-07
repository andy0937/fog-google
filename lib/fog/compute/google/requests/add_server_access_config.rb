module Fog
  module Compute
    class Google
      class Mock
        def add_server_access_config(_identity, _zone, _nic, _options = {})
          Fog::Mock.not_implemented
        end
      end

      class Real
        def add_server_access_config(identity, zone, nic, options = {})
          api_method = @compute.instances.add_access_config
          parameters = {
            "project"  => @project,
            "instance" => identity,
            "zone"     => zone.split("/")[-1],
            "networkInterface" => nic
          }

          body_object = {
            "type" => "ONE_TO_ONE_NAT"
          }

          options[:name] ? body_object["name"] = options[:name] : body_object["name"] = "External NAT"
          body_object["natIP"] = options[:address] if options[:address]

          request(api_method, parameters, body_object)
        end
      end
    end
  end
end
