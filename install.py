import os
import pathlib
import subprocess
import shutil
import argparse

orig_dir = os.path.dirname(os.path.abspath(__file__))
repo_dir = orig_dir
user_path = os.path.abspath(str(pathlib.Path.home()))

config_path = os.path.join(user_path, '.config/nvim')

if os.name == 'nt':
    config_path = os.path.join(user_path, 'Appdata/Local/nvim')

colors_path = os.path.join(config_path, 'colors')

def install_dependencies(args):
    if os.name == 'nt':
        os.system('powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"')
        os.system('powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"')
        os.system('powershell -Command "Invoke-Expression (New-Object System.Net.WebClient).DownloadString(\'https://get.scoop.sh\')')

        os.system('scoop install fzf')
        os.system('scoop install ripgrep')
        os.system('scoop install ctags')
        os.system('scoop bucket add extras')
        os.system('scoop install neovim')
        os.system('setx FZF_DEFAULT_COMMAND "rg --files --no-ignore-vcs --hidden"')
    else:
        if not args.skip_packages:
            if args.manjaro:
                os.system('yay -S fzf')
                os.system('yay -S ripgrep')
                os.system('yay -S ctags')
            else:
                # may need other stuff. 
                os.system('sudo apt install fzf')
                os.system('sudo apt install ripgrep')
                os.system('sudo apt install ctags')
                os.system('snap install neovim')

            should_set_vars = input("I want to set the Variable FZF_DEFAULT_COMMAND to 'rg --files --no-ignore-vcs --hidden' by appending it to your ~/.profile. do you want this? [Y/n]")
            if "y" in should_set_vars.lower():
                os.system('echo export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden" >> ~/.profile')
                print('done')
            else:
                print('not done')

def setup_neovim(args):
    os.makedirs(colors_path, exist_ok=True)
    os.makedirs(config_path, exist_ok=True)

    shutil.copy(os.path.join(orig_dir, 'hc_burn.vim'), colors_path)
    shutil.copy(os.path.join(orig_dir, 'ginit.vim'), config_path)

    skip_nvim_mod = False

    try:
        with open(os.path.join(config_path, 'init.vim')) as f:
            x = f.readlines()
            for i in x:
                if 'base.lua' in i:
                    skip_nvim_mod = True
                    print("Skippinng config modificiation")
                    break
    except FileNotFoundError:
        pass

    if not skip_nvim_mod:
        with open(os.path.join(config_path, 'init.vim'), 'a+') as f:
            f.write(f'source {orig_dir}/base.lua')

    vim_user_path = os.path.join(user_path, '.vim/')


    if (not os.path.exists("~/.local/share/nvim/site/pack/packer/start/packer.nvim")):
        if os.name == 'nt':
            pass
        if not skip_nvim_mod:
            with open(os.path.join(user_path, 'Appdata/Local/nvim/init.vim'), 'a+') as f:
                f.write(f'source {orig_dir}/base.lua')

        vim_user_path = os.path.join(user_path, '.vim/')


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    print(config_path)
    parser.add_argument("--manjaro", help="executes the installer scripts for manjaro", action='store_true')
    parser.add_argument("--skip-packages", help="skips trying to install packages", action='store_true')
    args = parser.parse_args()
    install_dependencies(args)
    setup_neovim(args)
