require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe Admin::Atreides::PagesController do

  before(:each) do
    @site_www = Atreides::Site.default
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in Factory.create(:user_admin)
  end

  describe "GET index" do
    before do
      @pages = []
      @pages << Factory.create(:drafted_page, :created_at => 1.month.ago, :site => @site_www)
      @pages << Factory.create(:drafted_page, :site => @site_www)
      @pages << Factory.create(:published_page, :site => @site_www)
      @pages << Factory.create(:published_page, :site => @site_www)
    end

    it "assigns all published pages as @pages" do
      get :index
      assigns(:pages).all? { |page| page.published?.should be true }
    end

    describe "drafted pages" do
      before do
        get :index, :state => "drafted", :month => Date.today.month, :year => Date.today.year
      end

      it "should assigns only drafted pages as @pages" do
        assigns(:pages).empty?.should_not be true
        assigns(:pages).all? { |page| page.drafted?.should be true }
      end
    end
  end

  describe "GET new" do
    it "assigns a new page as @page" do
      get :new
      response.should be_success
      assigns(:page).class.should be Atreides::Page
    end
  end

  describe "GET edit" do
    it "assigns the requested page as @page" do
      page = Factory.create(:published_page, :site => @site_www)
      get :edit, :id => page.id
      response.should be_success
      assigns(:page).should eql page
    end
  end


end
