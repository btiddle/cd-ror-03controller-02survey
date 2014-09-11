class SurveysController < ApplicationController
  def index
  end

  def new
  end

  def create

    session[:user] = params

    flash[:name] = params[:name]
    flash[:loc] = params[:loc]
    flash[:lang] = params[:lang]
    flash[:comm] = params[:comm]

    if session[:count]
      session[:count] += 1
    else
      session[:count] = 1
  end

    flash[:count] = session[:count]

    redirect_to('/result')
  end

  def result
    @user = session[:user]
  end

end
