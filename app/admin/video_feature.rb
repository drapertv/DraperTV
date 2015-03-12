ActiveAdmin.register VideoFeature do

  permit_params :video_id, :type_qwatch, :type_series

  index do
    column :id
    column :video_id
    column :type_qwatch
    column :type_series
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Featured Video Details" do
     f.inputs :video_id
     f.inputs :type_qwatch
     f.inputs :type_series
   end
  f.actions
 end

end
