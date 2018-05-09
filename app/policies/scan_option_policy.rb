class ScanOptionPolicy < ApplicationPolicy
  include RecordPolicy

  def permitted_attributes
    %i[name
       description
       options,
       syn_scan,
       skip_discovery,
       udp_scan,
       service_scan,
       os_fingerprint,
       top_ports,
       aggressive_timing,
       insane_timing,
       disable_dns]

  end

  class Scope < Scope
    def resolve
        scope.all
    end
  end
end
