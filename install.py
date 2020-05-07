import os 
import pathlib 
import subprocess
import argparse


def install_dependencies(args):
    if os.name == 'nt':
        os.system('powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"')
        os.system('powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"')
        os.system('powershell -Command "Invoke-Expression (New-Object System.Net.WebClient).DownloadString(\'https://get.scoop.sh\')')
        
        os.system('scoop install fzf')
        os.system('scoop install ripgrep')
        os.system('scoop install ctags')
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
            should_set_vars = input("I want to set the Variable FZF_DEFAULT_COMMAND to 'rg --files --no-ignore-vcs --hidden' by appending it to your ~/.profile. do you want this? [Y/n]")
            if "y" in should_set_vars.lower(): 
                os.system('echo export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden" >> ~/.profile')
                print('done')
            else:
                print('not done')

def setup_vimrc():
    repo_dir = os.getcwd()
    vim_path = os.path.join(str(pathlib.Path.home()), '.vim/')
    vimrc_path = os.path.join(str(pathlib.Path.home()), '.vimrc')
    colors_path = os.path.join(vim_path, 'colors' )
    if os.name == 'nt':
        vimrc_path = os.path.join(str(pathlib.Path.home()), '_vimrc')

    if(not os.path.exists(vim_path)):
        os.mkdir(vim_path)
        if(not os.path.exists(colors_path)):
            os.mkdir(colors_path)
        os.system('cp hc_burn.vim ' + colors_path)

    if(not os.path.exists(os.path.join(vim_path, 'bundle/Vundle.vim'))):
        os.system('git clone https://github.com/VundleVim/Vundle.vim.git ' + os.path.join(vim_path,'bundle/Vundle.vim')) # need vundle 

    if(not os.path.exists('install_file')):
        should_set_vars = input(f"I want prepend 'source {repo_dir}/base.vim' to your vimrc [Y/n]")
        if "y" in should_set_vars.lower(): 
            os.system(f'cp {vimrc_path} {vimrc_path}.backup')
            os.system(f'echo source {repo_dir}/base.vim > install_file')
            os.system(f'cat {vimrc_path} >> install_file')
            os.system(f'mv install_file {vimrc_path}')
            print('done')
        else:
            os.system('touch install_file')
            print('not done')

    os.system('vim +PluginInstall +qall')

parser = argparse.ArgumentParser()

parser.add_argument("--manjaro", help="executes the installer scripts for manjaro", action='store_true')

install_dependencies(parser.parse_args())
setup_vimrc()
print("its all good now. have a gander at the readme")

