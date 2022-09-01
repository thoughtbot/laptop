#!/bin/bash

# Welcome to the linux laptop script! Be prepared to turn your laptop (or
# desktop, no haters here) into an awesome development machine.

is_installed(){
 if command -v $1 &> /dev/null
 then
	 true
  else
	  false
  fi
}

install_linux_required(){
	# gcc
	sudo apt update 
	sudo apt install -y gcc gnupg lsb-release libxslt1-dev libcurl4-openssl-dev libksba8 libksba-dev libreadline-dev build-essential apt-transport-https ca-certificates
}

install_tools_required(){
	# install screen, tmux, dnsutils, telnet, nslookup
	sudo apt install -y screen tmux telnet dnsutils curl wget make net-tools
    	if ! command -v arkade &> /dev/null
    	then	
		curl -sLS https://get.arkade.dev | sudo sh
		echo 'export PATH=$PATH:$HOME/.arkade/bin/' >> ~/.bashrc
	fi
}

install_golang(){
	echo "install_golang"
	if is_installed go 
	then
		echo "Golang is already installed"
		go version
	else
		echo "Install go"
   	        sudo arkade system install go
	fi	
}

install_docker(){

    if is_installed docker
    then
	echo "Docker already installed"
        return 
    fi	
    
    echo "Installing Docker"
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    sudo apt-get install docker-compose-plugin

#    echo "Adding DNS Domain in docker daemon"
#    DNS_DOMAIN=$(systemd-resolve --status | grep "DNS Servers" | cut -d ":" -f 2)
# bash -c "cat <<EOF >/etc/docker/daemon.json
##{
#    \"dns\": [\"$DNS_DOMAIN\"]
#}
#EOF"
    sudo systemctl enable docker --now
    sudo systemctl enable containerd --now
    sudo systemctl restart docker
    
    echo "Adding user to docker"
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker	
}


install_k8s(){
	echo "Install k8s"
	if ! is_installed kind
	then
		arkade get kind
	fi
	if ! is_installed kubectl
	then
		arkade get kubectl
	fi
	if ! is_installed helm
	then
		arkade get helm
	fi
}

install_aws_cli(){
 	if ! command -v aws &> /dev/null
       	then
           echo "Installing AWS CLI"
           curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
           unzip -q /tmp/awscliv2.zip -d /tmp/
           /tmp/aws/install
           aws --version
      	else
          echo "aws cli already installed";
      	fi
}

install_starship_rs(){
	# Install and configure the shell
	echo "install starship_rs"

	if ! is_installed starship 
	then
		curl -sS https://starship.rs/install.sh | sh
		echo 'eval "$(starship init bash)"' >> ~/.bashrc
	fi
}

install_miscellaneous(){
	echo "install miscellaneous"
	#kompse, kubectl plugins, git plugins eg. lazygit, lazydocker, fzf
	if ! is_installed fzf
	then
		arkade get fzf
	fi
	if ! is_installed kubectx
	then
		arkade get kubectx
	fi
	if ! is_installed kubens
	then
		arkade get kubens
	fi
	if ! is_installed lazydocker
	then
		wget -O /tmp/lazydocker.tar.gz  https://github.com/jesseduffield/lazydocker/releases/download/v0.18.1/lazydocker_0.18.1_Linux_x86.tar.gz
		mkdir /tmp/lazydocker
		tar -xvzf /tmp/lazydocker.tar.gz -C /tmp/lazydocker
		sudo mv /tmp/lazydocker/lazydocker /usr/bin/lazydocker
		sudo chmod +x /usr/bin/lazydocker
			sudo rm -rf /tmp/lazydocker*
	fi
	if ! is_installed hadolint
	then
		sudo wget -O /usr/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.10.0/hadolint-Linux-x86_64
		sudo chmod +x /usr/bin/hadolint
	fi
}

main(){
	install_linux_required
	install_tools_required
	install_golang
	install_docker
	install_k8s
	install_starship_rs
	install_miscellaneous
}

main
