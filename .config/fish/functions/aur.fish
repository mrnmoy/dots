function aur
    switch $argv
        case init
            aur_init
        case up
            aur_up
    end
end

function aur_init 
    set pkgname $(gum input --placeholder "Package name")
    mkdir $pkgname &&
    cd $pkgname &&
    git init && 
    git remote add aur ssh://aur@aur.archlinux.org/$pkgname.git
    cp /usr/share/pacman/PKGBUILD.proto PKGBUILD
end

function aur_up 
    set summary $(gum input --placeholder "Summary of this change")
    set desc $(gum write --placeholder "Details of this change")

    makepkg --printsrcinfo > .SRCINFO

    gum confirm "Commit changes?" && git add .SRCINFO PKGBUILD && git commit -m $summary -m $desc && git push --set-upstream aur master 
end
