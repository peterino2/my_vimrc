import os 
import pathlib 
import subprocess
import shutil
import argparse


orig_dir = os.path.dirname(os.path.abspath(__file__))
repo_dir = orig_dir
user_path = os.path.abspath(str(pathlib.Path.home()))
colors_path = os.path.join(user_path, 'Appdata/Local/nvim/colors')

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

def setup_neovide(args):

    if os.name == 'nt':
        os.makedirs(colors_path, exist_ok=True)

        shutil.copy(os.path.join(orig_dir, 'hc_burn.vim'), colors_path)
        os.makedirs(os.path.join(user_path, 'Appdata/Local/nvim'), exist_ok=True)
        shutil.copy(os.path.join(orig_dir, 'ginit.vim'), os.path.join(user_path, 'Appdata/Local/nvim/'))

        skip_nvim_mod = False

        try:
            with open(os.path.join(user_path, 'Appdata/Local/nvim/init.vim')) as f:
                x = f.readlines()
                for i in x:
                    if 'base.vim' in i:
                        skip_nvim_mod = True
                        print("Skippinng config modificiation")
                        break
        except FileNotFoundError:
            pass

        if not skip_nvim_mod:
            with open(os.path.join(user_path, 'Appdata/Local/nvim/init.vim'), 'a+') as f:
                f.write(f'source {orig_dir}/base.lua')

        vim_user_path = os.path.join(user_path, '.vim/')

        if(not os.path.exists(os.path.join(user_path, '.vim/bundle/Vundle.vim'))):
            os.system('git clone https://github.com/VundleVim/Vundle.vim.git ' + os.path.join(user_path, '.vim/bundle/Vundle.vim')) # need vundle 

def setup_neovide_deps():
    if os.name == 'nt':
        os.system('scoop uninstall neovide')
        os.system('scoop install cmake')
        os.system('scoop install llvm')

def setup_neovide_dev(args):
    setup_neovide_deps()
    if not os.path.exists('~/neovide'):
        os.system(f'git clone https://github.com/neovide/neovide {os.path.join(user_path, "neovide")}')
    else:
        os.system('cd ~/neovide/ && git fetch && git pull && ' + \
                'git checkout -f')
    my_apps_path = os.path.abspath(os.path.join(user_path, 'my_apps'))
    os.makedirs(my_apps_path, exist_ok = True)
    os.system(f'cd {os.path.join(user_path, "neovide")} && cargo build --release')
    shutil.copy(os.path.join(user_path, 'neovide/target/release/neovide.exe'), f'{my_apps_path}')
    if os.name == 'nt':
        os.system('setx NEOVIDE_MULTIGRID "true"')
        print("Add ~/my_apps to PATH and you're good to go")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("--manjaro", help="executes the installer scripts for manjaro", action='store_true')
    args = parser.parse_args()
    install_dependencies(args)
    setup_neovide(args)
    setup_neovide_dev(args)
