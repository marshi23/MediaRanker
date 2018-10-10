class WorksController < ApplicationController
  def index
    @works = Work.all # .order(:name)
  end

  def show
    @work = Work.find(params[:id].to_i)
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      # redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find(params[:id].to_i)
  end

  def update
    @work = Work.find_by(id: params[:id].to_i)

    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    @deleted_work = work.destroy

    if @deleted_work
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
