class TheController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  set :root, File.join(File.dirname(__FILE__), '..')

  set :Views, Proc.new { File.join(root, "Views") }

  $blogs = [
    {
      :id => 1,
      :title => "Page 1",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    },
    {
      :id => 2,
      :title => "Page 1",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    },
    {
      :id => 3,
      :title => "Page 1",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    }
  ]

  #Index
  get '/' do
    @title = "Index Page"
    @pages = $blogs
    erb :"posts/index"
  end
  #New
  get '/new' do
    @title = "New Page"
    @pages = {
      :id => "",
      :title => "",
      :body => ""
    }
    @pages = $blogs
    erb :"posts/new"
    redirect "/"
  end
  #Show
  get '/:id' do
    id = params[:id].to_i
    @title = "Show Page"
    @pages = $blogs[id]
    erb :"posts/show"
  end
  #Create
  post '/' do
    id = $blogs.last[:id] + 1

    new_page = {
      :id => id,
      :title => params[:title],
      :body => params[:body]
    }
    $blogs.push new_page

  end
  #Edit
  get '/:id/edit' do
    id = params[:id].to_i
    @pages = $blogs[id]
    @title = @pages[:title]
    erb :"posts/edit"

  end
  #Update
  put '/:id' do
    id = params[:id].to_i
    page = $blogs[id]
    page[:title] = params[:title]
    page[:body] = params[:body]
    $blogs[id] = page
    redirect "/"
  end
  #Destroy
  delete '/:id' do
    id = params[:id].to_i
    $blogs.delete_at id

    redirect "/"
  end

end
