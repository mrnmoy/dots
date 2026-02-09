function cbuild
    cmake -S . -B build && cmake --build build --target (basename (pwd)) 
end
