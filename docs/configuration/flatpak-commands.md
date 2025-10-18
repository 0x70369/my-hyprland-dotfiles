# Flatpak Launch Commands for Various Programs
## Browsers
I - Ungoogled Chromium ---> flatpak run --branch=stable --arch=x86_64 --command=/app/bin/chromium --file-forwarding io.github.ungoogled_software.ungoogled_chromium @@u %U @@

II - LibreWolf ---> flatpak run --branch=stable --arch=x86_64 --command=librewolf --file-forwarding io.gitlab.librewolf-community @@u %u @@

## Communication Apps
I - ZapZap ---> flatpak run --branch=stable --arch=x86_64 --command=zapzap --file-forwarding com.rtosta.zapzap @@u %u @@

II - Vesktop ---> flatpak run --branch=stable --arch=x86_64 --command=startvesktop --file-forwarding dev.vencord.Vesktop @@u %U @@

## Office Suite
I - OnlyOffice ---> flatpak run --branch=stable --arch=x86_64 --command=desktopeditors --file-forwarding org.onlyoffice.desktopeditors @@u %U @@
