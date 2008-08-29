require 'ruby-debug'
 
class PointsController < ApplicationController
#  include MainHelper
 
  layout 'standard'
 
  def initialize
  end
  
  def search 
    @minititle = "Points matching '#{params[:query]}'";
    @points = Point.find :all, :conditions => "MATCH (txt) AGAINST ('#{params[:query]}' IN BOOLEAN MODE)"
    render :partial => "points", :object => @points  
  end
  def searchajax
    @topics = Topic.find :all, :conditions => "MATCH (txt) AGAINST ('#{params[:query]}' IN BOOLEAN MODE)"
    @points = Point.find :all, :conditions => "MATCH (txt) AGAINST ('#{params[:query]}' IN BOOLEAN MODE)"
    if params[:savemode]
      options = {:pointfolders => true, :notop => true}
    else
      options = {:notop => true}
    end
    render :partial => "topicsandpoints", :object => {:points => @points, :topics => @topics}, :locals => {:options => options}
  end
 
  def index
    @title = "Points"
    @points = Point.find(:all)
    @options = {}
    emit(@points)
  end
  def mine
    @minititle = "My Points"
    @points = @user.points
    render :action => :index
  end
  def notmine
    @minititle = "Others' Points"
    @points = @user.notmypoints
    render :action => :index
  end
  def scratch
    @points = Point.find_by_sql("
      SELECT * FROM points WHERE
      id IN (SELECT point_id FROM snippets WHERE user_id = #{@user.id})
      AND id NOT IN (SELECT point_a_id FROM point_links)
      AND id NOT IN (SELECT point_id FROM point_topics)
    ");
    render :partial => 'points/points', :object => @points, :locals => {:options => {}}
  end
  
  def show
    @point = Point.find(params[:id])
    @title = "Point: "+@point.txt
    if @point.ismine(@user)
      @editlink = true
    end
 
    emit(@point,{:only => [:txt], :include => :snippets, :methods => :avgrating})
  end
  
  def expand
    @point = Point.find(params[:id])
    render :partial => "point", :locals => {:noholder => true, :expandPoints => {@point.id => true}}, :object => @point
  end
  
  def expandfolder
    @point = Point.find(params[:id])
    render :partial => "point", :locals => {:noholder => true, :expandPoints => {@point.id => true}, :options => {:pointfolders => true}}, :object => @point
  end
  
  
  def showmini
    @point = Point.find(params[:id])
    render :layout => 'mini', :action => 'show'
  end
  def showmini_old
  
    @point = Point.find(params[:id])
    if !params[:snippet].nil?
      @currentSnip = Snippet.find(params[:snippet])
    end
    render :layout => 'mini'    
  end
  def snippets_old
    @point = Point.find(params[:id])
    @snippets = @point.snippets    
    emit(@snippets,{:methods => :avgrating})
  end
  
  def snippets
    @point = Point.find(params[:id])
    render :partial => "snippets/snippets", :object => @point.snippets, :locals => {:options => {:nopoint => true}}
  end
  
  def topics 
    @point = Point.find(params[:id])
    render :partial => "topic/topics", :object => @point.topics
  end
  
  
  def new
    @point = Point.new
  end
  def create
    @point = Point.new(params[:point])
    @point.user_id = @user.id
    respond_to do |format|
      if @point.save
        flash[:notice] = 'Source was successfully created.'
        format.html { redirect_to(@point) }
        format.xml  { render :xml => @point, :status => :created, :location => @point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @point.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @point = Point.find(params[:id])  
  end
  
  def update
    p = Point.find(params[:point][:id])
    p.txt = params[:point][:txt]
    if p.save
      redirect_to(p)
    else
      format.xml  { render :xml => p.errors, :status => :unprocessable_entity }
    end
  end
  def delete
  end
end