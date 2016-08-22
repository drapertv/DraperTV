class AddMarketingSlug < ActiveRecord::Migration
  def change
  	add_column :series, :marketing_slug, :string
  	add_column :livestreams, :marketing_slug, :string
  	add_column :videos, :marketing_slug, :string
  end
end
