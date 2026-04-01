REPO_URL="https://github.com/potapchuksa/netology-homework-17-virtualization-and-containerization-shvirtd-example-python.git"
DEPLOY_DIR="/opt/shvirtd-example"

if [ -d "$DEPLOY_DIR" ]; then
    sudo cd "$DEPLOY_DIR" && git pull
else
    sudo git clone "$REPO_URL" "$DEPLOY_DIR"
    sudo chown -R $USER:$USER "$DEPLOY_DIR"
    cd "$DEPLOY_DIR"
fi

[ ! -f ".env" ] && cat > .env << EOF
MYSQL_ROOT_PASSWORD=VeryStrongRoot123!
MYSQL_DATABASE=virtd
MYSQL_USER=app
MYSQL_PASSWORD=VeryStrongApp456!
EOF

docker compose down --remove-orphans 2>/dev/null || true
docker compose up -d --build
