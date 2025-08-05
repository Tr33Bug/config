# config
My config files for my macos based system. 


## Installation
1. Install the packages 

```bash
# 1. Update Homebrew to get the latest packages
brew update

# 2. Install the main tools your .zshrc depends on
brew install zsh git fzf starship coreutils

# 3. Install Miniconda (used for lazy conda in your .zshrc)
brew install --cask miniconda

# 4. Setup fzf key bindings and completion
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# 5. Install Zinit (Zsh plugin manager)
mkdir -p ~/.local/share/zinit
git clone https://github.com/zdharma-continuum/zinit ~/.local/share/zinit/zinit.git

# 7. (Optional) Change the default shell to Zsh
chsh -s $(which zsh)

# 8. Restart terminal or run
exec zsh
```
2. copy and past the config files
```bash
# config/zshrc -> ~/.zshrc
# config/vimrc -> ~/.vimrc
# config/starship.toml -> ~/.config/starship.toml
```

3. Restart the shell
