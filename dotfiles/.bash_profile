#
# ~/.bash_profile
#

# DON'T CHANGE THIS FILE
# You can define your custom configuration by adding/editing files in ~/.config/bashprofile.d

for file in "$HOME"/.config/bashprofile.d/*; do
    [ -f "$file" ] && [ -r "$file" ] && [ -s "$file" ] || continue

    if ! . "$file"; then
        printf 'Failed to load: %s\n' "$file" >&2
    fi
done

####################################################################

[ -f "$HOME"/.bashrc ] && [ -r "$HOME"/.bashrc ] && [ -s "$HOME"/.bashrc ] && . "$HOME"/.bashrc

# -f checks if $file exists and it's a regular file;
# -r checks if $file is readable;
# -s checks if $file isn't empty;
