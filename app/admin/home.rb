ActiveAdmin.register_page "Home" do
  menu label: "Home", priority: 2

  content title: proc{ I18n.t("active_admin.dashboard") } do
    render partial: "featured"
    render partial: "must_watch"
  end 
end
