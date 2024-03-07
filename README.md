```bash
git clone --recursive https://github.com/HashemRadaideh/dotfiles
```

add the following to your /etc/sudoers using visudo
> tip you can use any other editor other than vi with this command
> sudo EDITOR=nvim visudo /etc/sudoers
```bash
Defaults insults

your-username ALL= NOPASSWD: /usr/bin/systemctl hibernate
your-username ALL= NOPASSWD: /usr/bin/systemctl suspend 
```
