class RenameMiscInfoInLivestream < ActiveRecord::Migration
  def change
  	rename_column :livestreams, :misc_info, :src_url
  end
end
