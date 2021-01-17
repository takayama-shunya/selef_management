class IntegerRecordsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_record, only: %i[ show edit destroy update ]


  def new
    @record = IntegerRecord.new
  end

  def create
    @record = current_user.integer_records.build(integer_record_params)
      if @record.save
        redirect_to top_index_path, notice: "created condition"
      else
        render :new
      end
  end

  def show
    @commented = @record.comment
    @comment = Comment.new
  end

  def edit
    respond_to do |format|
      format.js { render :edit }
      format.html { render :edit }
    end
  end

  def update
    respond_to do |format|
      if @record.update(integer_record_params)
        format.js { flash.now[:success] = "updated" }
        format.html { redirect_to top_index_path, notice: "updated condition" }
      else
        format.js
        format.html { render :edit }
      end
    end
  end

  def destroy
    @record.destroy
    @msg = "delete"
  end


  private

  def set_record
    @record = IntegerRecord.find(params[:id])
    redirect_to top_index_path, alert: "not user" if current_user.id == @record.user_id
  end

  def integer_record_params
    params.require(:integer_record).permit(
      :type, :title, :unit, :content, week_ids: [])
  end

end
