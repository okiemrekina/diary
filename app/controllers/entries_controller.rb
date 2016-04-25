class EntriesController < ApplicationController
	 before_action :authenticate_user!, except: [:index, :show]

	def index
		@entries = Entry.order(title: :desc)
	end
	def show
		@entry = Entry.find_by(id: params[:id])
		@comment = Comment.new(entry: @entry)
		if @entry.nil?
			@entries = Entry.all
			render '404' #show text on the web
		end
	end
		#@entry = Entry.find(params[:id]) #to samo co: Entry.find(params["id"])
	
	def create
		#render(text: params.inspect) #render(:text => params.inspect)
		params.permit!
		entry_params = params["entry"] #new variable is hash with its keys and values
		entry = Entry.create(entry_params)
		redirect_to(entry_path(entry))
	end
	
	def edit
		@entry = Entry.find(params[:id])
	end

	def update
		entry_params = params["entry"].permit("title", "contents")
		entry = Entry.find(params["id"])
		entry.update(entry_params)
		redirect_to(entry_path(entry))
	end
	
	def destroy
		@entry = Entry.find_by(id: params[:id])
		if @entry.nil?
			@entries = Entry.all
			render '404' #show text on the web
		else
			@entry.destroy
		end
	end

end