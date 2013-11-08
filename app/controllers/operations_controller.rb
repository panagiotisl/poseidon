class OperationsController < ApplicationController

  def create
    @port = Port.find(params[:operation][:port_id])
    @agent = Agent.find(params[:operation][:agent_id])
    @agent.register!(@port)
    respond_to do |format|
      format.html { redirect_to controller:'agents', action: 'manage_ports', id: @agent.id }
      format.js
    end
  end

  def destroy
    @operation = Operation.find(params[:id])
    @port = @operation.port
    @agent = @operation.agent
    @agent.unregister!(@port)
    respond_to do |format|
      format.html { redirect_to controller:'agents', action: 'manage_ports', id: @agent.id }
      format.js
    end
  end
end
