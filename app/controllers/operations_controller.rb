require 'common_stuff'
class OperationsController < ApplicationController
  include CommonStuff
  
  before_action :authorized_ase,     only: [:create, :destroy]
  
  def create
#    @port = Port.find(params[:operation][:port_id])
    @port_id = params[:operation][:port_id]
    @agent = Agent.find(params[:operation][:agent_id])
    @agent.register!(@port_id)
    respond_to do |format|
      format.html { redirect_to controller:'agents', action: 'manage_ports', id: @agent.id }
      format.js
    end
  end

  def destroy
    @operation = Operation.find(params[:id])
    @port_id = @operation.port_id
    @agent = @operation.agent
    @operation.unregister!
    respond_to do |format|
      format.html { redirect_to controller:'agents', action: 'manage_ports', id: @operation.agent_id }
      format.js
    end
  end
end
