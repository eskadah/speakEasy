module UsersHelper
  def communication_preferences_text(coll)
    coll = coll.to_ary
    { "email" => "Email", "phone" => "Phone", "all_comms" => "All" }[coll.first] 
  end
end
