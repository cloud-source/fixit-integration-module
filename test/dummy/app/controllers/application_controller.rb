class ApplicationController < ActionController::API
  def dump
    render json: {
      channels: Integrations.instance_eval { @channels || [] }.map(&:to_h),
      users: Integrations.instance_eval { @users || [] }.map(&:to_h),
      roles: Integrations.instance_eval { @roles || [] }.map(&:to_h),
      subscriptions: Integrations.subscriptions.reduce({}){|o, (k, v)| o.merge k => v.map{|b| "{|#{b.parameters.map{|p| p[1] }.join(", ")}| <code> }"  } },
      repositories: Integrations.repositories.reduce({}){|o, (k, v)| o.merge k => v.reduce({}){|q, (l, x)| q.merge l => "{|#{x.parameters.map{|p| p[1]}.join(", ")}| <code> }" } },
    }
  end
end
