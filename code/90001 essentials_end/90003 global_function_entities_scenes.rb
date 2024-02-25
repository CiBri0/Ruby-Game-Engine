#Entities & srcenes

def entities_show()
    scene.e_show().each do |entity|
        log(entity)
    end
end

def entity_dependencies(src, deps)
    dependencies(src, deps, "entity")
end

def srcene_dependencies(src, deps)
    dependencies(src, deps, "srcene")
end

def dependencies(src, deps, text)
    deps.each do |dep|
        error("You was not included #{dep} in #{text} #{src.to_s}") if !src.components.include?(dep)
    end
end
