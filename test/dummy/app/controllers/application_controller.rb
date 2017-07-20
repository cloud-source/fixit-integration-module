class ApplicationController < ActionController::API
  def dump
    render json: {
      channels: Integrations.instance_eval { @channels || [] }.map(&:to_h),
      users: Integrations.instance_eval { @users || [] }.map(&:to_h),
      roles: Integrations.instance_eval { @roles || [] }.map(&:to_h),
    }
  end
end
