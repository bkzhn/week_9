require 'spec_helper'

describe BooksController do
  it "should be an ApplicationController child" do
    expect(BooksController.superclass).to eq(ApplicationController)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @book = Book.new(FactoryGirl.attributes_for(:book))
      @book.save

      visit book_path(id: @book.id)
    end

    it "returns http success" do
      response.should be_success
    end
  end

  describe "GET 'new'" do
    before { visit new_book_path }

    it "returns http success" do
      response.should be_success
    end

    it "assigns @book variable to the new.hml.erb view" do
      get 'new'
      expect(assigns[:book]).to be_a_new(Book)
    end

    it "renders new.html.erb" do
      expect(response).to render_template(:new)
    end
  end

  describe "GET 'create'" do
    it "should not return http success" do
      get 'create'
      response.should_not be_success
    end

    it "assigns a newly created book as @book" do
      post :create, {:book => FactoryGirl.attributes_for(:book)}
      assigns(:book).should be_a(Book)
      assigns(:book).should be_persisted
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @book = Book.new(FactoryGirl.attributes_for(:book))
      @book.save

      visit edit_book_path(id: @book.id)
    end

    it "returns http success" do
      response.should be_success
    end

    it "renders edit.html.erb" do
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @book = Book.new(FactoryGirl.attributes_for(:book))
      @book.save
      @attr = {
          :title => "New Title", :year => 2015,
          :description => "New desctiption",
          :isbn => "978-2-16-148410-0"
      }
      put :update, :id => @book.id, :book => @attr
      @book.reload
    end

    it { @book.title.should eql @attr[:title] }
    it { @book.year.should eql @attr[:year] }
    it { @book.description.should eql @attr[:description] }
    it { @book.isbn.should eql @attr[:isbn] }
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @book = Book.new(FactoryGirl.attributes_for(:book))
      @book.save
    end

    it "should delete a book" do
      expect { delete :destroy, :id => @book.id }.to change(Book, :count)
    end
  end
end