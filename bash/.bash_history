docker run --name repo alpine/git clone https://github.com/docker/getting-started.git
docker cp repo:/git/getting-started/ .
cd getting-started 
 docker build -t docker101tutorial . 
docker run -d -p 80:80 --name docker-tutorial docker101tutorial
code
vim ~/.bash_rc
vim ~/.bash_profile
zsh
zsh -c echo hi
zsh -c echo "hi"
zsh -cl echo "hi"
