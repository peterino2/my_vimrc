import os 
import pathlib 
import subprocess


def install_dependencies():
    if os.name == 'nt':
        os.system('powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"')
        os.system('powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"')
        os.system('powershell -Command "Invoke-Expression (New-Object System.Net.WebClient).DownloadString(\'https://get.scoop.sh\')')
        
        os.system('scoop install fzf')
        os.system('scoop install ripgrep')
        os.system('scoop install ctags')
        os.system('setx FZF_DEFAULT_COMMAND "rg --files --no-ignore-vcs --hidden"')
    else: 
        # may need other stuff. 
        os.system('sudo apt install fzf')
        os.system('sudo apt install ripgrep')
        os.system('sudo apt install ctags')
        should_set_vars = input("I want to set the Variable FZF_DEFAULT_COMMAND to 'rg --files --no-ignore-vcs --hidden' by appending it to your ~/.bashrc you allow this? [Y/n]")
        if "y" in should_set_vars.lower(): 
            os.system('echo export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden"')
            print('done')
        else:
            print('not done')
        
        print("if $TERMINAL is not set, you will probably want to set it to your favorite terminal, one of my hotkeys opens $TERMINAL on the current file, I find this useful.")

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
        os.system('git clone https://github.com/VundleVim/Vundle.vim.git ' + vim_path) # need vundle 

    os.system(f'echo source {repo_dir}/base.vim >> {vimrc_path}')

    os.system('vim +PluginInstall +qall')

install_dependencies()
setup_vimrc()
print("its all good now. have a gander at the readme")

