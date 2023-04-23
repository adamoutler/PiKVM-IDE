sudo bash .vscode/helpers/link-code-to-system.sh;
if [ ! $(which pug) ]; then
	sudo pacman -Syu npm;
	sudo npm install pug htmlhint @babel/eslint-parser eslint -g;
	sudo npm install pug-cli -g;
fi
cd ../kvmd
pug --pretty web/index.pug -o web;
pug --pretty web/login/index.pug -o web/login;
pug --pretty web/kvm/index.pug -o web/kvm;
pug --pretty web/ipmi/index.pug -o web/ipmi;
pug --pretty web/vnc/index.pug -o web/vnc;
echo "restarting kvmd service";
sudo systemctl restart kvmd;
echo "done building site.";
cd -