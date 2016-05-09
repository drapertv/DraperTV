class AddShowOnFrontPageToLivestreams < ActiveRecord::Migration
  def change
    add_column :livestreams, :show_on_front_page, :boolean
  end
end
