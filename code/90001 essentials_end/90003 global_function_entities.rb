#Entities

def entities_show()
    $gb_var[:current_scene].e_show().each do |t|
        log(t)
    end
end
